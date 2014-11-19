<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMaestro"%>
<%@page import="datos.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "cuenta");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Configuraci�n</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

</head>
<body>
<div class="container">

<%
	String usuario = (String) session.getAttribute("user");

	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "admin_pass.jsp") != 1){			//MODIFICAR A configuracion_cuenta.jsp					
		response.sendRedirect("Login");						
	}
%>		

  <div id="divmenu">
  	<!-- sirve para visualizar el men� superior -->
  </div>
  
<div class="page-header"> 
<h1>Configuraci�n general de la cuenta</h1>
</div>
<div class="form-group">
<form action="AdminUser?do=pass" method="post">
<table class="table table-hover">
	<thead>
	<tr>
		<td>
			<label for="input">Nombre</label>
		</td>
		<td>
			<div class="col-xs-6">
<%			
	String nombre = "";
	String apellido = "";
	
	if (session.getAttribute("dni_maestro") != null ){		
		Maestro maestro = (Maestro)session.getAttribute("maestro");
		nombre = maestro.getNombre();
		apellido = maestro.getApellido();
%>
		<label for="input"><%= nombre + " " + apellido %></label>
<%		
	} else {
%>		
		<label for="input">Administrador</label>
<%		
	}	
%>	
			</div>
		</td> 
		<td>&nbsp;</td>
	</tr>
	</thead>
	<tbody>
	<tr>
		<td>
			<label for="input">Nombre de usuario</label>
		</td>
		<td>
			<div class="col-xs-6">
				<label for="input"><%= usuario %></label>	
			</div>		
		</td>
		<td>
			<div class="col-xs-6">
				<strong><a href="admin_user.jsp"><i class="glyphicon glyphicon-pencil"></i> Editar </a></strong>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Contrase�a</label>
		</td>
		<td>
			<div class="col-xs-6">
				<label for="input">***************</label>
			</div>
		</td>
		<td>
			<div class="col-xs-6">
				<strong><a href="admin_pass.jsp"><i class="glyphicon glyphicon-pencil"></i> Editar </a></strong>
			</div>
		</td>
	</tr>
	</tbody>
</table>
</form>
</div>
<br>
<!-- MENSAJE DE ERROR -->
<%	
	String error = "";
	if (session.getAttribute("error") != null) {
		error = (String)session.getAttribute("error");
		session.setAttribute("error", null);
 %>
 <br>
   <div class="bs-example">
    	 <div class="alert alert-warning fade in" role="alert">
     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <strong>Cuidado!</strong> <%= error %>
  	  </div>
  </div><!-- /example -->
<br>
 <%		
	}
 %>
 
 <!-- MENSAJE DE EXITO -->
 <%	
	String success = "";
	if (session.getAttribute("success") != null) {
		success = (String)session.getAttribute("success");
		session.setAttribute("success", null);
 %>
 <br>
   <div class="bs-example">
    	 <div class="alert alert-success fade in" role="alert">
     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <strong>Bien Hecho!</strong> <%= success %>
  	  </div>
  </div><!-- /example -->
<br>
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

	<!-- men� superior -->
	<script src="js/menu_admin.js"></script>
	<script src="js/menu_user.js"></script> 
</body>
</html>