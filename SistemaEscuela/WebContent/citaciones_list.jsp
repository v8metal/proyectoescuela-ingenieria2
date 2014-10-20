<%@page import="datos.Alumno"%>
<%@page import="datos.Citacion"%>
<%@page import="datos.Citaciones"%>
<%@page import="conexion.AccionesAlumno"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<link rel="stylesheet" href="style/bootstrap.min.css">
<title>Listado de Citaciones</title>
</head>
<body>
<div class="container">
<%
	if (session.getAttribute("usuario") != null) {
	
		session.removeAttribute("citacion_edit");
		session.removeAttribute("alumnos_citacion");
		
		Citaciones citaciones  = (Citaciones)session.getAttribute("citaciones_list");	
		
		String volver = "citaciones_select.jsp?action=listar";		
		String method = "post";
		
		Boolean b = (session.getAttribute("exit_alta") != null);
		
		String exit = null;
		
		if (b){						
			volver = "CitacionEdit";			
			method = "get";
			exit= "salir";						
		}
%>
<center>
<%
if (citaciones.getLista().isEmpty()){	
%>
<div class="page-header"> 
<h1>No hay citaciones para el año seleccionado</h1>
</div>
<%	
}else{
%>
<div class="page-header"> 
<h1>Listado de Citaciones</h1>
</div>
<table class="table table-hover table-bordered">
	<tr>
		<th>Apellido y Nombres</th>
		<th>Grado</th>
		<th>Turno</th>				
		<th>Fecha</th>
		<th>Hora</th>
		<th>Descripción</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
<%	
	Alumno m = new Alumno();

	for (Citacion c : citaciones.getLista()) {
		
		m = AccionesAlumno.getOne(c.getDni());
		
		String fecha_entrevista = c.getFecha();		
		String[] fecha_ent = fecha_entrevista.split ("-");
		String dia = fecha_ent[fecha_ent.length - 1];
		String mes = fecha_ent[fecha_ent.length - 2];
		String año = fecha_ent[fecha_ent.length - 3];
%>
	<tr>
		<td><%= m.getApellido() + ", " + m.getNombre() %></td>
		<td><%= c.getGrado() %></td>
		<td><%= c.getTurno() %></td>		
		<td><%= dia +"/" + mes + "/" + año %></td>
		<td><%= c.getHora().substring(0,5) %></td>
		<td><%= c.getDescripcion() %></td>						
		<td><a href="CitacionEdit?do=modificar&dni_citacion=<%=c.getDni()%>&fecha_citacion=<%=c.getFecha()%>&hora_citacion=<%=c.getHora()%>&exit=<%=exit%>">Modificar</a></td>
		<td><a href="CitacionEdit?do=baja&dni_citacion=<%=c.getDni()%>&fecha_citacion=<%=c.getFecha()%>&hora_citacion=<%=c.getHora()%>&exit=<%=exit%>">Borrar</a></td>	</tr>
<%
	}
 %>
</table>
<%} %>
<br>
<div class="form-group">
<form action="<%=volver%>" method="<%=method%>">
<%if (b){%> 
<input type="hidden" name="accion" value="alta">
<%}%>
<button type="submit" class="btn btn-primary"  value="Volver">Volver</button>
</form>
</div>
</center>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</div>
</body>
</html>