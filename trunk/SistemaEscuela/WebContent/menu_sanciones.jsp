<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Sanciones</title>
</head>
<body>
<%
	if (session.getAttribute("login") != null) {
		
		session.removeAttribute("exit_alta");		
%>
<center>
<h1>Sanciones</h1>
<strong><a href="SancionEdit?do=alta">Alta de sanciones</a><br></strong>
<strong><a href="sanciones_select.jsp?action=listar">Listado de Sanciones</a><br></strong>
<br>
<form action="menu_user.jsp" method="post">
<input type="submit" value="Volver">
</form>
<br>
<br>
<br>
</center>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>