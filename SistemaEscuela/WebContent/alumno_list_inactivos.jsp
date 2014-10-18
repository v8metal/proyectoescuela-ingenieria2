<%@page import="conexion.AccionesAlumno"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.EstadoAlumno"%>
<%@page import="datos.EstadoAlumnos"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<%
	if (session.getAttribute("admin") != null) {
		
		String error = "";
		if (session.getAttribute("error") != null) {
			error = (String)session.getAttribute("error");
			session.setAttribute("error", "");
		}
%>
<title>Alumnos dados de baja</title>
</head>
<body>
<%
		EstadoAlumnos alumnos_inactivos = (EstadoAlumnos)session.getAttribute("alumnos_inactivos");

		if (alumnos_inactivos.getLista().isEmpty()) {
		
%>
<center>
<h3>No hay alumnos inactivos</h3>
<form action="menu_alumnos.jsp" method="post">
<input type="submit" value="Volver">
</form>
</center>
<%		
		} else {
%>
<h1>Alumnos dados de baja</h1>
<% 
			if (!error.equals("")) {
%>
<%=error%>
<br>
<br>
<%
			}
%> 	
<table border="2" bordercolor="666">
	<tr>
		<th>Nº</th>
		<th>APELLIDO Y NOMBRES</th>
		<th>D.N.I.</th>
		<th>FECHA DE BAJA</th>
		<th>&nbsp;</th>
	</tr>
<% 			int i = 0;
			for (EstadoAlumno ea : alumnos_inactivos.getLista()) {
				Alumno a = AccionesAlumno.getOne(ea.getDni());
				i++;
%>
	<tr>
		<td><center><%=i%></center></td>
		<td><%= a.getApellido() + ", " + a.getNombre() %></td>
		<td><%= ea.getDni() %></td>
		<td><center><%= ea.getFecha() %></center></td>
		<td><a name="activate-link" href="alumnoInactivo?do=activar&dni_alum=<%= a.getDni() %>" >ACTIVAR</a></td>	
	</tr>
<%
			}
 %>
</table>
<br>
<br>
<form action="menu_alumnos.jsp" method="post">
<input type="submit" value="Volver al menú">
</form>
<%
		}
		
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>