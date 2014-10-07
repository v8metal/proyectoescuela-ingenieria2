<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.PlanPago"%>
<%@page import="datos.PagoPlanPago"%>
<%@page import="datos.PagosPlanPago"%>
<%@page import="conexion.AccionesCuota"%>
<%@page import="conexion.AccionesAlumno"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% PagosPlanPago pp = (PagosPlanPago) request.getAttribute("pagospp");
   PlanPago plan = (PlanPago) session.getAttribute("planPagos");
   Alumno a = (Alumno) request.getAttribute("alumnopp");
%>			
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Listado de pagos</title>
</head>
<body>
	<center>
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
	<h1><%= "Plan de pagos - "+ a.getNombre() + " " + a.getApellido() %></h1>
	<h2><%= mesini + " " + plan.getAñoini() + " - "  + mesfin + " " + plan.getAñofin() %> </h2>
	<% if (pp.getLista().isEmpty()) { %>
	<a href="pagoPlanPago_edit.jsp"> No hay pagos para el mes, agregar pagos</a>
	<%}else{%>	
	  <table border= 1>
	  <tr>	  	    
	    <th> FECHA </th>
	    <th> PAGO  </th>
	    <th> OBSERVACIONES </th>
	    <th> MODIFICAR </th>	    
	    <th> BORRAR </th>	    	    
	  </tr>	  
	  <% for (PagoPlanPago p : pp.getLista()) {
		  
	  	String fecha_pago = p.getFecha();		
		String[] fecha_ent = fecha_pago.split ("-");
				
		String dia_pago = fecha_ent[fecha_ent.length - 1];
		String mes_pago = fecha_ent[fecha_ent.length - 2];
		int año_pago = Integer.parseInt(fecha_ent[fecha_ent.length - 3]);
		%>
	  <tr>    
	  
	    <td><%= dia_pago + "/" + mes_pago + "/" + año_pago %></td>
	    <td><%="$" + p.getPago()%></td>
	    <td><%= p.getObservaciones() %></td>
	    <td><a href="PlanPagoList?accion=modificarPagopp&&cod_pago=<%=p.getCod_pago() %>"> Modificar pago </a></td>	  
	    <td><a href="PlanPagoList?accion=borrarPagopp&&cod_pago=<%=p.getCod_pago()%>"> Borrar pago </a></td>	    
	  </tr>  
	  <%}%>
	  </table>
	  <br>
	  <br>
	  <a href="pagoPlanPago_edit.jsp"> Agregar pago </a>
	 <%}%>
	<br>
	<br>	
	<form action="PlanPagoList">
	  <input name="accion" type="hidden" value="visualizarPlan">
	  <input name="codplan" type="hidden" value="<%=plan.getCod_plan()%>">
	  <input type="submit" value="Volver al Plan de Pagos">
	</form>
	<br>
	<br>
	<form action="CerrarSesion">
	  <input type="submit" value="Cerrar Sesión">
	</form>
	</center>
</body>
</html>