<%@page import="conexion.AccionesAlumno"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.Mensaje"%>
<%@page import="datos.EstadoAlumno"%>
<%@page import="datos.EstadoAlumnos"%>
<%@page import="java.util.*"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMensaje"%>
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
		
%>
<title>Alumnos - Registro de bajas</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">

</head>
<body>

<div class="container"> 

  <div id="divmenu">
  	<!-- sirve para visualizar el men� superior -->
  </div>
  
<%
		EstadoAlumnos alumnos_inactivos = (EstadoAlumnos)session.getAttribute("alumnos_inactivos");

		if (alumnos_inactivos.getLista().isEmpty()) {
		
%>
<div class="page-header">
	<h1>Registro de bajas</h1>
</div>

<br>
<% Mensaje m = AccionesMensaje.getOne(59); %>
<div class="alert alert-info" role="alert">
   <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
   <%=m.getMensaje()%>
</div>

<%		
		} else {
%>
<div class="page-header">
	<h1>Registro de bajas</h1>
</div>	
	
<table class="table table-hover table-bordered">
	<thead>
	<tr class="active">
		<th>Apellido y Nombres</th>
		<th>D.N.I.</th>
		<th>Fecha de baja</th>
		<th>&nbsp;</th>
	</tr>
	<thead>
<% 
			for (EstadoAlumno ea : alumnos_inactivos.getLista()) {
				Alumno a = AccionesAlumno.getOne(ea.getDni());
%>
	<tbody>
	<tr>
		<td><%= a.getApellido() + ", " + a.getNombre() %></td>
		<td><%= ea.getDni() %></td>
		<td><%= ea.getFecha() %></td>
		<td><strong><a name="activate-link" href="alumnoInactivo?do=activar&dni_alum=<%= a.getDni() %>" ><i class="glyphicon glyphicon-arrow-up"></i> Dar de alta</a></strong></td>	
	</tr>
	</tbody>
<%
			}
 %>
</table>
<%}%>
 <!-- MENSAJE -->
 <%	
	Mensaje mensaje = null;
	if (session.getAttribute("mensaje") != null) {
		mensaje = (Mensaje) session.getAttribute("mensaje");
		session.setAttribute("mensaje", null);
 %>
 <br>
   	<div class="bs-example">
    	 <div class="alert <%=mensaje.getTipo()%> fade in" role="alert">
     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <%= mensaje.getMensaje()%>
  	  </div>
  </div>
<br>
 <%}%>  
</div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

	<!-- men� superior -->
	<script src="js/menu_admin.js"></script>
</body>
</html>