<%@page import="conexion.AccionesMaestro"%>
<%@ page import="datos.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
<title>Notas</title>
</head>
<body>
 <div class="container">
<%
	if (session.getAttribute("usuario") != null) {
		
		// recupero el año_sys de la sesion y lo utilizo como año lectivo
		int año = Integer.parseInt((String)session.getAttribute("año_sys"));
		
		Maestro maestro = (Maestro)session.getAttribute("maestro");
		String titulo = "Grados de " + maestro.getNombre() + " como titular";
		
		Grados grados = AccionesMaestro.getGradosTitular(maestro.getDni());
%>
<center>
<div class="page-header">
</div>
<h1><%= titulo %></h1>	
<%
			if (grados.getLista().isEmpty()) {
%>
<div class="page-header">
<p>No hay grados cargados</p>
<br>
<%
			} else {
%>
<table class="table table-hover table-bordered">
	<tr>
		<th>Grado</th>
		<th>Turno</th>
		<th>Salón</th>
		<th>&nbsp;</th>
	</tr>
<% 	int i = 0;
	for (Grado g : grados.getLista()) {
		i++;
%>
	<tr>
		<td><center><%= g.getGrado() %></center></td>
		<td><%= g.getTurno() %></td>		
		<td><center><%= g.getSalon() %></center></td>	
		<td><a href="alumnoList?from=nota_menu&grado=<%= g.getGrado()%>&turno=<%= g.getTurno()%>&año=<%=año%>">Ver alumnos</a></td>
	</tr>
<%
	}
 %>
</table>
<br>
<%
			}
%>
 <div class="form-group">
<form action="menu_user.jsp" method="post">
<button type="submit" class="btn btn-primary">Volver al menú</button>
</form>
</div>
</center>
<br>
<br>
 <div class="form-group">
<form action="cerrarSesion" method="post">
<button type="submit" class="btn btn-primary">Cerrar sesion</button>
</form>
</div>

<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</div>
</body>
</html>