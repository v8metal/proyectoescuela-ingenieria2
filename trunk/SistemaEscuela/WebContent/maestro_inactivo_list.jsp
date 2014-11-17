<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "maestros");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<!-- menú superior -->
<script src="js/menu_admin.js"></script> 

<title>Listado de maestros</title>
</head>
<body>

<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "menu_admin.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
%>

<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>
  
  
  <div class="page-header">
  
  <br>  
	<h1>Listado de Maestros Inactivos</h1>
  </div>
<%		
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
<br>	
<!-- MENSAJE INFORMATIVO -->
<div class="alert alert-info" role="alert">
    <strong>Atención!</strong> No hay maestros inactivos. <a href="maestroList" class="alert-link">Volver al listado principal</a>
</div>
<br>
<%}else{%>
<table class="table table-hover table-bordered">
	<thead>
	<tr class="active">		
		<th>Apellido y Nombres</th>
		<th>D.N.I.</th>
		<th>Domicilio</th>
		<th>Teléfono</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>		
	</tr>
	<thead>
<% 	
	for (Maestro m : maestros.getLista()) {
%>
	<tbody>
	<tr>		
		<td><%= m.getApellido() + ", " + m.getNombre() %></td>
		<td><%= m.getDni() %></td>
		<td><%= m.getDomicilio() %></td>
		<td><%= m.getTelefono() %></td>		
		<td><strong><a href="maestroEdit?accion=activar&dni=<%= m.getDni() %>" onclick="return confirm('Esta seguro que desea activar?');">Activar</a></strong></td>
		<td><strong><a name="delete-link" href="maestroEdit?accion=borrar&dni=<%= m.getDni() %>" onclick="return confirm('Esta seguro que desea borrar?');">Borrar</a></strong></td>
	</tr>
	<tbody>
<%
	}
 %>
</table>
<br>
<div class="form-group">
<form action="maestroList" method="post">
<button type="submit" class="btn btn-primary"  value="Volver al listado principal">Volver al listado principal</button>
</form>
</div>
<%}%>
</div>
</body>
</html>