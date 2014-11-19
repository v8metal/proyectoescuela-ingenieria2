<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Alumno"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "cuotas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de pagos por dia</title>

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
 if (AccionesUsuario.validarAcceso(tipo, "pago_edit.jsp") != 1){							
 	response.sendRedirect("Login"); //redirecciona al login, sin acceso						
 }
	 
 	Cuota cuota = (Cuota) session.getAttribute("pagoEdit");
    int dni = (Integer) session.getAttribute("dni");
 	int año = (Integer) session.getAttribute("año");
 	int mes = (Integer) session.getAttribute("mes");
 	
 	if (cuota != null){
 %>  		
 <div class="page-header">  	  
	<h1>Modificar Pago</h1>		
 </div>
 <%}else{%>
  <div class="page-header">  	  
	<h1>Alta de Pago</h1>		
 </div> 
 <%}%>
<%
	Alumno a = null;
		
	if (cuota != null){
	
		a = AccionesAlumno.getOne(cuota.getDni());
	%>	
<h2><%=a.getNombre() + " " + a.getApellido() + " - Año " + cuota.getAño() + " - Mes = " + cuota.getPeriodo() %></h2>
   <%}else{ 
   		
   		a = AccionesAlumno.getOne(dni);
   	%>
   	
<h2><%=a.getNombre() + " " + a.getApellido() + " - Año " + año + " - Mes= " + mes %></h2>

   <%}%>
   	<div class="form-group">   	
	<form action="CuotaEdit" method="<%=cuota!= null?"post":"get"%>">
	<input name="fecha" id="fecha" type="hidden" value="<%=cuota!=null?cuota.getFecha():"0"%>">
	<%if (cuota != null) { %>
	<input name=accion type=hidden value ="modificarPago">
	<%}else{%>
	<input name=accion type=hidden value ="altaPago">
	<%}%>	
	<table class="table table-hover table-bordered">
		<tr>
			<th><label for="input">Fecha:</label></th>			
			<td>
			<div class="col-xs-5">
			<input class="form-control" type="text" id="datepicker" required autofocus name="fecha_pago">
			</div>
			</td>			
	    </tr>
		<tr>
			<td>PAGO</td>
			<td>
				<div class="col-xs-5">
				<input type="text" class="form-control" placeholder="importe" name="pago" value="<%=cuota!=null?cuota.getPago(): ""%>">
				</div>				
			</td>
		</tr>
		
		<tr>
			<td>OBSERVACIONES</td>
			<td>
				<div class="col-xs-5">
				<textarea class="form-control" placeholder="Observaciones" name="obs" cols="40" rows="1"><%=cuota!=null?cuota.getObservaciones(): ""%></textarea>
				</div>
			</td>			
		</tr>
		
	</table> 
	<br>
	<br>
	<%if (cuota != null) { %>	
	<button type="submit" class="btn btn-primary"  value="Realizar modificación">Realizar modificación</button>	
	<%}else{%>	
	<button type="submit" class="btn btn-primary"  value="Realizar alta">Realizar alta</button>
	<%}%>	
	</form>
</div>
<br>
<br>
<div class="form-group">
	<form action="CuotaList" method="get">
	<input name="accion" type="hidden" value="visualizarPagos">
	<button type="submit" class="btn btn-primary"  value="Volver atrás"><i class="glyphicon glyphicon-share-alt"></i> Volver atrás</button>
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
	<script src="js/entrevista.js"></script> <!-- DatePic para entrevistas -->
</body>
</html>