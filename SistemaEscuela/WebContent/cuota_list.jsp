<%@page import="conexion.AccionesAlumno"%>
<%@page import="datos.Cuota"%>
<%@page import="conexion.AccionesCuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Alumno_Grado"%>
<%@page import="datos.Alumnos_Grados"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.Alumnos"%>
<%@page import="conexion.AccionesGrado"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% 
     Alumnos alumnos = (Alumnos) session.getAttribute("alumnos_cuota");
     String grado = (String) session.getAttribute("gradoCuota");
     String turno = (String) session.getAttribute("turnoCuota");	
     int año = (Integer) session.getAttribute("añoCuota");
   
   %>			
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Listado de Cuotas</title>
</head>
<body>
	<center>
	<h1>Cuotas <%= grado + " - " + turno + " - " + año%> </h1>	
	  <table border= 1>
	  <tr>	  	    
	    <th> NOMBRE <th>
	    <th> TIPO DE COBRO<th>
	    <th> INSCRIPCION - <%= año%> <th>	    
	    <th> MARZO <th>
	    <th> ABRIL <th>
	    <th> MAYO  <th>
	    <th> JUNIO <th>
	    <th> JULIO <th>
	    <th> AGOSTO <th>
	    <th> SEPTIEMBRE <th>
	    <th> OCTUBRE <th>
	    <th> NOVIEMBRE <th>
	    <th> DICIEMBRE <th>
	    <th> INSCRIPCION - <%= año+1%> <th>
	    	    
	  </tr>
	  <% int cod_plan = 0;
	  
	  	for (Alumno a : alumnos.getLista()) { %>
	  <tr>	    
	  <% String tipoCobro = AccionesAlumno.getTipoCobro(a.getDni(), año); %>
	  
	    <td> <%=a.getNombre() + " " + a.getApellido() %><td>
	    	    
	    <td> <%= tipoCobro %> <td>
	    <td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año-1%>&&dni=<%=a.getDni()%>&&mes=13"> <%= "$"+AccionesCuota.getPagosTotalMes(a.getDni(), año-1, 13)%></a><td>

	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesCuota.checkPlanPagosMes(a.getDni(), año, 3)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=3"> <%= "$"+AccionesCuota.getPagosTotalMes(a.getDni(), año, 3) %> </a><td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="CuotaList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> PLAN DE PAGOS</a><td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>
	    
	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesCuota.checkPlanPagosMes(a.getDni(), año, 4)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=4"> <%= "$"+AccionesCuota.getPagosTotalMes(a.getDni(), año, 4) %> </a><td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="CuotaList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> PLAN DE PAGOS</a><td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>

	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesCuota.checkPlanPagosMes(a.getDni(), año, 5)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=5"> <%= "$"+AccionesCuota.getPagosTotalMes(a.getDni(), año, 5) %> </a><td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="CuotaList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> PLAN DE PAGOS</a><td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>

	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesCuota.checkPlanPagosMes(a.getDni(), año, 6)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=6"> <%= "$"+AccionesCuota.getPagosTotalMes(a.getDni(), año, 6) %> </a><td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="CuotaList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> PLAN DE PAGOS</a><td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>
	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesCuota.checkPlanPagosMes(a.getDni(), año, 7)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=7"> <%= "$"+AccionesCuota.getPagosTotalMes(a.getDni(), año, 7) %> </a><td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="CuotaList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> PLAN DE PAGOS</a><td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>
	    	    
	    	    
	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesCuota.checkPlanPagosMes(a.getDni(), año, 8)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=8"> <%= "$"+AccionesCuota.getPagosTotalMes(a.getDni(), año, 8) %> </a><td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="CuotaList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> PLAN DE PAGOS</a><td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>
	    	    
	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesCuota.checkPlanPagosMes(a.getDni(), año, 9)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=9"> <%= "$"+AccionesCuota.getPagosTotalMes(a.getDni(), año, 9) %> </a><td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="CuotaList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> PLAN DE PAGOS</a><td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>
	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesCuota.checkPlanPagosMes(a.getDni(), año, 10)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=10"> <%= "$"+AccionesCuota.getPagosTotalMes(a.getDni(), año, 10) %> </a><td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="CuotaList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> PLAN DE PAGOS</a><td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>

   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesCuota.checkPlanPagosMes(a.getDni(), año, 11)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=11"> <%= "$"+AccionesCuota.getPagosTotalMes(a.getDni(), año, 11) %> </a><td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="CuotaList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> PLAN DE PAGOS</a><td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>
	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesCuota.checkPlanPagosMes(a.getDni(), año, 12)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=12"> <%= "$"+AccionesCuota.getPagosTotalMes(a.getDni(), año, 12) %> </a><td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="CuotaList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> PLAN DE PAGOS</a><td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO<td>
	    <%}%>
	    	  
	  	<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=13"> <%= "$"+AccionesCuota.getPagosTotalMes(a.getDni(), año, 13)%></a><td>
	  	
	  <%}%>
	  </tr>
	  </table>
	<br>
	<br>
	<form action="menu_cuotas.jsp">
	  <input type="submit" value="Volver al Menú de Cuotas">
	</form>
	<br>
	<br>
	<form action="CerrarSesion">
	  <input type="submit" value="Cerrar Sesión">
	</form>
	</center>
</body>
</html>