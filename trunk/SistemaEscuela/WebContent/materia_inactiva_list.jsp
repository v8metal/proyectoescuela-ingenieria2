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
<title>Listado de Materias</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

</head>
<body>

<%
	// modulo de seguridad
	int tipo = (Integer) session.getAttribute("tipoUsuario");
	if (AccionesUsuario.validarAcceso(tipo, "materia_inactiva_list.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
%>

<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div> 
  
   <div class="page-header">  
	<h1>Listado de Materias Inactivas</h1>
  </div>
  
<%Materias materias = (Materias)session.getAttribute("materiasbaja");%>

<%if (materias.getLista().size() == 0){
	Mensaje m = AccionesMensaje.getOne(58);
%>
<br>	
<!-- MENSAJE INFORMATIVO -->
<div class="alert <%=m.getTipo()%>" role="alert">
    <%=m.getMensaje()%>
</div>
<br>
<%}else{%>

<table class="table table-hover table-bordered">
	<thead>
	<tr class="active">
		<th>Materia</th>
		<th>&nbsp;</th>		
	</tr>
	<thead>
<% 	
	for (Materia m : materias.getLista()) {
%>
	<tbody>
	<tr>
		<td><%= m.getMateria() %></td>
		<td><strong><a href="materiaEdit?do=activar&materia=<%= m.getMateria() %>" onclick=<%=AccionesMensaje.getOne(37).getMensaje()%>><i class="glyphicon glyphicon-ok"></i> Activar Materia</a></strong></td>	
	</tr>
	<tbody>
<%
	}
 %>
</table>

<br>
<div class="form-group">
<form action="materiaList?from=menu_admin" method="post">
<button type="submit" class="btn btn-primary"  value="Volver al listado principal"><i class="glyphicon glyphicon-share-alt"></i> Volver al listado principal</button>
</form>
</div>
<%}%>
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