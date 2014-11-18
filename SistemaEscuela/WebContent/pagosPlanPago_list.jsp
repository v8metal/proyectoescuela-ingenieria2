<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.PlanPago"%>
<%@page import="datos.PagoPlanPago"%>
<%@page import="datos.PagosPlanPago"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesCuota"%>
<%@page import="conexion.AccionesAlumno"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<% 
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "pagosPlanPago_list.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
	
   PagosPlanPago pp = (PagosPlanPago) request.getAttribute("pagospp");
   PlanPago plan = (PlanPago) session.getAttribute("planPagos");
   Alumno a = (Alumno) request.getAttribute("alumnopp");
%>			
<head>
<%session.setAttribute("modulo", "cuotas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Maestros</title>

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
		<h1><%= "Plan de pagos - "+ a.getNombre() + " " + a.getApellido() %></h1>
	</div>
	<h3><%= mesini + " " + plan.getAñoini() + " - "  + mesfin + " " + plan.getAñofin() %> </h3>
	<br>
	<% if (pp.getLista().isEmpty()) { %>
	<a href="pagoPlanPago_edit.jsp"> No hay pagos para el mes, agregar pagos</a>
	<%}else{%>	
	  <table class="table table-hover table-bordered">
	  <thead>
	  <tr class="active">	  	    
	    <th>FECHA</th>
	    <th>PAGO</th>
	    <th>OBSERVACIONES</th>
	    <th>&nbsp;</th>	    
	    <th>&nbsp;</th>	    	    
	  </tr>	 
	  </thead> 
	  <% for (PagoPlanPago p : pp.getLista()) {
		  
	  	String fecha_pago = p.getFecha();		
		String[] fecha_ent = fecha_pago.split ("-");
				
		String dia_pago = fecha_ent[fecha_ent.length - 1];
		String mes_pago = fecha_ent[fecha_ent.length - 2];
		int año_pago = Integer.parseInt(fecha_ent[fecha_ent.length - 3]);
		%>
	  <tbody>
	  <tr>    
	  
	    <td><%= dia_pago + "/" + mes_pago + "/" + año_pago %></td>
	    <td><%="$" + p.getPago()%></td>
	    <td><%= p.getObservaciones() %></td>
	    <td><strong><a href="PlanPagoList?accion=modificarPagopp&&cod_pago=<%=p.getCod_pago() %>"> Modificar pago </a></strong></td>	  
	    <td><strong><a href="PlanPagoList?accion=borrarPagopp&&cod_pago=<%=p.getCod_pago()%>" onclick="return confirm('Esta seguro que desea borrar?');"> Borrar pago </a></strong></td>	    
	  </tr>  
	  </tbody>
	  <%}%>
	  </table>
	  <br>
	  <strong><a href="pagoPlanPago_edit.jsp"> Agregar pago </a></strong>
	  <br>
	  <br>
	 <%}%>
	<br>
	<br>	
	<div class="form-group">
		<form action="PlanPagoList">
		<input name="accion" type="hidden" value="visualizarPlan">
	    <input name="codplan" type="hidden" value="<%=plan.getCod_plan()%>">
		<button type="submit" class="btn btn-primary"  value="Volver al al Plan de Pagos">Volver al Plan de Pagos</button>
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
</body>
</html>