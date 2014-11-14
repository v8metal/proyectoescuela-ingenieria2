<%@page import="conexion.AccionesCertificado"%>
<%@page import="datos.*"%>
<%@page import="java.util.*"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("pagina", "alumnos");%>

<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "alumno_list.jsp") != 1){							
		response.sendRedirect("Login");						
	}
	
	String titulo = (String) session.getAttribute("titulo_alumno");
%>
<title><%="Certificados - " + titulo%></title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/menu_admin.js"></script>

</head>
<body>	

<div class="container"> 

<div id="divmenu"></div>

<div class="page-header">
<h1>Certificados</h1>
</div>
<h3><%=titulo%></h3>

<br>
<table class="table table-hover table-bordered">
	<thead>
	<tr>
		<th>Nº</th>
		<th>Apellido y Nombres</th>
		<th>Salud</th>
		<th>Bucal</th>
		<th>Auditivo</th>
		<th>Visual</th>
		<th>Vacunas</th>
		<th>D.N.I.</th>
		<th>Observaciones</th>
	</tr>
	<thead>	
<% 
	int i = 0;
	int año = (Integer) session.getAttribute("año");
	Alumnos alumnos = (Alumnos)session.getAttribute("alumnos_alumno");
	
	for (Alumno a : alumnos.getLista()) {	
		Certificado c = AccionesCertificado.getOneByDniYAño(a.getDni(), año);
		i++;
%>
	<tbody>
	<tr><td><%=i%></td>
		<td><%= a.getApellido() + ", " + a.getNombre() %></td>
		<td><input type="checkbox" name="ind_salud" disabled 
			<%= c.isInd_salud() ? "checked" : "" %> /></td>
		<td><input type="checkbox" name="ind_bucal" disabled 
			<%= c.isInd_bucal() ? "checked" : "" %> /></td>
		<td><input type="checkbox" name="ind_auditivo" disabled 
			<%= c.isInd_auditivo() ? "checked" : "" %> /></td>
		<td><input type="checkbox" name="ind_visual" disabled 
			<%= c.isInd_visual() ? "checked" : "" %> /></td>	
		<td><input type="checkbox" name="ind_vacunas" disabled 
			<%= c.isInd_vacunas() ? "checked" : "" %> /></td>	
		<td><input type="checkbox" name="ind_dni" disabled 
			<%= c.isInd_dni() ? "checked" : "" %> /></td>
		<td><a href="certificadoEdit?from=certificado_list&do=modificar&dni=<%= a.getDni() %>">Ver</a></td>				
	</tr>
	<tbody>
<%	
	}
 %>
</table>
<br>
<form action="alumno_list.jsp" method="post">
<button type="submit" class="btn btn-primary"  value="Volver">Volver</button>
</form>
</div>
</body>
</html>