<%@page import="conexion.AccionesCertificado"%>
<%@page import="datos.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%
	if (session.getAttribute("login") != null) {
		String titulo = (String)session.getAttribute("titulo");
%>
<title><%="Certificados - " + titulo%></title>
</head>
<body>	
<table border="2" bordercolor="666">
	<tr>
		<th><%=titulo%></th><th>CERTIFICADOS</th>
	</tr>
</table>
<br>
<table border="2" bordercolor="666">
	<tr>
		<th>Nº</th>
		<th>APELLIDO Y NOMBRES DEL ALUMNO</th>
		<th>Salud</th>
		<th>Bucal</th>
		<th>Auditivo</th>
		<th>Visual</th>
		<th>Vacunas</th>
		<th>D.N.I.</th>
		<th>Observaciones</th>
	</tr>
<% 
	int i = 0;
	//recuero el año seleccionado desde la sesion
	int año = Integer.parseInt((String)session.getAttribute("año"));
	Alumnos alumnos = (Alumnos)session.getAttribute("alumnos");
	for (Alumno a : alumnos.getLista()) {
		//por cada alumno, recupero la lista de certificados correspondiente al año lectivo vigente
		Certificado c = AccionesCertificado.getOneByDniYAño(a.getDni(), año);
	//	Observaciones o = AccionesCertificado.getObservacionesByDni(a.getDni());
		i++;
%>
	<tr><td><center><%=i%></center></td>
		<td><%= a.getApellido() + ", " + a.getNombre() %></td>
		<td><center><input type="checkbox" name="ind_salud" disabled 
			<%= c.isInd_salud() ? "checked" : "" %> /></center></td>
		<td><center><input type="checkbox" name="ind_bucal" disabled 
			<%= c.isInd_bucal() ? "checked" : "" %> /></center></td>
		<td><center><input type="checkbox" name="ind_auditivo" disabled 
			<%= c.isInd_auditivo() ? "checked" : "" %> /></center></td>
		<td><center><input type="checkbox" name="ind_visual" disabled 
			<%= c.isInd_visual() ? "checked" : "" %> /></center></td>	
		<td><center><input type="checkbox" name="ind_vacunas" disabled 
			<%= c.isInd_vacunas() ? "checked" : "" %> /></center></td>	
		<td><center><input type="checkbox" name="ind_dni" disabled 
			<%= c.isInd_dni() ? "checked" : "" %> /></center></td>
		<td><center><a href="certificadoEdit?from=certificado_list&do=modificar&dni=<%= a.getDni() %>">Ver</a></center></td>				
	</tr>
<%	
	}
 %>
</table>
<br>
<form action="alumno_list.jsp" method="post">
<input type="submit" value="Volver">
</form>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>