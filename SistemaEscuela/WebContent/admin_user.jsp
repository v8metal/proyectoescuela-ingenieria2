<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMensaje"%>
<%@page import="datos.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "cuenta");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Administración de Usuario</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

</head>
<body>
<div class="container">

<!-- Fixed navbar -->

<%
	
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "admin_user.jsp") != 1){							
		response.sendRedirect("Login");						
	}
		
	String nombre = "";
	String apellido = "";

%>

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>
  
<div class="page-header"> 
<h1>Administración de usuario</h1>
</div>
<div class="form-group">
<form action="AdminUser?do=user" method="post">
<table class="table table-hover table-bordered">	
	<tr>
		<td>
			<label for="input">Contraseña:</label>
		</td>
		<td>
			<div class="col-xs-6">
				<input type="password" class="form-control" name="contraseña_actual" required autofocus>
			</div>
		</td> 
	</tr>
	<tr>
		<td>
			<label for="input">Nuevo usuario:</label>
		</td>
		<td>
			<div class="col-xs-6">
				<input type="text" class="form-control" name="usuario_nuevo" required>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Vuelve a escribir el nuevo usuario:</label>
		</td>
		<td>
			<div class="col-xs-6">
				<input type="text" class="form-control" name="usuario_nuevo_r" required>
			</div>
		</td>
	</tr>
</table>
<br>
<button type="submit" class="btn btn-primary"  onclick=<%=AccionesMensaje.getOne(2).getMensaje()%>><i class="glyphicon glyphicon-floppy-disk"></i> Guardar</button>
<button type="reset" class="btn btn-primary"   onclick=<%=AccionesMensaje.getOne(3).getMensaje()%>><i class="glyphicon glyphicon-remove"></i> Cancelar</button>
</form>
</div>
<br>
 <!-- MENSAJE -->
 <%	
	Mensaje mensaje = null;
	if (session.getAttribute("mensaje") != null) {
		mensaje = (Mensaje) session.getAttribute("mensaje");
		session.setAttribute("mensaje", null);
 %>
 <br>
   <div class="bs-example">
    	 <div class="alert <%=mensaje.getTipo()%> fade in" role="alert">
     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <%= mensaje.getMensaje()%>
  	  </div>
  </div><!-- /example -->
<br>
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
	<script src="js/menu_user.js"></script> 
</body>
</html>