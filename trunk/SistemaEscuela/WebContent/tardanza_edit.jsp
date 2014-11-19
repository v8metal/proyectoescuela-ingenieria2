<%@page import="datos.Maestro_Grado"%>
<%@page import="datos.Maestros_Grados"%>
<%@page import="datos.Tardanza"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.Alumnos"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "tardanzas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de Tardanzas</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
	
<!--<link rel="stylesheet" href="style/jquery-ui.css">  con ese no se ven las flechitas-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">

</head>
<body>
<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>


<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "tardanza_edit.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
%>
<%
	Tardanza tardanza = (Tardanza) request.getAttribute("tardanza");
	Alumnos alumnos = (Alumnos) session.getAttribute("alumnosAltaTardanza");
	
	int dia_tardanza = 0;
	String mes_tardanza = "";
	int año_tardanza = 0;
	
	String accion = "alta";
	
	if (tardanza != null) {
		
		accion = "modificar";
		
	}	

	if(tardanza != null){
		Alumno a = AccionesAlumno.getOne(tardanza.getDni());
%>
<div class="page-header">
	<h1>Edición de Tardanza</h1>
</div>
<h3><%=a.getNombre() + " " + a.getApellido() %></h3>
<br>
<%}else{%>
<div class="page-header">
	<h1>Alta de Tardanza </h1>
</div>
<%}%>

	<div class="form-group">	
	<form action="TardanzaEdit" method="post">	
	<input type="hidden" name=do value="<%=accion%>">
	<input name="fecha" id="fecha" type="hidden" value="<%=tardanza!=null? tardanza.getFecha() : "0"%>">
	<%if(tardanza != null){%>					 		
		<input type="hidden" class="form-control" name="alumno_tardanza"value=<%=tardanza.getDni()%>>
	<%}%>	
		 <table class="table table-hover table-bordered">
		    <tr>
				<th><label for="input">Fecha:</label></th>			
				<td>
				<div class="col-xs-2">
					<input class="form-control" type="text" id="datepicker" required autofocus name="fecha_tardanza">
				</div>
				</td>			
		  	</tr>
		  	<tr>
		  		<%if(tardanza == null){%>
		  		<th><label for="input">Alumno:</label></th>
		  		<td>
		  		<div class="col-xs-5">
		  			<select name="alumno_tardanza" class="form-control" required>   
		  			<%
					for (Alumno a : alumnos.getLista()){		 		
		 			%>
		 			<option class="form-control" value=<%=a.getDni() %>><%= a.getNombre() + " " + a.getApellido() %></option>
		 			<%} %>		 		
		 			</select>
		 		</div>
		 		</td>	
		 		<%}%>	 		
		 	</tr>
		 	<tr>
		        <th><label for="input">Observaciones:</label></th>
         		<td>
         			<div class="col-xs-10">
         			<textarea class="form-control" cols="40" rows="4" name="observaciones" placeholder="Descripción"><%=tardanza!=null?tardanza.getObservaciones():"" %></textarea>
         			</div>
         		</td>
         	</tr>
		  </table>
		  
		 		<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="return confirm('Esta seguro que desea guardar?');"><i class="glyphicon glyphicon-floppy-disk"></i> Guardar</button>
		  		<button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave" onclick="return confirm('Esta seguro que desea cancelar?');"><i class="glyphicon glyphicon-remove"></i> Cancelar</button> 
		  </form>
		  </div>
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
  		  
  		   <% } %>   
  		  
		  <br>
		 <div class="form-group">
			<form action="TardanzaList" method="get">
				<input type="hidden" name="accion" value="listarTardanzas">
				<button type="submit" class="btn btn-primary"  value="Volver al Listado de Tardanzas"><i class="glyphicon glyphicon-share-alt"></i> Volver al Listado de Tardanzas</button>
			</form>
		</div>
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
	
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/jquery-ui.js"></script>
	
	<!-- DatePic para tardanzas -->
	<script src="js/tardanzas.js"></script> 
</body>
</html>