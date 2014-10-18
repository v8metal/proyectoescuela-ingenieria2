<%@page import="conexion.AccionesMaestro"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="datos.Usuario"%>
<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@page import="datos.Usuarios"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Gestión de usuarios</title>
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<body>
<div class="container">
<%
	if (session.getAttribute("admin") != null) {
		String titulo = (String)session.getAttribute("titulo");
		Usuarios usuarios = (Usuarios) session.getAttribute("usuarios");
		Maestros maestros = (Maestros) session.getAttribute("activos");
%>
<div class="page-header">  
	<h1>Listado de usuarios registrados</h1>
</div>
<%  
		if (usuarios.getLista().isEmpty()) {
%>
<p>No hay usuarios registrados<p>
<%
		} else {
%>
<table class="table table-hover table-bordered">
	<tr>		
		<th>Maestro</th>
		<th>Usuario</th>
		<th>Contraseña</th>
		<th>&nbsp;</th>
	</tr>
<% 	
	int i = 0;
	for (Usuario u : usuarios.getLista()) {
	Maestro m = AccionesMaestro.getOne(u.getCod_maest());
	i++;
%>
	<tr>		
		<td><%= m.getApellido() + ", " + m.getNombre() %></td>
		<td><%= u.getUsuario() %></td>
		<td><%= u.getContraseña() %></td>
		<td><a name="delete-link" href="registroUser?do=baja&usuario=<%= u.getUsuario() %>" onclick="return confirm('Esta seguro que desea borrar?');">Borrar</a></td>
	</tr>
<%
	}
 %>
</table>
<%
		}
%>
<br>
<%if ((usuarios.getLista().size() < maestros.getLista().size()) ) { //aca agregar a futuro los maestros activos%> 

  	<a href="registro_user.jsp?">Registrar nuevo usuario</a>
<%}else{%>

	<a>Todos los maestros están registrados</a>
<%}%>
<br>
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