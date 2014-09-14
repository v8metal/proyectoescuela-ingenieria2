<%@page import="conexion.AccionesMaestro"%>
<%@ page import="datos.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Notas</title>
</head>
<body>
<%
	if (session.getAttribute("login") != null) {
		
		// recupero el año_sys de la sesion y lo utilizo como año lectivo
		int año = Integer.parseInt((String)session.getAttribute("año_sys"));
		
		Maestro maestro = (Maestro)session.getAttribute("maestro");
		String titulo = "Grados de " + maestro.getNombre() + " como titular";
		
		Grados grados = AccionesMaestro.getGradosTitular(maestro.getCod_maest());
%>
<center>
<h1><%= titulo %></h1>	
<%
			if (grados.getLista().isEmpty()) {
%>
<p>No hay grados cargados</p>
<%
			} else {
%>
<table border="2" bordercolor="666">
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

<form action="menu_user.jsp" method="post">
<input type="submit" value="Volver al menú">
</form>
<br>
<br>
<form action="cerrarSesion" method="post">
<input type="submit" value="Cerrar sesion">
</form>
</center>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>