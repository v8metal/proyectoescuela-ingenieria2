<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de maestros</title>
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<body>

<div class="container">
  
  <div class="page-header">  
	<h1>Listado de Maestros Inactivos</h1>
  </div>
<%
	if (session.getAttribute("admin") != null) {
		
		Maestros maestros = (Maestros)session.getAttribute("maestros");
		
		String error = "";
		if (session.getAttribute("error") != null) {
			error = (String)session.getAttribute("error");
			session.setAttribute("error", "");
		}
 
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
<table class="table table-hover table-bordered">
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
		<td><a href="maestroEdit?accion=activar&dni=<%= m.getDni() %>" onclick="return confirm('Esta seguro que desea activar?');">Activar</a></td>
		<td><a name="delete-link" href="maestroEdit?accion=borrar&dni=<%= m.getDni() %>" onclick="return confirm('Esta seguro que desea borrar?');">Borrar</a></td>
	</tr>
<%
	}
 %>
</table>
<%}%>
<br>
<br>
<center>
<div class="form-group">
<form action="maestroList" method="post">
<button type="submit" class="btn btn-primary"  value="Volver al listado principal">Volver al listado principal</button>
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