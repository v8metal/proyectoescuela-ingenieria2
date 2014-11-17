<%@page import="conexion.AccionesAlumno"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.EstadoAlumno"%>
<%@page import="datos.EstadoAlumnos"%>
<%@page import="java.util.*"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "alumnos");%>

<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "alumno_list_inactivos.jsp") != 1){							
		response.sendRedirect("Login");						
	}	
		
	String error = "";
	if (session.getAttribute("error") != null) {
		error = (String)session.getAttribute("error");
		session.setAttribute("error", "");
	}
%>
<title>Alumnos dados de baja</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<!-- menú superior -->
<script src="js/menu_admin.js"></script>

</head>
<body>

<div class="container"> 

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>
  
<%
		EstadoAlumnos alumnos_inactivos = (EstadoAlumnos)session.getAttribute("alumnos_inactivos");

		if (alumnos_inactivos.getLista().isEmpty()) {
		
%>
<div class="page-header">
<h1>Alumnos Inactivos</h1>
</div>

<br>
<div class="alert alert-info" role="alert">
   <strong>Atención!</strong> No hay alumnos inactivos
</div>

<%		
		} else {
%>
<h1>Alumnos dados de baja</h1>
<% 
			if (!error.equals("")) {
%>
<div class="alert alert-danger" role="alert">
        <strong>Ups!</strong> <%=error%>
</div>
<br>
<br>
<%
			}
%> 	
<table class="table table-hover table-bordered">
	<thead>
	<tr class="active">
		<th>Nº</th>
		<th>APELLIDO Y NOMBRES</th>
		<th>D.N.I.</th>
		<th>FECHA DE BAJA</th>
		<th>&nbsp;</th>
	</tr>
	<thead>
<% 			int i = 0;
			for (EstadoAlumno ea : alumnos_inactivos.getLista()) {
				Alumno a = AccionesAlumno.getOne(ea.getDni());
				i++;
%>
	<tbody>
	<tr>
		<td><center><%=i%></center></td>
		<td><%= a.getApellido() + ", " + a.getNombre() %></td>
		<td><%= ea.getDni() %></td>
		<td><center><%= ea.getFecha() %></center></td>
		<td><strong><a name="activate-link" href="alumnoInactivo?do=activar&dni_alum=<%= a.getDni() %>" >ACTIVAR</a></strong></td>	
	</tr>
	</tbody>
<%
			}
 %>
</table>
<%}%>
</div>
</body>
</html>