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
	<h1>Listado de Maestros Activos</h1>
  </div>
<%
	if (session.getAttribute("login") != null) {
		
		Maestros maestros = (Maestros)session.getAttribute("maestros");
		Maestros maestros_inac = (Maestros)session.getAttribute("maestros_inac");
		
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
	<a href="maestroEdit?accion=alta">No hay maestros activos, agregar maestro</a>
	
<%}else{%>

<table class="table table-hover table-bordered">
	<tr>		
		<th>Apellido y Nombres</th>
		<th>D.N.I.</th>
		<th>Domicilio</th>
		<th>Teléfono</th>
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
		<td><a href="maestroEdit?accion=modificar&dni=<%= m.getDni() %>">Modificar Maestro</a></td>		
		<td><a href="maestroEdit?accion=baja&dni=<%= m.getDni() %>" onclick="return confirm('Esta seguro que desea dar de baja?');">Baja de Maestro</a></td>		
		<td><a href="maestroEdit?accion=borrar&dni=<%= m.getDni() %>" onclick="return confirm('Esta seguro que desea borrar?');">Borrar Maestro</a></td>		
	</tr>
<%
	}
 %>
</table>
<br>
    <a href="maestroEdit?accion=alta"> Agregar Maestro</a>
  	
 <%}%>
<br>
<%if(maestros_inac.getLista().size() != 0){%>
<br>
  	<a href="MaestroList?tipo=inactivos">Listado de maestros inactivos</a>
<br>
<%}%>
<br>
<div class="form-group">
<form action="menu_admin.jsp" method="post">
<button type="submit" class="btn btn-primary"  value="Volver al menú">Volver al menú</button>
</form>
</div>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</div>
</body>
</html>