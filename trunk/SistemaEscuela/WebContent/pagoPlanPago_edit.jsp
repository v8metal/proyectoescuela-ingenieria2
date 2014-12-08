<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.PlanPago"%>
<%@page import="datos.PagoPlanPago"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesPlanPago"%>
<%@page import="conexion.AccionesMensaje"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "cuotas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Pagos</title>

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
 	if (AccionesUsuario.validarAcceso(tipo, "pagoPlanPago_edit.jsp") != 1){							
 		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
 	}
 
 	 PlanPago plan = (PlanPago) session.getAttribute("planPagos");	
 	 PagoPlanPago ppp = (PagoPlanPago) request.getAttribute("pagopp");
 	
 		if (ppp != null){
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
	Alumno a =  AccionesAlumno.getOne(plan.getDni());
		
	String mesini = "";
		
	if(plan.getPeriodoini() == 3) mesini="Marzo";
	if(plan.getPeriodoini() == 4) mesini="Abril";
	if(plan.getPeriodoini() == 5) mesini="Mayo";
	if(plan.getPeriodoini() == 6) mesini="Junio";
	if(plan.getPeriodoini() == 7) mesini="Julio";
	if(plan.getPeriodoini() == 8) mesini="Agosto";
	if(plan.getPeriodoini() == 9) mesini="Septiembre";
	if(plan.getPeriodoini() == 10) mesini="Octubre";
	if(plan.getPeriodoini() == 11) mesini="Noviembre";
	if(plan.getPeriodoini() == 12) mesini="Diciembre";	
	if(plan.getPeriodoini() == 13) mesini="Inscripción";
		
	String mesfin = "";
	
	if(plan.getPeriodofin() == 3) mesfin="Marzo";
	if(plan.getPeriodofin() == 4) mesfin="Abril";
	if(plan.getPeriodofin() == 5) mesfin="Mayo";
	if(plan.getPeriodofin() == 6) mesfin="Junio";
	if(plan.getPeriodofin() == 7) mesfin="Julio";
	if(plan.getPeriodofin() == 8) mesfin="Agosto";
	if(plan.getPeriodofin() == 9) mesfin="Septiembre";
	if(plan.getPeriodofin() == 10) mesfin="Octubre";
	if(plan.getPeriodofin() == 11) mesfin="Noviembre";
	if(plan.getPeriodofin() == 12) mesfin="Diciembre";	
	if(plan.getPeriodofin() == 13) mesfin="Inscripción";
	%>
<div class="page-header">  
	<h2><%= "Plan de pagos - "+ a.getNombre() + " " + a.getApellido()  + " - De " + mesini + " " + plan.getAñoini() + " a "  + mesfin + " " + plan.getAñofin()%></h2>
</div>

   	<div class="form-group">
	<form action="PlanPagoList" method="get">
	<input name="fecha" id="fecha" type="hidden" value="<%=ppp!=null?ppp.getFecha():"0"%>">
	<%if (ppp != null) { %>
	<input name=accion type=hidden value ="modificarPagopp2">
	<%}else{%>
	<input name=accion type=hidden value ="altaPagopp">
	<%}%>	
	<table class="table table-hover table-bordered">
		<tr>
			<th><label for="input">Fecha</label></th>			
			<td>
			<div class="col-xs-5">
			<input class="form-control" type="text" id="datepicker" required autofocus name="fecha_ppp">
			</div>
			</td>			
	    </tr>
		<tr>
			<th>Pago</th>
			<td>
				<div class="col-xs-5">
				<input type="text" class="form-control" required placeholder="Importe" name="pagopp" value="<%=ppp!=null?ppp.getPago(): ""%>">
				</div>
			</td>
		</tr>
		
		<tr>
			<th>Observaciones</th>
			<td>
				<div class="col-xs-5">
				<textarea class="form-control" placeholder="Observaciones" name="obspp" cols="40" rows="1"><%=ppp!=null?ppp.getObservaciones(): ""%></textarea>
				</div>
			</td>			
		</tr>
		
	</table> 
	<br>
	<br>
	<%if (ppp != null) { %>	
	<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick=<%=AccionesMensaje.getOne(2).getMensaje()%>>Realizar modificación</button>
	<input type="hidden" name="cod_pago" value="<%= ppp.getCod_pago()%>">	
	<%}else{%>
	<button type="submit" class="btn btn-primary"  value="Realizar Alta" name="btnSave" onclick=<%=AccionesMensaje.getOne(1).getMensaje()%>>Realizar Alta</button>
	<%}%>	
	</form>
	</div>
<br>
<br>
<div class="form-group">
<form action="PlanPagoList" method="get">
<input name="accion" type="hidden" value="listarPagosPlan">
<input name="codplan" type="hidden" value="<%=plan.getCod_plan()%>">
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