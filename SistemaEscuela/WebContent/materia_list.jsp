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
		
		Materias materias = (Materias)session.getAttribute("materias");
		Materias materiasbaja = (Materias)session.getAttribute("materiasbaja");		
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

if (materias.getLista().isEmpty()){ %>

<a href="materiaEdit?do=alta">No hay materias asignadas, agregar materias</a>
<br>
<br>
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
		<td><a href="materiaEdit?do=baja&materia=<%= m.getMateria() %>">Baja de Materia</a></td>
		<td><a name="delete-link" href="materiaEdit?do=borrar&materia=<%= m.getMateria() %>" >Borrar Materia</a></td>
	</tr>
<%
	}
 %>
</table>
<br>
  	<a href="materiaEdit?do=alta">Agregar materia</a>
<br>
<br>
<%}
if(materiasbaja.getLista().size() != 0){%>
 <a href="materiaList?from=materia_inactiva_list">Listado de materias inactivas</a> 
<br>
<br>
<%}%>
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