<%@page import="datos.Alumno"%>
<%@page import="datos.Alumnos"%>
<%@page import="datos.Grados"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesCuota"%>
<%@page import="conexion.AccionesPlanPago"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% 
if (session.getAttribute("login") != null) {	

     Alumnos alumnos = (Alumnos) session.getAttribute("alumnos_cuota");
     String grado = (String) session.getAttribute("gradoCuota");
     String turno = (String) session.getAttribute("turnoCuota");	
     int a�o = (Integer) session.getAttribute("a�oCuota");
     
	 //las utilizo si ya se hab�a seleccionado un a�o en el menu de cobro
	 session.setAttribute("a�oMenuCuota", (Integer) session.getAttribute("a�oPlan"));
	 session.setAttribute("gradosMenuCuota", (Grados) session.getAttribute("gradosPlan"));
	 //las utilizo si ya se hab�a seleccionado un a�o en el menu de cobro

   
   %>			
<head>
<head>
<meta name="viewport" content="widtd=device-widtd; initial-scale=1.0"> 
<title>Listado de Cuotas</title>
<link rel="stylesheet" href="style/bootstrap.min.css">
</head>
<body>
<div class="container">
	<div class="page-header"> 
		<h1>Cuotas <%= grado + " - " + turno + " - " + a�o%> </h1>
	</div>	
	
	<table class="table table-hover">
	  <tr>	  	    
	    <td> NOMBRE </td>
	    <td> TIPO DE COBRO</td>
	    <td> INSCRIPCION - <%= a�o%> </td>	    
	    <td> MARZO </td>
	    <td> ABRIL </td>
	    <td> MAYO  </td>
	    <td> JUNIO </td>
	    <td> JULIO </td>
	    <td> AGOSTO </td>
	    <td> SEPTIEMBRE </td>
	    <td> OCTUBRE </td>
	    <td> NOVIEMBRE </td>
	    <td> DICIEMBRE </td>
	    <td> INSCRIPCION - <%= a�o+1%> </td>	    	    
	  </tr>
	  <% int cod_plan = 0;
	  
	  	for (Alumno a : alumnos.getLista()) { %>
	  <tr>	    
	  <% String tipoCobro = AccionesAlumno.getTipoCobro(a.getDni(), a�o); %>
	  
	    <td> <%=a.getNombre() + " " + a.getApellido() %></td>
	    	    
	    <td> <%= tipoCobro %> </td>
	    
	    	    
	    <%if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o-1, 13)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o-1%>&&dni=<%=a.getDni()%>&&mes=13"> <%= "$"+ AccionesCuota.getPagosDoublelMes(a.getDni(), a�o-1, 13)%></a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    <%}%>    

	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 3)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=3"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 3) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>
	    
	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 4)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=4"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 4) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>

	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 5)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=5"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 5) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>

	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 6)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=6"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 6) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>
	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 7)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=7"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 7) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>
	    	    
	    	    
	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 8)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=8"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 8) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>
	    	    
	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 9)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=9"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 9) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>
	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 10)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=10"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 10) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>

   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 11)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=11"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 11) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>
	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 12)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=12"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 12) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>
	   
		<%if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 13)) == 0){ %>
	    		    		    	
	    	<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=13"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 13)%></a></td>
	    		 
	    <%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>	    	
	    <%}%>	  	
	  	
	  <%}%>
	  </tr>
	  </table>
	<br>
	<br>
	<center>
	<a href="planPago_edit.jsp"> Armar plan de pagos</a>
	<br>
	<br>
		<a href="PrecioList?a�o=<%=a�o%>">Ver Precios <%=a�o%></a>
	<br>
	<br>	
	<div class="form-group"> 
	  <form action="menu_cuotas.jsp">		   
	   	<button type="submit" class="btn btn-primary"  value="Volver al Men� de Cuotas">Volver al Men� de Cuotas</button> 
	   </form>
	</div>
	</center>
	<br>
	<br>	
	<div class="form-group"> 
	  <form action="CerrarSesion">		   
	   	<button type="submit" class="btn btn-primary"  value="Cerrar Sesi�n">Cerrar Sesi�n</button> 
	   </form>
	</div>
 <%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</div>
</body>
</html>