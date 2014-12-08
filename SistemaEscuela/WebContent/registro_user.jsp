<%@page import="datos.*"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMaestro"%>
<%@page import="conexion.AccionesMensaje"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<body>
<head>
<%session.setAttribute("modulo", "usuarios");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Registro de nuevo usuario</title>

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
	if (AccionesUsuario.validarAcceso(tipo, "registro_user.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
		
	Maestros maestros = (Maestros) session.getAttribute("activos");

%>
<div class="page-header">  
	<h1>Alta de Usuario</h1>
</div>

<div class="form-group">

<form action="registroUser" method="post">

<table class="table table-hover table-bordered">

	<tr>
		<td>
			<label for="input">Maestro</label>
		</td>
		<td>
			<div class="col-xs-6">
			<select name="maestro" class="form-control" autofocus>
			<%
			for (Maestro m : maestros.getLista()){
				if (!AccionesUsuario.validarCuentaMaestro(m.getDni())) {
			%>	 			  
		   		<option value="<%=m.getDni()%>"><%= m.getApellido() + ", "  + m.getNombre() %> </option>   			  
		   	<%
				}
			}			
			%>
		 </select>
		 </div>
		</td>
	</tr>
	
	<tr>
		<td>
			<label for="input">Usuario</label>
		</td>
        <td>
        	<div class="col-xs-6">
        		<input type="text" class="form-control" name="usuario" placeholder="Usuario" required>
        	</div>
        </td>
    </tr>
    
    <tr>
		<td>
			<label for="input">Contraseña</label>
		</td>
        <td>
        	<div class="col-xs-6">
        		<input type="password" class="form-control" name="contraseña" placeholder="Contraseña" required>
        	</div>
        </td>
    </tr>
    
    
    <tr>
		<td>
			<label for="input">Confirmar contraseña</label>
		</td>
        <td>
        	<div class="col-xs-6">
        		<input type="password" class="form-control" name="contraseña_conf" placeholder="Repetir Contraseña" required>
        	</div>
        </td>
    </tr>	
</table>
<br>
<button type="submit" class="btn btn-primary"  onclick=<%=AccionesMensaje.getOne(1).getMensaje()%>><i class="glyphicon glyphicon-floppy-disk"></i> Guardar</button>
<button type="reset" class="btn btn-primary"   onclick=<%=AccionesMensaje.getOne(3).getMensaje()%>><i class="glyphicon glyphicon-floppy-disk"></i> Cancelar</button>
</form>
</div>
<!-- MENSAJE DE ERROR -->
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
     	 <%=mensaje.getMensaje()%>
  	  </div>
  </div>
<br>
<%}%>
<br>
<br>
	<form action="gest_user_menu.jsp" method="post">
		<div class="form-group">
			<button type="submit" class="btn btn-primary"  value="Volver al Listado"><i class="glyphicon glyphicon-share-alt"></i> Volver al Listado</button>
		</div>
	</form>
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