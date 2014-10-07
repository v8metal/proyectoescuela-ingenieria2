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
	
<%}else{%>
<table border="2" bordercolor="666">
	<tr>
		<th>Código</th>
		<th>Nombre</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
<% 	
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
<%}%>
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