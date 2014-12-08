<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.PlanPago"%>
<%@page import="datos.PagoPlanPago"%>
<%@page import="datos.PagosPlanPago"%>
<%@page import="datos.Mensaje"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesCuota"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesMensaje"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<% 
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "pagosPlanPago_list.jsp") != 1){							
		response.sendRedirect("Login");						
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
  	<!-- sirve para visualizar el men� superior -->
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
	if(plan.getPeriodoini() == 13) mesini="Inscripci�n";
	
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
	if(plan.getPeriodofin() == 13) mesfin="Inscripci�n";
	%>
	<div class="page-header">
		<h1><%= "Plan de pagos - "+ a.getNombre() + " " + a.getApellido() %></h1>
	</div>
	<h3><%= mesini + " " + plan.getA�oini() + " - "  + mesfin + " " + plan.getA�ofin() %> </h3>
	<br>
	<% if (pp.getLista().isEmpty()) { 
		
		Mensaje m = AccionesMensaje.getOne(47);
	%>
		<div class="bs-example">
    	<div class="alert <%=m.getTipo()%>" role="alert">
    	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <%=m.getMensaje()%><a href="pagoPlanPago_edit.jsp" class="alert-link"> Agregar pagos</a>
    	</div>
    </div>	
	<%}else{%>	
	  <table class="table table-hover table-bordered">
	  <thead>
	  <tr class="active">	  	    
	    <th>Fecha</th>
	    <th>Pago</th>
	    <th>Observaciones</th>
	    <th>&nbsp;</th>	    
	    <th>&nbsp;</th>	    	    
	  </tr>	 
	  </thead> 
	  <% for (PagoPlanPago p : pp.getLista()) {
		  
	  	String fecha_pago = p.getFecha();		
		String[] fecha_ent = fecha_pago.split ("-");
				
		String dia_pago = fecha_ent[fecha_ent.length - 1];
		String mes_pago = fecha_ent[fecha_ent.length - 2];
		int a�o_pago = Integer.parseInt(fecha_ent[fecha_ent.length - 3]);
		%>
	  <tbody>
	  <tr>    
	  
	    <td><%= dia_pago + "/" + mes_pago + "/" + a�o_pago %></td>
	    <td><%="$" + p.getPago()%></td>
	    <td><%= p.getObservaciones() %></td>
	    <td><strong><a href="PlanPagoList?accion=modificarPagopp&&cod_pago=<%=p.getCod_pago() %>"><i class="glyphicon glyphicon-pencil"></i> Editar </a></strong></td>	  
	    <td><strong><a href="PlanPagoList?accion=borrarPagopp&&cod_pago=<%=p.getCod_pago()%>" onclick=<%=AccionesMensaje.getOne(32).getMensaje()%>><i class="glyphicon glyphicon-trash"></i> Borrar </a></strong></td>	    
	  </tr>  
	  </tbody>
	  <%}%>
	  </table>
	  <br>
	  <strong><a href="pagoPlanPago_edit.jsp"><i class="glyphicon glyphicon-edit"></i> Nuevo pago </a></strong>
	  <br>
	  <br>
	 <%}%>
	<br>
	<br>	
	<div class="form-group">
		<form action="PlanPagoList">
		<input name="accion" type="hidden" value="visualizarPlan">
	    <input name="codplan" type="hidden" value="<%=plan.getCod_plan()%>">
		<button type="submit" class="btn btn-primary"  value="Volver al al Plan de Pagos"><i class="glyphicon glyphicon-share-alt"></i> Volver al Plan de Pagos</button>
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

	<!-- men� superior -->
	<script src="js/menu_admin.js"></script>
</body>
</html>