<%@page import="datos.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Editar Certificados</title>
</head>
<body>
<%
	if (session.getAttribute("admin") != null) {

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
<table border="2" bordercolor="666">
	<tr>
		<th>EDITAR CERTIFICADOS</th>
	</tr>
</table>
<br>
<form action="certificadoEdit" method="post">
<table border="2" bordercolor="666">
	<tr>
		<th>APELLIDO Y NOMBRES DEL ALUMNO</th>
		<th>Salud</th>
		<th>Bucal</th>
		<th>Auditivo</th>
		<th>Visual</th>
		<th>Vacunas</th>
		<th>D.N.I.</th>
	</tr>
	<tr>
		<td><%= a.getApellido() + ", " + a.getNombre() %></td>
		<td><center><input type="checkbox" name="ind_salud" value="true" 
			<%= c.isInd_salud() ? "checked" : "" %> /></center></td>
		<td><center><input type="checkbox" name="ind_bucal" value="true"   
			<%= c.isInd_bucal() ? "checked" : "" %> /></center></td>
		<td><center><input type="checkbox" name="ind_auditivo" value="true"  
			<%= c.isInd_auditivo() ? "checked" : "" %> /></center></td>
		<td><center><input type="checkbox" name="ind_visual" value="true"  
			<%= c.isInd_visual() ? "checked" : "" %> /></center></td>	
		<td><center><input type="checkbox" name="ind_vacunas" value="true"  
			<%= c.isInd_vacunas() ? "checked" : "" %> /></center></td>	
		<td><center><input type="checkbox" name="ind_dni" value="true"  
			<%= c.isInd_dni() ? "checked" : "" %> /></center></td>
	</tr>
</table>
<br>
<input type="submit" value="Guardar">
</form>
<br>
<br>
<br>
<form action="alumno_list.jsp" method="post">
<input type="submit" value="Volver">
</form>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>