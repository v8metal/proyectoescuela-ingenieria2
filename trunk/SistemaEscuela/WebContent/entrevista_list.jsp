<%@page import="datos.Entrevista"%>
<%@page import="datos.Entrevistas"%>
<%@page import="datos.Maestro"%>
<%@page import="conexion.AccionesMaestro"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de Entevistas</title>
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<body>
<div class="container">
<%

if(session.getAttribute("admin")!=null || session.getAttribute("usuario")!=null){
	
session.removeAttribute("entrevista_edit");
session.removeAttribute("maestros_ent_alta");
Entrevistas entrevistas = (Entrevistas)session.getAttribute("entrevistas");
%>
<div class="page-header">
<%  
if (entrevistas.getLista().isEmpty()){
%>
<h1>No hay entrevistas cargadas</h1>
</div>
<%}else{%> 
<h1>Listado de Entrevistas</h1>
</div>
<table class="table table-hover table-bordered">
	<tr>
		<th>Fecha</th>
		<th>Hora</th>
		<th>Maestro</th>
		<th>Nombre Alumno</th>		
		<th>Descripción</th>		
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
<%
	Maestro m = new Maestro();	
	for (Entrevista e : entrevistas.getLista()) {
		
		m = AccionesMaestro.getOne(e.getdniMaestro());
		
		String fecha_entrevista = e.getFecha();		
		String[] fecha_ent = fecha_entrevista.split ("-");
		String dia = fecha_ent[fecha_ent.length - 1];
		String mes = fecha_ent[fecha_ent.length - 2];
		String año = fecha_ent[fecha_ent.length - 3];
%>
	<tr>
		<td><%= dia +"/" + mes + "/" + año %></td>		
		<td><%= e.getHora().substring(0,5)%></td>
		<td><%= m.getNombre() + " " + m.getApellido() %></td>
		<td><%= e.getNombre() %></td>	
		<td><%= e.getDescripcion() %></td>		
		<td><a href="EntrevistaEdit?do=modificar&fecha=<%=e.getFecha()%>&nombre=<%=e.getNombre()%>&hora=<%=e.getHora()%>">Modificar</a></td>		
		<td><a href="EntrevistaEdit?do=borrar&fecha=<%=e.getFecha()%>&nombre=<%=e.getNombre()%>&hora=<%=e.getHora()%>"  onclick="return confirm('Esta seguro que desea borrar la entrevista?');">Borrar</a></td>				
	</tr>
<%
	}
 %>
</table>
<%}
if(session.getAttribute("admin") != null){
	%>
	<br>
	<center>
	<a href="EntrevistaEdit?do=alta">Agregar Entrevista</a>
	</center>	
	<br>
	<br>
	<div class="form-group">
	<form action="menu_admin.jsp" method="post">
	<button type="submit" class="btn btn-primary"  value="Volver al Menú Principal">Volver al menú</button>
	</form>
	</div>
	<%
}else{
	%>
	<br>
	<br>
	<div class="form-group">
	<form action="menu_user.jsp" method="post">
	<button type="submit" class="btn btn-primary"  value="Volver al Menú Principal">Volver al menú</button>
	</form>	
	<%
}
%>


<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</div>
</body>
</html>