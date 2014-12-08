<%@page import="datos.Alumno"%>
<%@page import="datos.Tardanza"%>
<%@page import="datos.Tardanzas"%>
<%@page import="datos.Mensaje"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesTardanza"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMensaje"%>
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
  	<!-- sirve para visualizar el men� superior -->
  </div>
  
<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "tardanza_list.jsp") != 1){							
		response.sendRedirect("Login");						
	}
	
	int a�o_tardanza= (Integer) session.getAttribute("a�oTardanza");
	int a�o_sys = Integer.parseInt((String) session.getAttribute("a�o_sys"));
	
	Tardanzas tardanzas = (Tardanzas)session.getAttribute("tardanzas");

	if (tardanzas.getTardanzas().isEmpty()){
%>
<div class="page-header">
<h1>Listado de Tardanzas</h1>
</div>
<br>
<% Mensaje m = AccionesMensaje.getOne(42); %>
<!-- MENSAJE INFORMATIVO -->
   <div class="bs-example">
    	 <div class="alert <%=m.getTipo()%> fade in" role="alert">
     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <%=m.getMensaje()%> <a href="TardanzaEdit?do=alta" class="alert-link">Agregar tardanza <i class="glyphicon glyphicon-edit"></i></a>
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
		String a�o = fecha_ent[fecha_ent.length - 3];
%>
	<tbody>
	<tr>
		<td><%= a.getNombre() + " " + a.getApellido() %></td>		
		<td><%= dia +"/" + mes + "/" + a�o %></td>
		<td><%= t.getObservaciones() %></td>				
		<td><strong><a href="TardanzaEdit?do=modificar&&dni=<%=t.getDni()%>&&fecha=<%=t.getFecha()%>"><i class="glyphicon glyphicon-pencil"></i> Editar</a></strong></td>		
		<td><strong><a href="TardanzaEdit?do=borrar&&dni=<%=t.getDni()%>&&fecha=<%=t.getFecha()%>>" onclick=<%=AccionesMensaje.getOne(32).getMensaje()%>><i class="glyphicon glyphicon-trash"></i> Borrar</a></strong></td>				
	</tr>
	</tbody>
<%
	}
 %>
</table>
<%if (a�o_tardanza == a�o_sys){%>
<br>
<p><strong><a href="TardanzaEdit?do=alta"><i class="glyphicon glyphicon-edit"></i> Nueva Tardanza</a></strong></p>
<br>
<%}%>
<%
	}
 %>
<br>
	<div class="form-group"> 
	  	<form action="menu_tardanzas.jsp">
	  	<input type="hidden" name="volver" value="volver">		   
	   	<button type="submit" class="btn btn-primary"  value="Volver al Men� de Tardanzas"><i class="glyphicon glyphicon-pushpin"></i> Seleccionar otro grado</button> 
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

	<!-- men� superior -->
	<script src="js/menu_admin.js"></script>
</body>
</html>