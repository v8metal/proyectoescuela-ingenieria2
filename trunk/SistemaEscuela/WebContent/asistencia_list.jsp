<%@page import="datos.Maestro"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Tardanza"%>
<%@page import="datos.Tardanzas"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesTardanza"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "asistencias");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de Asistencias</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

</head>
<body>
<div class="container">

<%

	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "asistencia_list.jsp") != 1){							
		response.sendRedirect("Login");
	}
	
	Maestro maestro = (Maestro)session.getAttribute("maestro");
	String nombre = maestro.getNombre();
	String apellido = maestro.getApellido();
	
	Tardanzas tardanzas = (Tardanzas)session.getAttribute("Asistencias");
	Grado grado = (Grado)session.getAttribute("gradoAltaAsistencia");
	String fechaDisplay = (String) session.getAttribute("fechaDisplayAsistencia");
	String fecha = (String) session.getAttribute("fechaAsistencia");
	
%>
  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>
<%
	if (tardanzas.getTardanzas().isEmpty()){
%>
<div class="page-header">
<h1>Listado de Asistencias</h1>
</div>
<br>
<div class="alert alert-info fade in" role="alert">
	   <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	   <strong>Atención!</strong> No hay Asistencias cargadas el día <%=fechaDisplay%>. <a href="menu_asistencias.jsp" class="alert-link">Seleccionar otro grado/fecha</a>
</div> 
<%}else{%> 
<div class="page-header">
<h1>Listado de Asistencias</h1>
</div>
<h3>Fecha: <%=fechaDisplay%></h3>
<br>
<table class="table table-hover table-bordered">
	<thead>
	<tr class="active">
		<th>Alumno</th>		
		<th>Condición</th>	
		<th>Observaciones</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
	</thead>
<%	
	Alumno a = new Alumno();	
	String accion = "";
	
	for (Tardanza t : tardanzas.getTardanzas()) {		
		a = AccionesAlumno.getOne(t.getDni());
		accion = "Modificar";
		
		if (t.getTipo().equals("V")) accion = "Alta";
	%>
	<tbody>
	<tr>
		<td><%= a.getNombre() + " " + a.getApellido() %></td>		
		<td><%= t.getIndicador() %></td>	
		<td><%= t.getObservaciones() %></td>	
		<td><strong><a href="AsistenciaEdit?do=<%=accion%>&&dni=<%=t.getDni()%>&&fecha=<%=fecha%>"><%=accion%></a></strong></td>
		<%if (t.getTipo().equals("A")){%>		
		<td><strong><a href="AsistenciaEdit?do=borrar&&dni=<%=t.getDni()%>&&fecha=<%=fecha%>>" onclick="return confirm('Esta seguro que desea borrar la Asistencia?');">Borrar</a></strong></td>
		<%}else{%>
		<td></td>
		<%}%>
	</tr>
	</tbody>
<%
	}
 %>
</table>

 	<br>
	<br>
	<div class="form-group"> 
	  	<form action="menu_asistencias.jsp">
	  	<input type="hidden" name="volver" value="volver">		   
	   	<button type="submit" class="btn btn-primary"  value="Seleccionar otro grado/fecha">Seleccionar otro grado/fecha</button> 
	   </form>
	</div>
	
<%
	}
 %>

</div>
	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

	<!-- menú superior -->
	<script src="js/menu_user.js"></script> 
</body>
</html>