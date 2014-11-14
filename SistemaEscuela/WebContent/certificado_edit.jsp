<%@page import="datos.*"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("pagina", "alumnos");%>

<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Editar Certificados</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/menu_admin.js"></script>

</head>
<body>
<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "certificado_edit.jsp") != 1){							
		response.sendRedirect("Login");						
	}

	String error = "";
	if (session.getAttribute("error") != null) {
		error = (String)session.getAttribute("error");
		session.setAttribute("error", "");
	}
	
	Alumno a = (Alumno)session.getAttribute("alumno");
	Certificado c = (Certificado)session.getAttribute("certificado");
	Observaciones o = (Observaciones)session.getAttribute("observaciones");
	String titulo = (String)session.getAttribute("titulo");
%>
<%= error %>

<div class="container"> 

<div id="divmenu"></div>
 
 <br>
 <br>

<div class="page-header">
<h1>Editar Certificados</h1>
</div>
<br>
<form action="certificadoEdit" method="post">
<table class="table table-hover table-bordered">
	<thead>
	<tr>
		<th>Apellido y Nombres</th>
		<th>Salud</th>
		<th>Bucal</th>
		<th>Auditivo</th>
		<th>Visual</th>
		<th>Vacunas</th>
		<th>D.N.I.</th>
	</tr>
	<thead>
	<tbody>
	<tr>
		<td><%= a.getApellido() + ", " + a.getNombre() %></td>
		<td><input type="checkbox" name="ind_salud" value="true" 
			<%= c.isInd_salud() ? "checked" : "" %> /></td>
		<td><input type="checkbox" name="ind_bucal" value="true"   
			<%= c.isInd_bucal() ? "checked" : "" %> /></td>
		<td><input type="checkbox" name="ind_auditivo" value="true"  
			<%= c.isInd_auditivo() ? "checked" : "" %> /></td>
		<td><input type="checkbox" name="ind_visual" value="true"  
			<%= c.isInd_visual() ? "checked" : "" %> /></td>	
		<td><input type="checkbox" name="ind_vacunas" value="true"  
			<%= c.isInd_vacunas() ? "checked" : "" %> /></td>	
		<td><input type="checkbox" name="ind_dni" value="true"  
			<%= c.isInd_dni() ? "checked" : "" %> /></td>
	</tr>
	</tbody>
</table>
<br>
<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave">Guardar</button>
</form>
<br>
<br>
<br>
<form action="alumno_list.jsp" method="post">
<button type="submit" class="btn btn-primary"  value="Volver" name="btnBack">Volver</button>
</form>
</div>
</body>
</html>