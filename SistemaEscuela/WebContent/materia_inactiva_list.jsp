<%@page import="datos.Materia"%>
<%@page import="datos.Materias"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
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
		
		Materias materias = (Materias)session.getAttribute("materiasbaja");
%>
<center>
<h1>Listado de Materias en inactivas</h1>
<% 
			if (!error.equals("")) {
%>
<%=error%>
<br>
<br>
<%
			}

if (materias.getLista().isEmpty()){ %>

<a> No hay materias en estado de baja</a>
	
<%}else{%>
<table border="2" bordercolor="666">
	<tr>
		<th>Materia</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
<% 	
	for (Materia m : materias.getLista()) {
%>
	<tr>
		<td><%= m.getMateria() %></td>
		<td><a href="materiaEdit?do=activar&materia=<%= m.getMateria() %>">Activar Materia</a></td>	
	</tr>
<%
	}
 %>
</table>
<%}%>
<br>
<br>
<form action="materiaList?from=menu_admin" method="post">
<input type="submit" value="Volver al atrás">
</form>
</center>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>