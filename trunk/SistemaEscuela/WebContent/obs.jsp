<%@page import="datos.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Editar Observaciones</title>
</head>
<body>
<%
	if (session.getAttribute("admin") != null) {
		
	//	Alumno a = (Alumno)session.getAttribute("alumno");
		Observaciones o = (Observaciones)session.getAttribute("observaciones");
%>
<br>
<%
	if (o.getLista().isEmpty()) {
%>
<p>No hay observaciones cargadas</p>
<%
	} else {
%>
<table border="2" bordercolor="666">
	<tr>
		<th>Nº</th>
		<th>OBSERVACIONES</th>
		<th>&nbsp;</th>
	</tr>
<%	int i = 0;
	for (Observacion ob : o.getLista()){
		i++;
%>	
	<tr>
		<td><center><%=i%></center></td>
		<td><%= ob.getObservaciones() %></td>
		<td><a href="certificadoEdit?from=obs&do=eliminar&obs=<%= ob.getObservaciones() %>" >Eliminar</a></td>
	</tr>
<%	
	}
%>
</table>
<%
	}	
%>
<br>
Ingrese nueva observación:
<br>
<form action="certificadoEdit?from=obs" method="post">
<textarea name="obs_nueva" rows="4" cols="50"></textarea>
<br>
<br>
<input type="submit" value="Guardar">
</form>
<br>
<form action="certificado_list.jsp" method="post">
<input type="submit" value="Volver">
</form>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>