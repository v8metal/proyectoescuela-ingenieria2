<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Alumnos</title>
</head>
<body>
<%
	if (session.getAttribute("login") != null) {
		session.setAttribute("grado", null);
%>
<center>
<h1>Alumnos</h1>
<strong><a href="alumno_edit.jsp">Ingresar nuevo alumno</a><br></strong>
<strong><a href="menu_listado_alum.jsp">Listado de alumnos</a><br></strong>
<strong><a href="alumnoInactivo?do=listar">Alumnos dados de baja</a><br></strong>
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