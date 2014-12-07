<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@page import="datos.Mensaje"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMensaje"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "maestros");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<title>Listado de maestros</title>
</head>
<body>

<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "menu_admin.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
%>

<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>
  
  <div class="page-header"> 
	<h1>Listado de Maestros Activos</h1>
  </div>
<%	
		Maestros maestros = (Maestros)session.getAttribute("maestros");
		Maestros maestros_inac = (Maestros)session.getAttribute("maestros_inac");	
%>

<%
if (maestros.getLista().size() == 0){
%>

<br>
 <!-- MENSAJE DE WARNING -->
	<div class="alert alert-warning" role="alert">
	  <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <strong><i class="glyphicon glyphicon-warning-sign"></i> Cuidado!</strong> No hay maestros activos. <a href="maestroEdit?accion=alta" class="alert-link">Agregar maestro</a>
    </div>	
	
<%}else{%>

<table class="table table-hover table-bordered">
	<thead>
	<tr class="active">		
		<th>Apellido y Nombres</th>
		<th>D.N.I.</th>
		<th>Domicilio</th>
		<th>Teléfono</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
	<thead>
<%
	for (Maestro m : maestros.getLista()) {
%>
	<tbody>
	<tr>		
		<td><%= m.getApellido() + ", " + m.getNombre() %></td>
		<td><%= m.getDni() %></td>
		<td><%= m.getDomicilio() %></td>
		<td><%= m.getTelefono() %></td>		
		<td><strong><a href="maestroEdit?accion=modificar&dni=<%= m.getDni() %>"><i class="glyphicon glyphicon-pencil"></i> Editar</a></strong></td>		
		<td><strong><a href="maestroEdit?accion=baja&dni=<%= m.getDni() %>" onclick=<%=AccionesMensaje.getOne(22).getMensaje()%>><i class="glyphicon glyphicon-arrow-down"></i> Dar de baja</a></strong></td>		
		<td><strong><a href="maestroEdit?accion=borrar&dni=<%= m.getDni() %>" onclick=<%=AccionesMensaje.getOne(32).getMensaje()%>><i class="glyphicon glyphicon-trash"></i> Borrar</a></strong></td>		
	</tr>
	<tbody>
<%
	}
 %>
</table>
<br>
    <p><strong><a href="maestroEdit?accion=alta"><i class="glyphicon glyphicon-edit"></i> Nuevo Maestro</a></strong></p>
<br>
<br>	
 <%}%>
 
<%if(maestros_inac.getLista().size() != 0){	
	Mensaje m = AccionesMensaje.getOne(31);
%>
  <!-- MENSAJE INFORMATIVO -->
	<div class="alert <%=m.getTipo()%>" role="alert">
	  <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <%=m.getMensaje()%>
    </div>
<%}%>
<br>
<!-- MENSAJE -->
 <%	Mensaje mensaje = null;	
	if (session.getAttribute("mensaje") != null) {
		mensaje = (Mensaje) session.getAttribute("mensaje");
		session.setAttribute("mensaje", null);		
	
 %>
   <div class="bs-example">
    	 <div class="alert <%=mensaje.getTipo()%> fade in" role="alert">
     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <%=mensaje.getMensaje()%>
  	  </div>
  </div><!-- /example -->
 	
 <% } %>
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