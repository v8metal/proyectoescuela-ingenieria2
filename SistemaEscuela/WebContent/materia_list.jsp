<%@page import="datos.Materia"%>
<%@page import="datos.Materias"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Listado de Materias</title>
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
<h1>Listado de Materias</h1>
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
		<th>Nombre</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
<% 
	Materias materias = (Materias)session.getAttribute("materias");
	for (Materia m : materias.getLista()) {
%>
	<tr>
		<td><center><%= m.getCod_materia() %></center></td>
		<td><%= m.getNombre() %></td>
		<td><a href="materiaEdit?do=modificar&codigo=<%= m.getCod_materia() %>">Modificar</a></td>
		<td><a name="delete-link" href="materiaEdit?do=baja&codigo=<%= m.getCod_materia() %>" >Borrar</a></td>
	</tr>
<%
	}
 %>
</table>
<br>
  	<a href="materiaEdit?do=alta">Agregar materia</a>
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