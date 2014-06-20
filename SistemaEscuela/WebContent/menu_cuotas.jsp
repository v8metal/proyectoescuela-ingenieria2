<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sistema Alumnado</title>
</head>
<body>
<center>
<%
	session.setAttribute("cuota", null);
%>
  <br>
  <br>
  <br>
  <h1>Cuotas</h1>
  <a href="cuota_edit.jsp">Alta Cuota</a><br>
  <a href="cuota_list.jsp">Listar Cuotas</a>
  <br>
  <br>
  <a href="menu_admin.jsp">Volver al Menú Principal</a>
  <br>
  <br>
  <a href="CerrarSesion">Cerrar Sesión</a>
  </center>
</body>
</html>