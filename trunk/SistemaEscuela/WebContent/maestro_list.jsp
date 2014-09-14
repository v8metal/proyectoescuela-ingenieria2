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
	if (session.getAttribute("login") != null) {
		
		String error = "";
		if (session.getAttribute("error") != null) {
			error = (String)session.getAttribute("error");
			session.setAttribute("error", "");
		}
%>
<center>
<h1>Listado de Maestros</h1>
<% 
			if (!error.equals("")) {
%>
<%=error%>
<br>
<br>
<%
			}
%>
<table border="2" bordercolor="666">
	<tr>
		<th>Código</th>
		<th>Apellido y Nombres</th>
		<th>D.N.I.</th>
		<th>Domicilio</th>
		<th>Teléfono</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
<% 
	Maestros maestros = (Maestros)session.getAttribute("maestros");
	for (Maestro m : maestros.getLista()) {
%>
	<tr>
		<td><center><%= m.getCod_maest() %></center></td>
		<td><%= m.getApellido() + ", " + m.getNombre() %></td>
		<td><%= m.getDni() %></td>
		<td><%= m.getDomicilio() %></td>
		<td><%= m.getTelefono() %></td>
		<td><a href="maestroEdit?do=modificar&codigo=<%= m.getCod_maest() %>">Modificar</a></td>
		<td><a name="delete-link" href="maestroEdit?do=baja&codigo=<%= m.getCod_maest() %>" >Borrar</a></td>
	</tr>
<%
	}
 %>
</table>
<br>
  	<a href="maestroEdit?do=alta">Agregar maestro</a>
<br>
<br>
<form action="menu_admin.jsp" method="post">
<input type="submit" value="Volver al menú">
</form>
</center>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>