<%@page import="datos.Alumno"%>
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
<%session.setAttribute("modulo", "tardanzas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de Tardanzas</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

</head>
<body>
<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>
  
<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "tardanza_list.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
	
	int año_tardanza= (Integer) session.getAttribute("añoTardanza");
	int año_sys = Integer.parseInt((String) session.getAttribute("año_sys"));
	
	Tardanzas tardanzas = (Tardanzas)session.getAttribute("tardanzas");

	if (tardanzas.getTardanzas().isEmpty()){
%>
<div class="page-header">
<h1>Listado de Tardanzas</h1>
</div>
<br>

<!-- MENSAJE INFORMATIVO -->
   <div class="bs-example">
    	 <div class="alert alert-info fade in" role="alert">
     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <strong>Atención!</strong> No hay tandanzas cargadas. <a href="TardanzaEdit?do=alta" class="alert-link">Agregar tardanza</a>
  	  </div>
  </div><!-- /example -->
  
<%}else{%> 
<div class="page-header">
<h1>Listado de Tardanzas</h1>
</div>
<table class="table table-hover table-bordered">
	<thead>
	<tr class="active">
		<th>Alumno</th>
		<th>Fecha</th>
		<th>Observaciones</th>			
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
	</thead>
<%	
	Alumno a = new Alumno();

	for (Tardanza t : tardanzas.getTardanzas()) {		
		a = AccionesAlumno.getOne(t.getDni());	
		
		String fecha_entrevista = t.getFecha();		
		String[] fecha_ent = fecha_entrevista.split ("-");
		String dia = fecha_ent[fecha_ent.length - 1];
		String mes = fecha_ent[fecha_ent.length - 2];
		String año = fecha_ent[fecha_ent.length - 3];
%>
	<tbody>
	<tr>
		<td><%= a.getNombre() + " " + a.getApellido() %></td>		
		<td><%= dia +"/" + mes + "/" + año %></td>
		<td><%= t.getObservaciones() %></td>				
		<td><strong><a href="TardanzaEdit?do=modificar&&dni=<%=t.getDni()%>&&fecha=<%=t.getFecha()%>">Modificar</a></strong></td>		
		<td><strong><a href="TardanzaEdit?do=borrar&&dni=<%=t.getDni()%>&&fecha=<%=t.getFecha()%>>" onclick="return confirm('Esta seguro que desea borrar la tardanza?');">Borrar</a></strong></td>				
	</tr>
	</tbody>
<%
	}
 %>
</table>
<%if (año_tardanza == año_sys){%>
<br>
<p><strong><a href="TardanzaEdit?do=alta">Agregar Tardanza</a></strong></p>
<br>
<%}%>
<%
	}
 %>
<br>
	<div class="form-group"> 
	  	<form action="menu_tardanzas.jsp">
	  	<input type="hidden" name="volver" value="volver">		   
	   	<button type="submit" class="btn btn-primary"  value="Volver al Menú de Tardanzas">Seleccionar otro grado</button> 
	   </form>
	</div>
</div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

	<!-- menú superior -->
	<script src="js/menu_admin.js"></script>
</body>
</html>