<%@page import="datos.Materia"%>
<%@page import="datos.Materias"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de Materias</title>
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<div class="container">
<%
	if (session.getAttribute("admin") != null) {
		
		String error = "";
		if (session.getAttribute("error") != null) {
			error = (String)session.getAttribute("error");
			session.setAttribute("error", "");
		}
		
		Materias materias = (Materias)session.getAttribute("materiasbaja");
%>
<center>
  <div class="page-header">  
	<h1>Listado de Materias Inactivas</h1>
  </div>
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
<table class="table table-hover table-bordered">
	<tr>
		<th>Materia</th>
		<th>&nbsp;</th>		
	</tr>
<% 	
	for (Materia m : materias.getLista()) {
%>
	<tr>
		<td><%= m.getMateria() %></td>
		<td><a href="materiaEdit?do=activar&materia=<%= m.getMateria() %>" onclick="return confirm('Esta seguro que desea activar la materia?');">Activar Materia</a></td>	
	</tr>
<%
	}
 %>
</table>
<%}%>
<br>
<br>
<div class="form-group">
<form action="materiaList?from=menu_admin" method="post">
<button type="submit" class="btn btn-primary"  value="Volver al atrás">Volver al atrás</button>
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