<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
<title>Login</title>
</head>
<body>
<div class="container">
<%
	if (session.getAttribute("usuario") != null) {
%>
<div class="page-header"> 
<h1>Administración de usuario</h1>
</div>
<%	String error = "";
	if (session.getAttribute("error") != null) {
		error = (String)session.getAttribute("error");
		session.setAttribute("error", "");
	}
 %>
 <%= error %>
 <br>
 <br>
<div class="form-group">
<form action="AdminUser" method="post">
<table class="table table-hover table-bordered">	
	<tr>
		<td>Contraseña Actual: </td>
		<td><input type="password" class="form-control" name="contraseña_actual"></td> 
	</tr>
	<tr>
		<td>Nueva Contraseña: </td>
		<td><input type="password" class="form-control" name="contraseña_nueva"></td>
	</tr>
	<tr>
		<td>Repetir Contraseña: </td>
		<td><input type="password" class="form-control" name="contraseña_nueva_r"></td>
	</tr>
</table>
<br>
<button type="submit" class="btn btn-primary"  value="Cambiar contraseña">Cambiar contraseña</button>
</form>
</div>
<br>
<div class="form-group">
<form action="menu_user.jsp" method="post">
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