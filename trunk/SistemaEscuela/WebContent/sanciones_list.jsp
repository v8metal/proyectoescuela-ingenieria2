<%@page import="datos.Alumno"%>
<%@page import="datos.Sancion"%>
<%@page import="datos.Sanciones"%>
<%@page import="conexion.AccionesAlumno"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Listado de Sanciones</title>
</head>
<body>
<%
	if (session.getAttribute("login") != null) {
	
		session.removeAttribute("sancion_edit");
		session.removeAttribute("alumnos_sancion");
		
		Sanciones sanciones  = (Sanciones)session.getAttribute("sanciones_list");	
		
		String volver = "sanciones_select.jsp?action=listar";		
		String method = "post";
		
		Boolean b = (session.getAttribute("exit_alta") != null);
		
		String exit = null;
		
		if (b){						
			volver = "SancionEdit";			
			method = "get";
			exit= "salir";						
		}
%>
<center>
<%
if (sanciones.getLista().isEmpty()){	
%>
<h1>No hay sanciones para el año seleccionado</h1>
<%	
}else{
%>
<h1>Listado de Sanciones</h1>

<table border="2" bordercolor="666">
	<tr>
		<th>Apellido y Nombres</th>
		<th>Grado</th>
		<th>Turno</th>
		<th>Fecha</th>
		<th>Hora</th>
		<th>Motivo</th>		
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
<%	
	Alumno m = new Alumno();
	
	for (Sancion s : sanciones.getLista()) {
		
		m = AccionesAlumno.getOne(s.getDni());
		
		String fecha_entrevista = s.getFecha();		
		String[] fecha_ent = fecha_entrevista.split ("-");
		String dia = fecha_ent[fecha_ent.length - 1];
		String mes = fecha_ent[fecha_ent.length - 2];
		String año = fecha_ent[fecha_ent.length - 3];
%>
	<tr>
		<td><%= m.getApellido() + ", " + m.getNombre() %></td>
		<td><%= s.getGrado()%></td>
		<td><%= s.getTurno() %></td>		
		<td><%= dia +"/" + mes + "/" + año %></td>
		<td><%= s.getHora().substring(0,5) %></td>
		<td><%= s.getMotivo() %></td>		
		<td><a href="SancionEdit?do=modificar&dni_sancion=<%=s.getDni()%>&fecha_sancion=<%=s.getFecha()%>&hora_sancion=<%=s.getHora()%>&exit=<%=exit%>">Modificar</a></td>
		<td><a href="SancionEdit?do=baja&dni_sancion=<%=s.getDni()%>&fecha_sancion=<%=s.getFecha()%>&hora_sancion=<%=s.getHora()%>&exit=<%=exit%>">Borrar</a></td>	</tr>
<%
	}
 %>
</table>
<%} %>
<br>
<form action="<%=volver%>" method="<%=method%>">
<%if (b){%> 
<input type="hidden" name="accion" value="alta">
<%}%>
<input type="submit" value="Volver">
</form>
</center>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>