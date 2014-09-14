<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
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
  <strong><a href="cuota_edit.jsp">Alta Cuota</a><br></strong>
  <strong><a href="cuota_list.jsp">Listar Cuotas</a></strong>
  <br>
  <br>
  <strong><a href="menu_admin.jsp">Volver al Menú Principal</a></strong>
  <br>
  <br>
  <strong><a href="CerrarSesion">Cerrar Sesión</a></strong>
  </center>
</body>
</html>