<%@page import="datos.Alumno"%>
<%@page import="datos.Tardanza"%>
<%@page import="datos.Tardanzas"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesTardanza"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de Tardanzas</title>
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<body>
<div class="container">
<%

if(session.getAttribute("admin")!=null){
		
	Tardanzas tardanzas = (Tardanzas)session.getAttribute("tardanzas");

	if (tardanzas.getTardanzas().isEmpty()){
%>
<div class="page-header">
<h1>No hay tardanzas cargadas</h1>
</div>
<%}else{%> 
<div class="page-header">
<h1>Listado de Tardanzas</h1>
</div>
<table class="table table-hover table-bordered">
	<tr>
		<th>Alumno</th>
		<th>Fecha</th>
		<th>Observaciones</th>			
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
<%	
	Alumno a = new Alumno();

	for (Tardanza t : tardanzas.getTardanzas()) {		
		a = AccionesAlumno.getOne(t.getDni());		
%>
	<tr>
		<td><%= a.getNombre() + " " + a.getApellido() %></td>		
		<td><%= t.getFecha() %></td>
		<td><%= t.getObservaciones() %></td>				
		<td><a href="TardanzaEdit?do=modificar&&dni=<%=t.getDni()%>&&fecha=<%=t.getFecha()%>">Modificar</a></td>		
		<td><a href="TardanzaEdit?do=borrar&&dni=<%=t.getDni()%>&&fecha=<%=t.getFecha()%>>" onclick="return confirm('Esta seguro que desea borrar la tardanza?');">Borrar</a></td>				
	</tr>
<%
	}
 %>
</table>
<%
	}
 %>
	<br>
	<center>
	<a href="TardanzaEdit?do=alta">Agregar Tardanza</a>
	</center>	
	<br>
	<br>
	<div class="form-group"> 
	  	<form action="menu_tardanzas.jsp">
	  	<input type="hidden" name="volver" value="volver">		   
	   	<button type="submit" class="btn btn-primary"  value="Volver al Menú de Tardanzas">Volver al Menú de Tardanzas</button> 
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