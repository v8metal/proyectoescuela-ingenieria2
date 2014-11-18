<%@page import="datos.Materia"%>
<%@page import="datos.Materias"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "materias");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Materias</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen"> 

</head>
<body>

<%
	// modulo de seguridad
	int tipo = (Integer) session.getAttribute("tipoUsuario");
	if (AccionesUsuario.validarAcceso(tipo, "materia_edit.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
%>

<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div> 

<%	
	Materia materia = (Materia)request.getAttribute("materia");
		
	if(materia != null){
%>

  <div class="page-header">  
	<h1>Editar Materia</h1>
  </div>
<%}else{%>
<div class="page-header">  
	<h1>Alta de Materia</h1>
</div>

<div class="form-group"> 
	<form action="materiaEdit" method="post">
		<table class="table table-hover table-bordered">
			<tbody>							
				<tr>
				    <td>
				    	<label for="input">Nombre:</label>
				    </td>
         			<td>
         				<div class="col-xs-6">
         					<input type="text" class="form-control" name="materia" placeholder="Nombre" required autofocus value="<%=materia!=null ? materia.getMateria() : ""%>">
         				</div>
         			</td>
         		</tr>			
			</tbody>
		</table>		
				<%
		String mensaje= "return confirm('Esta seguro que desea realizar el alta?');"; 
		  
		if (materia != null){
			
			mensaje = "return confirm('Esta seguro que desea modificar?');"; 
		}
		 
		%>
		<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="<%=mensaje%>">Guardar</button>
		<button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave">Cancelar</button>
		<input type="hidden" name="accion" value="alta">
		
	</form>
</div>
<%}%> 
<br>

<%	
	String error = "";
	if (session.getAttribute("error") != null) {
		error = (String)session.getAttribute("error");
		session.setAttribute("error", "");
	}
 %> 
    <% 
			if (!error.equals("")) {
%>
 <br>
 	<!-- MENSAJE DE ERROR -->
   <div class="bs-example">
    	 <div class="alert alert-danger fade in" role="alert">
     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <strong>Ups!</strong> <%= error %>
  	  </div>
  </div><!-- /example -->
  <br>
<%
			}
%>
 <br>
<strong><a href="materiaList?from=menu_admin" class="alert-link">Volver al listado</a></strong>
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