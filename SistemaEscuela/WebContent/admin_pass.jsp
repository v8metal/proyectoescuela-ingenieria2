<%@page import="conexion.AccionesUsuario"%>
<%@page import="datos.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "cuenta");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Login</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

</head>
<body>
<div class="container">

<!-- Fixed navbar -->

<%
	
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "admin_pass.jsp") != 1){							
		response.sendRedirect("Login");						
	}
		
	String nombre = "";
	String apellido = "";
	
//	if (session.getAttribute("dni_maestro") != null ){		
//		Maestro maestro = (Maestro)session.getAttribute("maestro");
//		nombre = maestro.getNombre();
//		apellido = maestro.getApellido();

//		user
//	} else {
//		admin
//	}
%>

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>
  
<div class="page-header"> 
<h1>Administración de Contraseña</h1>
</div>
<div class="form-group">
<form action="AdminUser?do=pass" method="post">
<table class="table table-hover table-bordered">
	
	<tr>
		<td>
			<label for="input">Contraseña Actual:</label>
		</td>
		<td>
			<div class="col-xs-6">
				<input type="password" class="form-control" placeholder="Contraseña Actual" name="contraseña_actual" required autofocus>
			</div>
		</td> 
	</tr>
	<tr>
		<td>
			<label for="input">Nueva Contraseña:</label>
		</td>
		<td>
			<div class="col-xs-6">
				<input type="password" class="form-control" placeholder="Contraseña Nueva" name="contraseña_nueva" required>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Repetir Nueva Contraseña:</label>
		</td>
		<td>
			<div class="col-xs-6">
				<input type="password" class="form-control" placeholder="Contraseña Nueva" name="contraseña_nueva_r" required>
			</div>
		</td>
	</tr>
</table>
<br>
<button type="submit" class="btn btn-primary"  value="Guardar" onclick="return confirm('Esta seguro que desea modificar?');">Guardar</button>
<button type="reset" class="btn btn-primary"  value="Cancelar" onclick="return confirm('Esta seguro que desea cancelar?');">Cancelar</button>
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

	<!-- menú superior -->
	<script src="js/menu_admin.js"></script>
	<script src="js/menu_user.js"></script> 
</body>
</html>