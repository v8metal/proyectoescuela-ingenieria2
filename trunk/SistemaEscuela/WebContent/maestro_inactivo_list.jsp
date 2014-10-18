<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Listado de Maestros</title>
</head>
<body>
<%
	if (session.getAttribute("admin") != null) {
		
		Maestros maestros = (Maestros)session.getAttribute("maestros");
		
		String error = "";
		if (session.getAttribute("error") != null) {
			error = (String)session.getAttribute("error");
			session.setAttribute("error", "");
		}
%>
<center>
<h1>Listado de Maestros Inactivos</h1>
<% 
			if (!error.equals("")) {
%>
<%=error%>
<br>
<br>
<%
			}
if (maestros.getLista().size() == 0){
%>
	<a> No hay maestros inactivos</a>
	<br>
	
<%}else{%>
<table border="2" bordercolor="666">
	<tr>		
		<th>Apellido y Nombres</th>
		<th>D.N.I.</th>
		<th>Domicilio</th>
		<th>Teléfono</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>		
	</tr>
<% 	
	for (Maestro m : maestros.getLista()) {
%>
	<tr>		
		<td><%= m.getApellido() + ", " + m.getNombre() %></td>
		<td><%= m.getDni() %></td>
		<td><%= m.getDomicilio() %></td>
		<td><%= m.getTelefono() %></td>		
		<td><a href="maestroEdit?accion=activar&dni=<%= m.getDni() %>">Activar</a></td>
		<td><a name="delete-link" href="maestroEdit?accion=borrar&dni=<%= m.getDni() %>" >Borrar</a></td>
	</tr>
<%
	}
 %>
</table>
<%}%>
<br>
<br>
<form action="maestroList" method="post">
<input type="submit" value="Volver al listado principal">
</form>
</center>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>