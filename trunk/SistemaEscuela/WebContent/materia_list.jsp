<%@page import="datos.Materia"%>
<%@page import="datos.Materias"%>
<%@page import="datos.Mensaje"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMensaje"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "materias");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen"> 

<title>Listado de Materias</title>
</head>
<body>

<%
	// modulo de seguridad
	int tipo = (Integer) session.getAttribute("tipoUsuario");
	if (AccionesUsuario.validarAcceso(tipo, "materia_list.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
%>

<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el men� superior -->
  </div>

  <div class="page-header">  
	<h1>Listado de Materias Activas</h1>
  </div>
<%
		Materias materias = (Materias)session.getAttribute("materias");
		Materias materiasbaja = (Materias)session.getAttribute("materiasbaja");		
%>

<%if (materias.getLista().isEmpty()){ 
	Mensaje m = AccionesMensaje.getOne(29);
%>
<br>
 <!-- MENSAJE DE WARNING -->
	<div class="alert <%=m.getTipo()%>" role="alert">
	  <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <%=m.getMensaje()%> <a href="materiaEdit?do=alta" class="alert-link"> Nueva materia <i class="glyphicon glyphicon-edit"></i></a>
    </div>	
    
<%}else{%>

<table class="table table-hover table-bordered">
	<thead>
	<tr class="active">
		<th>Materia</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
	<thead>	
<% 	
	for (Materia m : materias.getLista()) {
%>
	<tbody>
	<tr>
		<td><%= m.getMateria() %></td>
		<td><strong><a href="materiaEdit?do=baja&materia=<%= m.getMateria() %>" onclick=<%=AccionesMensaje.getOne(22).getMensaje()%>><i class="glyphicon glyphicon-ban-circle"></i> Volver inactiva</a></strong></td>		
		<td><strong><a href="materiaEdit?do=borrar&materia=<%= m.getMateria() %>" onclick=<%=AccionesMensaje.getOne(32).getMensaje()%>><i class="glyphicon glyphicon-trash"></i> Borrar</a></strong></td>
	</tr>
	<tbody>	
<%
	}
 %>
</table>

<br>
  	<p><strong><a href="materiaEdit?do=alta"><i class="glyphicon glyphicon-edit"></i> Nueva materia</a></strong></p>
<br>
<br>
<%}
if(materiasbaja.getLista().size() != 0){
  Mensaje m = AccionesMensaje.getOne(38);
 %>
  <!-- MENSAJE INFORMATIVO -->
	<div class="alert <%=m.getTipo()%>" role="alert">
	  <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <%=m.getMensaje()%><a href="materiaList?from=materia_inactiva_list" class="alert-link">Ver listado <i class="glyphicon glyphicon-list-alt"></i></a>
    </div> 
<br>
<%}%>
<!-- MENSAJE DE ERROR -->
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
  </div>
 <% } %>
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