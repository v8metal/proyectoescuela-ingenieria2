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
<h1>Administraci�n de usuario</h1>
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
		<td>Contrase�a Actual: </td>
		<td><input type="password" class="form-control" name="contrase�a_actual"></td> 
	</tr>
	<tr>
		<td>Nueva Contrase�a: </td>
		<td><input type="password" class="form-control" name="contrase�a_nueva"></td>
	</tr>
	<tr>
		<td>Repetir Contrase�a: </td>
		<td><input type="password" class="form-control" name="contrase�a_nueva_r"></td>
	</tr>
</table>
<br>
<button type="submit" class="btn btn-primary"  value="Cambiar contrase�a">Cambiar contrase�a</button>
</form>
</div>
<br>
<div class="form-group">
<form action="menu_user.jsp" method="post">
<button type="submit" class="btn btn-primary"  value="Volver al men�">Volver al men�</button>
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