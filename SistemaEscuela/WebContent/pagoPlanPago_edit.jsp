<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.PlanPago"%>
<%@page import="datos.PagoPlanPago"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesPlanPago"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>PAgos</title>
</head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<body>
<center>
 <% 
 	PlanPago plan = (PlanPago) session.getAttribute("planPagos");	
 	PagoPlanPago ppp = (PagoPlanPago) request.getAttribute("pagopp");
 	
 	if (plan != null){
 %>  		
 <h1>Modificar Pago</h1>
 <%}else{%> 
 <h1>Alta de Pago</h1>
 <%}%>
<%
	if (session.getAttribute("login") != null) {

		Alumno a =  AccionesAlumno.getOne(plan.getDni());
		
	//if (plan != null){
		
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
		
<h1><%= "Plan de pagos - "+ a.getNombre() + " " + a.getApellido() %></h1>
<h2><%= mesini + " " + plan.getA�oini() + " - "  + mesfin + " " + plan.getA�ofin() %> </h2>	

<%
	int dia_pp = 0;
	String mes_pp = "";
	int a�o_pp = 0;
	
	if (ppp != null) {
		//recupero la fecha
		String fecha_pago = ppp.getFecha() ;
		//separo la fecha (1990-01-01) por el "-"" y almaceno el a�o, mes y dia en un array
		String[] fecha_ent = fecha_pago.split ("-");
		//obtengo el dia, mes y a�o respectivamente
		dia_pp = Integer.parseInt(fecha_ent[fecha_ent.length - 1]);
		mes_pp = fecha_ent[fecha_ent.length - 2];
		a�o_pp= Integer.parseInt(fecha_ent[fecha_ent.length - 3]);
		
	}else{	
	//Alta de pago	
	   	dia_pp = Integer.valueOf((String)session.getAttribute("dia_sys"));
		
	   	mes_pp = (String) session.getAttribute("mes_sys");
	   	
	   	//System.out.println("mes_ppp= " + mes_ppp);
	   	//System.out.println("mes_pp.substring(0,1)= " + mes_pp.substring(0,1));	   	
	   	
	   	if (!mes_pp.substring(0,1).equals("1")){		
	   		mes_pp = "0" + mes_pp;	   	
	   	}
	   	
	   	a�o_pp = Integer.valueOf((String)session.getAttribute("a�o_sys"));
	 //Alta de pago  
	}
	
	//System.out.println("mes= " + mes_ppp);
   	%>
	<form action="PlanPagoList" method="get">
	<%if (ppp != null) { %>
	<input name=accion type=hidden value ="modificarPagopp2">
	<%}else{%>
	<input name=accion type=hidden value ="altaPagopp">
	<%}%>	
	<table>		
				<tr>
				<td>Fecha </td>
				<td><select name="diapp">   
					<%  
					for (int i = 1; i <= 31; i++){			  	
		 			%>
					 	<option <%=dia_pp==i ? "selected" : ""%>><%=i%></option>		 	
		   			<%
					}	
					%>

		 		</select>
		 		
  			 	<select name="mespp">
  			 	
  			 	<option value="01" <%=mes_pp.equals("01") ? "selected" : ""%>>Enero</option>
			 	<option value="02" <%=mes_pp.equals("02") ? "selected" : ""%>>Febrero</option>
			 	<option value="03" <%=mes_pp.equals("03") ? "selected" : ""%>>Marzo</option>
			 	<option value="04" <%=mes_pp.equals("04") ? "selected" : ""%>>Abril</option>
			 	<option value="05" <%=mes_pp.equals("05") ? "selected" : ""%>>Mayo</option>
			 	<option value="06" <%=mes_pp.equals("06") ? "selected" : ""%>>Junio</option>
				<option value="07" <%=mes_pp.equals("07") ? "selected" : ""%>>Julio</option>
			 	<option value="08" <%=mes_pp.equals("08") ? "selected" : ""%>>Agosto</option>
			 	<option value="09" <%=mes_pp.equals("09") ? "selected" : ""%>>Septiembre</option>
				<option value="10" <%=mes_pp.equals("10") ? "selected" : ""%>>Octubre</option>
			 	<option value="11" <%=mes_pp.equals("11") ? "selected" : ""%>>Noviembre</option>
			 	<option value="12" <%=mes_pp.equals("12") ? "selected" : ""%>>Diciembre</option>	   			 		
 			 	</select> 			 	
		  		</td>
		  		<td> <input name="a�opp" type="hidden" value="<%=a�o_pp%>">  </td>
		  	<tr>	
		<tr>
			<td>PAGO</td>
			<td><input type="text" name="pagopp" value="<%=ppp!=null?ppp.getPago(): ""%>"></td>
		</tr>
		
		<tr>
			<td>OBSERVACIONES</td>
			<td><textarea name="obspp" cols="40" rows="1"><%=ppp!=null?ppp.getObservaciones(): ""%></textarea></td>			
		</tr>
		
	</table> 
	<br>
	<br>
	<%if (ppp != null) { %>
	<input type="submit" value="Realizar modificaci�n">
	<input type="hidden" name="cod_pago" value="<%= ppp.getCod_pago()%>">	
	<%}else{%>
	<input type="submit" value="Realizar alta">
	<%}%>	
	</form>
<br>
<br>
<form action="PlanPagoList" method="get">
<input name="accion" type="hidden" value="listarPagosPlan">
<input name="codplan" type="hidden" value="<%=plan.getCod_plan()%>">
<input type="submit" value="Volver atr�s">
</form>
</center>
 <%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>