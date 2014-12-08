<%@page import="datos.Usuario"%>
<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@page import="datos.Usuarios"%>
<%@page import="datos.Mensaje"%>
<%@page import="conexion.AccionesMaestro"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMensaje"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "usuarios");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Gestión de usuarios</title>

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
	if (AccionesUsuario.validarAcceso(tipo, "gest_user_menu.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
	
	String titulo = (String)session.getAttribute("titulo");
	Usuarios usuarios = (Usuarios) session.getAttribute("usuarios");
	Maestros maestros = (Maestros) session.getAttribute("activos");
%>
<div class="page-header">  
	<h1>Listado de usuarios registrados</h1>
</div>
<%  
if (usuarios.getLista().isEmpty()) {
	
	Mensaje m = AccionesMensaje.getOne(48);
%>
<br>
<!-- MENSAJE DE WARNING -->
	<div class="alert <%=m.getTipo() %>" role="alert">
	  <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <%=m.getMensaje() %><a href="registro_user.jsp?" class="alert-link">Registrar nuevo usuario</a>
    </div>
<%
		} else {
%>
<table class="table table-hover table-bordered">
	<thead>
	<tr class="active">		
		<th>Maestro</th>
		<th>Usuario</th>
		<th>Contraseña</th>
		<th>&nbsp;</th>
	</tr>
	<thead>
<% 	
	int i = 0;
	for (Usuario u : usuarios.getLista()) {
	Maestro m = AccionesMaestro.getOne(u.getDni());
	i++;
%>
	<tbody>
	<tr>		
		<td><%= m.getApellido() + ", " + m.getNombre() %></td>
		<td><%= u.getUsuario() %></td>
		<td><%= u.getContraseña() %></td>
		<td><strong><a name="delete-link" href="registroUser?do=baja&dni=<%= u.getDni() %>" onclick=<%=AccionesMensaje.getOne(32).getMensaje()%>><i class="glyphicon glyphicon-trash"></i> Borrar</a></strong></td>
	</tr>
	</tbody>
<%
	}
 %>
</table>
<%
		}
%>
<br>
<%if ( (!usuarios.getLista().isEmpty()) && (usuarios.getLista().size() < maestros.getLista().size()) ) { //aca agregar a futuro los maestros activos
		
	Mensaje m = AccionesMensaje.getOne(49);
%> 
  <!-- MENSAJE DE WARNING -->
	<div class="alert <%=m.getTipo()%> role="alert">
	  <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <%=m.getMensaje()%> <a href="registro_user.jsp?" class="alert-link"> Registrar nuevo usuario <i class="glyphicon glyphicon-edit"></i></a>
    </div>
<%}else if ((usuarios.getLista().size() >= maestros.getLista().size())){

		Mensaje m = AccionesMensaje.getOne(50);
	%>
 		 <!-- MENSAJE DE EXITO -->
  		 <div class="bs-example">
    			 <div class="alert <%=m.getTipo()%> fade in" role="alert">
     			 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     			 <%=m.getMensaje()%>
  	  		</div>
  		</div><!-- /example -->
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