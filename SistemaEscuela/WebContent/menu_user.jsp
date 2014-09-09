<%@ page import="datos.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Menú Usuario</title>
</head>
<body>
<%
	if (session.getAttribute("login") != null) {
		
		Maestro maestro = (Maestro)session.getAttribute("maestro");
		String titulo = "Bienvenido/a " + maestro.getNombre();
%>
<center>
<h1><%= titulo %></h1>
<strong><a href="menu_sanciones.jsp">Sanciones</a><br></strong>
<strong><a href="menu_asistencias.jsp">Asistencias</a><br></strong>
<strong><a href="nota_menu.jsp">Notas</a><br></strong>
<strong><a href="EntrevistaList">Entrevistas</a><br></strong>
<strong><a href="menu_citaciones.jsp">Citaciones</a><br></strong>
<strong><a href="admin_user.jsp">Administración de cuenta</a><br></strong>
<br>
<form action="cerrarSesion" method="post">
<input type="submit" value="Cerrar sesion">
</form>
</center>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>