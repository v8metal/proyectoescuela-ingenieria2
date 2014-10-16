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
<body>

<div class="container">
  
  <div class="page-header">  
	<h1>Listado de Materias Activas</h1>
  </div>
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
<table class="table table-hover table-bordered">
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
		<td><a href="materiaEdit?do=baja&materia=<%= m.getMateria() %>" onclick="return confirm('Esta seguro que desea dar de baja?');">Baja de Materia</a></td>		
		<td><a href="materiaEdit?do=borrar&materia=<%= m.getMateria() %>"  onclick="return confirm('Esta seguro que desea borrar?');" >Borrar Materia</a></td>
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
<br>
<div class="form-group">
<form action="menu_admin.jsp" method="post">
<button type="submit" class="btn btn-primary"  value="Volver al menú">Volver al menú</button>
</form>
</div>
</center>
</div>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>