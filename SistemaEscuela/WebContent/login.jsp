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
	<h1>Login</h1>
	<%	String error = "";
	if (session.getAttribute("error") != null) {
		error = (String)session.getAttribute("error");
		session.setAttribute("error", "");
		//hola
	} 
 %>
	<form action="login" method="post" class="elegant-aero">				
		<table>
			<tr>
				<td>Usuario:</td>
				<td><input type="text" name="usuario"></td>
				<td><%= error %></td>
			</tr>
			<tr>
				<td>Contraseña:</td>
				<td><input type="password" name="contraseña"></td>
			</tr>
		</table>
		<br> <input type="submit" value="Ingresar">
	</form>
</body>
</html>
