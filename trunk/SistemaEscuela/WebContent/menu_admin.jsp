<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Menú Administrador</title>
</head>
<body>
<%
	if (session.getAttribute("login") != null) {
%>
<center>
<h1>Bienvenido Administrador</h1>
<strong><a href="menu_alumnos.jsp">Alumnos</a><br></strong>
<strong><a href="GradoList">Grados</a><br></strong>
<strong><a href="maestroList">Maestros</a><br></strong>
<strong><a href="materiaList?from=menu_admin">Materias</a><br></strong>
<strong><a href="menu_tardanzas.jsp">Tardanzas</a><br></strong>
<strong><a href="EntrevistaList">Entrevistas</a><br></strong>
<strong><a href="menu_precios.jsp">Menú de Precios</a><br></strong>
<strong><a href="menu_cuotas.jsp">Cobro de Cuotas</a><br></strong>
<strong><a href="menu_admin.jsp">Informes</a><br></strong>
<strong><a href="UsuarioList">Gestionar Usuarios</a><br></strong>
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
