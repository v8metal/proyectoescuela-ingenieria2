<%@page import="datos.Alumno"%>
<%@page import="datos.Alumnos"%>
<%@page import="datos.Grados"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesCuota"%>
<%@page import="conexion.AccionesPlanPago"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<% 
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "cuota_list.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}

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
<%session.setAttribute("modulo", "cuotas");%>
<meta name="viewport" content="widtd=device-widtd; initial-scale=1.0"> 
<title>Listado de Cuotas</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

</head>
<body>
<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el men� superior -->
  </div>
  
	<div class="page-header"> 
		<h1>Cuotas <%= grado + " - " + turno + " - " + a�o%> </h1>
	</div>	
	
	<table class="table table-hover">
	  <thead>
	  <tr class="active">	  	    
	    <th> NOMBRE </th>
	    <th> TIPO DE COBRO</th>
	    <th> INSCRIPCION - <%= a�o%> </th>	    
	    <th> MARZO </th>
	    <th> ABRIL </th>
	    <th> MAYO  </th>
	    <th> JUNIO </th>
	    <th> JULIO </th>
	    <th> AGOSTO </th>
	    <th> SEPTIEMBRE </th>
	    <th> OCTUBRE </th>
	    <th> NOVIEMBRE </th>
	    <th> DICIEMBRE </th>
	    <th> INSCRIPCION - <%= a�o+1%> </th>	    	    
	  </tr>
	  </thead>
	  <% int cod_plan = 0;
	  
	  	for (Alumno a : alumnos.getLista()) { %>
	  <tbody> 	
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
	    	<td> SUBSIDIO</td>
	    <%}%>
	    
	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 4)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=4"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 4) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO</td>
	    <%}%>

	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 5)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=5"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 5) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO</td>
	    <%}%>

	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 6)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=6"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 6) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO</td>
	    <%}%>
	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 7)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=7"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 7) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO</td>
	    <%}%>
	    	    
	    	    
	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 8)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=8"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 8) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO</td>
	    <%}%>
	    	    
	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 9)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=9"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 9) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO</td>
	    <%}%>
	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 10)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=10"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 10) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO</td>
	    <%}%>

   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 11)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=11"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 11) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO</td>
	    <%}%>
	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 12)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=12"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 12) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO</td>
	    <%}%>
	   
		<%if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), a�o, 13)) == 0){ %>
	    		    		    	
	    	<td> <a href="CuotaList?accion=visualizarPagos&&a�o=<%=a�o%>&&dni=<%=a.getDni()%>&&mes=13"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), a�o, 13)%></a></td>
	    		 
	    <%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>	    	
	    <%}%>	  	
	  	
	  <%}%>
	  </tr>
	  </tbody>
	  </table>	
	<br>
	<br>
		<p><strong><a href="planPago_edit.jsp"> Armar plan de pagos</a></strong></p>
	<br>
		<p><strong><a href="PrecioList?a�o=<%=a�o%>"><i class="glyphicon glyphicon-usd"></i> Ver Precios <%=a�o%></a></strong></p>
	<br>
	<br>	
	<div class="form-group"> 
	  <form action="menu_cuotas.jsp">		   
	   	<button type="submit" class="btn btn-primary"  value="Volver al Men� de Cuotas"><i class="glyphicon glyphicon-share-alt"></i> Volver al Men� de Cuotas</button> 
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