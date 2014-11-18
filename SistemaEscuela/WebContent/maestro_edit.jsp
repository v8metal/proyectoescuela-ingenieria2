<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@page import="conexion.AccionesUsuario"%>
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

<title>Editar Maestro</title>
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
  
<%		
		Maestro maestro = (Maestro)request.getAttribute("maestro");

  	//get the maestro object from the request
  	
  		String accion = "alta";
  	
  		if (maestro != null){
  			accion = "modificar";
%>
<div class="page-header">  
	<h1>Edición de Maestro</h1>
</div> 
	   <%}else{%>
<div class="page-header">  
	<h1>Alta de Maestro</h1>
  </div> 
  	 
 		<%}%>  
 		
	<div class="form-group">
	
	<form action="maestroEdit" method="post">
	
	<input type="hidden" name="accion" value="<%=accion%>">
	
		<table class="table table-hover table-bordered">
		
			<tbody>
				<tr>
				    <td>
				    	<label for="input">Apellido</label>
				    </td>
         			<td>
         				<div class="col-xs-6">
         					<input type="text" class="form-control" name="apellido" placeholder="Apellido" required autofocus value="<%=maestro!=null? maestro.getApellido() : ""%>">
         				</div>
         			</td>
         		</tr>
         		
         		<tr>
				    <td>
				    	<label for="input">Nombre</label>
				    </td>
         			<td>
         				<div class="col-xs-6">
         					<input type="text" class="form-control" name="nombre" placeholder="Nombre" required value="<%=maestro!=null ? maestro.getNombre() : ""%>">
         				</div>
         			</td>
         		</tr>					
							
				<tr>
					<% if(maestro != null){%>
					<td>
						<label for="input">D.N.I.</label>
					</td>					
					<td>
						<div class="col-xs-6">
							<input readonly type="text" class="form-control" name="dni" placeholder="Dni" value="<%=maestro.getDni()%>">
						</div>
					</td>
					<%}else{%>					
					<td>
						<label for="input">D.N.I.</label>
					</td>
         			<td>
         				<div class="col-xs-6">
         					<input type="text" class="form-control" name="dni" required placeholder="Dni" value="">
         				</div>
         			</td>
					<%}%>
				</tr>

				<tr>
				    <td>
				    	<label for="input">Domicilio</label>
				    </td>
         			<td>
         				<div class="col-xs-6">
         					<input type="text" class="form-control" name="domicilio" placeholder="Domicilio"  required value="<%=maestro!=null ? maestro.getDomicilio() : ""%>">
         				</div>
         			</td>
         		</tr>				
					
				<tr>
				    <td>
				    	<label for="input">Teléfono</label>
				    </td>
         			<td>
         				<div class="col-xs-6">
         					<input type="text" class="form-control"  name="telefono" placeholder="Teléfono" required value="<%=maestro!=null ? maestro.getTelefono() : ""%>">
         				</div>
         			</td>
         		</tr>				
			</tbody>
		</table>
		<!-- MENSAJE DE CONFIRMACION -->
		<%
		String mensaje= "return confirm('Esta seguro que desea realizar el alta?');"; 
		  
		if (maestro != null){
			
			mensaje = "return confirm('Esta seguro que desea modificar?');"; 
		}
		 
		%>
		<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="<%=mensaje%>">Guardar</button>
		<button type="reset" class="btn btn-primary"  value="Cancelar" name="btnCancel">Cancelar</button>	
	</form> 
	</div>
 <br>
 <br>
 <!-- MENSAJE DE ERROR -->
 <%	String error = "";
	
	if (session.getAttribute("error") != null) {
		error = (String)session.getAttribute("error");
		session.setAttribute("error", null);		
	
 %>
   <div class="bs-example">
    	 <div class="alert alert-danger fade in" role="alert">
     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <strong>Ups!</strong> <%= error %>
  	  </div>
  </div><!-- /example -->
<br> 	
 <% } %>
<strong><a href="maestroList" class="alert-link">Volver al listado</a></strong>
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