<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Login</title>
</head>
<body>
<h1>Administraci�n de usuario</h1>
<%	String error = "";
	if (session.getAttribute("error") != null) {
		error = (String)session.getAttribute("error");
		session.setAttribute("error", "");
	}
 %>
<form action="AdminUser" method="post">
<table>	
	<tr>
		<td>Contrase�a Actual: </td>
		<td><input type="password" name="contrase�a_actual"></td> 
		<td><%= error %></td>
	</tr>
	<tr>
		<td>Nueva Contrase�a: </td>
		<td><input type="password" name="contrase�a_nueva"></td>
	</tr>
	<tr>
		<td>Repetir Contrase�a: </td>
		<td><input type="password" name="contrase�a_nueva_r"></td>
	</tr>
</table>
<br>
<input type="submit" value="Cambiar contrase�a">
</form>
<br>
<strong><a href="menu_user.jsp">Volver al men�</a><br></strong>
</body>
</html>