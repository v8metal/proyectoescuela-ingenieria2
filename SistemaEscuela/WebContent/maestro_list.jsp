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
		
		Maestros maestros = (Maestros)session.getAttribute("maestros");
		Maestros maestros_inac = (Maestros)session.getAttribute("maestros_inac");
		
		String error = "";
		if (session.getAttribute("error") != null) {
			error = (String)session.getAttribute("error");
			session.setAttribute("error", "");
		}
%>
<center>
<h1>Listado de Maestros Activos</h1>
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
	<a href="maestroEdit?accion=alta">No hay maestros activos, agregar maestro</a>
	
<%}else{%>

<table border="2" bordercolor="666">
	<tr>		
		<th>Apellido y Nombres</th>
		<th>D.N.I.</th>
		<th>Domicilio</th>
		<th>Tel�fono</th>
		<th>&nbsp;</th>
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
		<td><a href="maestroEdit?accion=modificar&dni=<%= m.getDni() %>">Modificar</a></td>
		<td><a href="maestroEdit?accion=baja&dni=<%= m.getDni() %>">Baja de Maestro</a></td>
		<td><a name="delete-link" href="maestroEdit?accion=borrar&dni=<%= m.getDni() %>" >Borrar</a></td>
	</tr>
<%
	}
 %>
</table>
<br>
  	<a href="maestroEdit?accion=alta">Agregar maestro</a>
 <%}%>
<br>
<%if(maestros_inac.getLista().size() != 0){%>
<br>
  	<a href="MaestroList?tipo=inactivos">Listado de maestros inactivos</a>
<br>
<%}%>
<br>
<form action="menu_admin.jsp" method="post">
<input type="submit" value="Volver al men�">
</form>
</center>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>