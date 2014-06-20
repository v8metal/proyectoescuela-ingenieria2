<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Grados</title>
</head>
<body>
<%
	if (session.getAttribute("login") != null) {
%>
<center>
<h1>Grados</h1>
<strong><a href="GradoEdit?do=alta">Ingresar nuevo Grado</a><br></strong>
<strong><a href="GradoList">Listar Grados</a><br></strong>
<br>
<form action="menu_admin.jsp" method="post">
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