<%@page import="conexion.AccionesMaestro"%>
<%@page import="datos.Usuario"%>
<%@page import="datos.Maestro"%>
<%@page import="datos.Usuarios"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<%
	if (session.getAttribute("login") != null) {
		String titulo = (String)session.getAttribute("titulo");
%>
<title>Gestión de usuarios</title>
</head>
<body>
<h1>Listado de Usuarios</h1>
<%
		Usuarios usuarios = (Usuarios)session.getAttribute("usuarios");
		if (usuarios.getLista().isEmpty()) {
%>
<p>No hay usuarios registrados<p>
<%
		} else {
%>
<table border="2" bordercolor="666">
	<tr>
		<th>Nº</th>
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
		<td><center><%=i%></center></td>
		<td><%= m.getApellido() + ", " + m.getNombre() %></td>
		<td><%= u.getUsuario() %></td>
		<td><%= u.getContraseña() %></td>
		<td><a name="delete-link" href="registroUser?do=baja&usuario=<%= u.getUsuario() %>" >Borrar</a></td>
	</tr>
<%
	}
 %>
</table>
<%
		}
%>
<br>
  	<a href="registro_user.jsp?">Registrar nuevo usuario</a>
<br>
<br>
<form action="menu_admin.jsp" method="post">
<input type="submit" value="Volver al menú">
</form>
<%		
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>