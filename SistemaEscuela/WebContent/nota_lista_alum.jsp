<%@page import="conexion.AccionesGrado"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="datos.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<%
	if (session.getAttribute("usuario") != null) {
		String titulo = (String)session.getAttribute("titulo");
%>
<title>Notas - <%=titulo%></title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</head>
<body>	
<table border="2" bordercolor="666">
	<tr>
		<th><%=titulo%></th><th>LISTADO</th>
	</tr>
</table>
<br>
<table border="2" bordercolor="666">
<% 	int i = 0;
	String grado = (String)session.getAttribute("grado"); //recupero el grado para listar a los alumnos de ese
	Grado g = AccionesGrado.getOne(grado);	//recupero el objeto grado para saber si es bimestral o trimestral
	Alumnos alumnos = (Alumnos)session.getAttribute("alumnos");
%>
	<tr>
		<th>Nº</th>
		<th>APELLIDO Y NOMBRES DEL ALUMNO</th>
		<%
			if (g.getBimestre()){
		%>
		<th>1º Bimestre</th>
		<th>2º Bimestre</th>
		<th>3º Bimestre</th>
		<th>4º Bimestre</th>
		<%
			} else {		
		%>
		<th>1º Trimestre</th>
		<th>2º Trimestre</th>
		<th>3º Trimestre</th>
		<%
			}
		%>
	</tr>
<%	
	for (Alumno a : alumnos.getLista()) {
		i++;		
%>	
	<tr>
		<td><center><%=i%></center></td>
		<td><%= a.getApellido() + ", " + a.getNombre() %></td>
		<%
			if (g.getBimestre()){
		%>
		<td><center><a href="materiaList?from=nota_lista_alum&do=listar&grado_list=<%= g.getGrado() %>&dni=<%= a.getDni() %>&periodo=1er Bimestre">Notas</a></center></td>
		<td><center><a href="materiaList?from=nota_lista_alum&do=listar&grado_list=<%= g.getGrado() %>&dni=<%= a.getDni() %>&periodo=2do Bimestre">Notas</a></center></td>
		<td><center><a href="materiaList?from=nota_lista_alum&do=listar&grado_list=<%= g.getGrado() %>&dni=<%= a.getDni() %>&periodo=3er Bimestre">Notas</a></center></td>
		<td><center><a href="materiaList?from=nota_lista_alum&do=listar&grado_list=<%= g.getGrado() %>&dni=<%= a.getDni() %>&periodo=4to Bimestre">Notas</a></center></td>
		<%
			} else {		
		%>
		<td><center><a href="materiaList?from=nota_lista_alum&do=listar&grado_list=<%= g.getGrado() %>&dni=<%= a.getDni() %>&periodo=1er Trimestre">Notas</a></center></td>
		<td><center><a href="materiaList?from=nota_lista_alum&do=listar&grado_list=<%= g.getGrado() %>&dni=<%= a.getDni() %>&periodo=2do Trimestre">Notas</a></center></td>
		<td><center><a href="materiaList?from=nota_lista_alum&do=listar&grado_list=<%= g.getGrado() %>&dni=<%= a.getDni() %>&periodo=3er Trimestre">Notas</a></center></td>
		<%
			}
		%>
	</tr>
<%
	}
 %>
</table>
<br>
<br>
<form action="nota_menu.jsp" method="post">
<input type="submit" value="Volver">
</form>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>