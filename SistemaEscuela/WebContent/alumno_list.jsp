<%@page import="conexion.AccionesEstado"%>
<%@page import="datos.EstadoAlumno"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.Alumnos"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%
	if (session.getAttribute("login") != null) {
		
		String error = "";
		if (session.getAttribute("error") != null) {
			error = (String)session.getAttribute("error");
			session.setAttribute("error", "");
		}
		
		String titulo = (String)session.getAttribute("titulo");
%>
<title><%=titulo%></title>
</head>
<body>
<%
		Alumnos alumnos = (Alumnos)session.getAttribute("alumnos");

		if (alumnos.getLista().isEmpty()){
			String grado = (String)session.getAttribute("grado");
			String turno = (String)session.getAttribute("turno");
			String año = (String)session.getAttribute("año");
			
			String rta = "No hay alumnos cargados en " + grado + ", turno " + turno.toLowerCase() + ", año " + año;
			
%>
<center>
<h3><%=rta%></h3>	
<form action="menu_listado_alum.jsp" method="post">
<input type="submit" value="Volver">
</form>
</center>
<%		
		} else {
%> 	
<table border="2" bordercolor="666">
	<tr>
		<th><%=titulo%></th><th>LISTADO</th>
	</tr>
</table>
<br>
<table border="2" bordercolor="666">
	<tr>
		<th>Nº</th>
		<th>Apellido y Nombres</th>
		<th>D.N.I.</th>
		<th>Domicilio</th>
		<th>Teléfono</th>
<!--	<th>Fecha nac.</th>			-->
		<th>Lugar nac.</th>
<!--		<th>D.N.I. padre</th>	-->
<!--		<th>D.N.I. madre</th>	-->
<!--		<th>Her. may.</th>		-->
<!--		<th>Her. men.</th>		-->
		<th>Iglesia</th>
<!--		<th>Escolaridad</th>	-->
		<th>Grupo flia.</th>
		<th>Sub.</th>
		<th>Estado</th>
		<th>Cert.</th>	
<!--		<th>&nbsp;</th>			-->
		<th>&nbsp;</th>
	</tr>
<% 			int i = 0;
			for (Alumno a : alumnos.getLista()) {
				EstadoAlumno ea = AccionesEstado.getOne(a.getDni());
				i++;
%>
	<tr>
		<td><center><%=i%></center></td>
<!-- 		<td><%= a.getApellido() + ", " + a.getNombre() %></td>		 -->
		<td><a href="alumnoEdit?do=modificar&dni_alum=<%=a.getDni()%>&dni_tutor=<%=a.getDni_tutor()%>&dni_madre=<%=a.getDni_madre()%>"><%= a.getApellido() + ", " + a.getNombre() %></a></td>
		<td><%= a.getDni() %></td>
		<td><%= a.getDomicilio() %></td>
		<td><%= a.getTelefono() %></td>
<!--		<td><%= a.getFecha_nac() %></td>		-->
		<td><%= a.getLugar_nac() %></td>
<!--		<td><%= a.getDni_tutor() == 0 ? "" : a.getDni_tutor() %></td>	-->		<!-- En caso de que el dni sea 0 (no tiene padre) muestra un string vacio -->
<!--		<td><%= a.getDni_madre() == 0 ? "" : a.getDni_madre() %></td>	-->
<!--		<td><%= a.getCant_her_may() %></td>		-->
<!--		<td><%= a.getCant_her_men() %></td>		-->
		<td><%= a.getIglesia() %></td>
<!--		<td><%= a.getEsc() %></td>		-->
		<td><center><input type="checkbox" name="ind_grupo" disabled 
			<%= a.isInd_grupo() ? "checked" : "" %> /></center></td>
		<td><center><input type="checkbox" name="ind_sub" disabled 
			<%= a.isInd_subsidio() ? "checked" : "" %> /></center></td>
			<%
				if (ea.isActivo()) {
			%>
		<td>ACTIVO</td>	
			<%
				} else {
			%>
		<td><a href="alumnoInactivo?do=listar">INACTIVO</a></td>
			<%
				}
			%>	
		<td><a href="certificadoEdit?do=modificar&dni=<%= a.getDni() %>">Ver</a></td>	
<!-- 	<td><a href="alumnoEdit?do=modificar&dni_alum=<%=a.getDni()%>&dni_tutor=<%=a.getDni_tutor()%>&dni_madre=<%=a.getDni_madre()%>">Modificar</a></td>		 -->
		<%
				if (ea.isActivo()) {	
		%>	
		<td><a name="delete-link" href="alumnoEdit?do=baja&dni_alum=<%= a.getDni() %>" >DAR DE BAJA</a></td>
		<%
				} else {
 		%>
 		<td>&nbsp;</td>
 		<%
				}
 		%>
	</tr>
<%
			}
 %>
</table>
<% 
			if (!error.equals("")) {
%>
<br>
<br>
<%=error%>
<br>
<br>
<%
			}
%> 
<br>
<a href="certificado_list.jsp"><%= "VER CERTIFICADOS DE " + titulo.toUpperCase() %></a>
<br>
<br>
<form action="menu_listado_alum.jsp" method="post">
<input type="submit" value="Volver">
</form>
<%
		}
		
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>