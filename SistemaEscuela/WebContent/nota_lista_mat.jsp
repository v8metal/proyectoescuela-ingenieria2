<%@page import="conexion.AccionesNota"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="datos.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<%
	if (session.getAttribute("login") != null) {
		String titulo = (String)session.getAttribute("titulo");
		
		// recupero los atributos para seleccionar la nota
		String grado  = (String)session.getAttribute("grado");
		String turno = (String)session.getAttribute("turno");
		int año = Integer.parseInt((String)session.getAttribute("año_sys"));
		int dni = Integer.parseInt((String)session.getAttribute("dni_alum"));
		String periodo = (String)session.getAttribute("periodo");
		
		// traigo el objeto alumno para usar su apellido y nombre
		Alumno a = AccionesAlumno.getOne(dni);
%>
<title><%=titulo%></title>
</head>
<body>	
<table border="2" bordercolor="666">
	<tr>
		<th><%=titulo%></th><th><%= periodo %></th><th>MATERIAS Y NOTAS</th>
	</tr>
</table>
<br>
<b>Alumno: </b><%=a.getApellido() + ", " + a.getNombre() %>
<br>
<br>
<table border="2" bordercolor="666">
	<tr>
		<th>Nº</th>
		<th>Materia</th>
		<th>Nota</th>
		<th>&nbsp;</th>
	</tr>	
<% 
	Materias mat_grado = (Materias)session.getAttribute("materias_grado");

	int i = 0;
	for (Materia m : mat_grado.getLista()) {
		i++;
%>
	<tr>
		<td><center><%=i%></center></td>
		<td><%= m.getNombre() %></td>
			 <%
				if (AccionesNota.estaCargada(grado, turno, año, dni, m.getCod_materia(), periodo)) {
					Nota nota = AccionesNota.getOne(grado, turno, año, dni, m.getCod_materia(), periodo);
 			 %>
		<td><center><%= nota.getCalific() == 0 ? "S/C" : nota.getCalific() %></center></td>
			 <%
			 	} else {
			  %>	
		<td><center>S/C</center></td>
			 <%			 
			 	}
			  %>
		<td><a href="notaEdit?cod_materia=<%=m.getCod_materia()%>">Modificar</a></td>
	</tr>
<%			 
	}		 
%>	
</table>
<br>
<p>(*) S/C = Sin Calificación</p>
<br>
<form action="nota_lista_alum.jsp" method="post">
<input type="submit" value="Volver">
</form>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>