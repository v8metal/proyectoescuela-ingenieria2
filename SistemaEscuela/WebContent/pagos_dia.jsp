<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="conexion.AccionesCuota"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>			
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de pagos por dia</title>
<link rel="stylesheet" href="style/bootstrap.min.css">
</head>
<body>
<div class="container">
<% 
	if (session.getAttribute("login") != null) {
	
	String type = "";

	String pagos = "-1";
	String inscripciones = "-1";
	
	if (request.getAttribute("totalcuotas") != null){
		
		pagos = (String) request.getAttribute("totalcuotas");
	    inscripciones = (String) request.getAttribute("totalinscripciones");    
	    
	    //las utilizo si ya se había seleccionado un año en el menu de cobro
	    session.setAttribute("añoMenuCuota", (Integer) session.getAttribute("añoPlan"));
		session.setAttribute("gradosMenuCuota", (Grados) session.getAttribute("gradosPlan"));
		//las utilizo si ya se había seleccionado un año en el menu de cobro
	}
		
    int año_pago = (Integer) session.getAttribute("añoPlan");    
	
    int dia_pago = 0;
    
    if(!pagos.equals("-1")){
		type = "readonly";
		dia_pago = (Integer) request.getAttribute("dia_consulta");
		
	}else{
		dia_pago = Integer.parseInt((String) session.getAttribute("dia_sys"));   
	}
	
    int mes= Integer.parseInt((String) session.getAttribute("mes_sys"));
	String mes_pago = "";
	
	if (mes < 10){
		mes_pago = "0" + mes;	
	}else{
		mes_pago = "" + mes;
	}
	
	String mespago = "";
	
	if(!pagos.equals("-1")){
		
	
	if(mes_pago.equals("01")) mespago="Enero";
	if(mes_pago.equals("02")) mespago="Febrero";
	if(mes_pago.equals("03")) mespago="Marzo";
	if(mes_pago.equals("04")) mespago="Abril";
	if(mes_pago.equals("05")) mespago="Mayo";
	if(mes_pago.equals("06")) mespago="Junio";
	if(mes_pago.equals("07")) mespago="Julio";
	if(mes_pago.equals("08")) mespago="Agosto";
	if(mes_pago.equals("09")) mespago="Septiembre";
	if(mes_pago.equals("10")) mespago="Octubre";
	if(mes_pago.equals("11")) mespago="Noviembre";
	if(mes_pago.equals("12")) mespago="Diciembre";

	}
%>
	<center>
	<div class="page-header">  	  
		<h1>Listado de pagos por dia - año <%=año_pago%></h1>		
    </div>
    
    <div class="form-group">
    		
	<form action="CuotaList" method="get">
	
	<table class="table table-hover table-bordered">	
	<%if(pagos.equals("-1")){%>      
		<tr>
				<td>Fecha </td>
				<td><select <%=type%> class="form-control" name="dia_consulta">   
					<%  
					for (int i = 1; i <= 31; i++){			  	
		 			%>
					 	<option <%=dia_pago==i ? "selected" : ""%>><%=i%></option>		 	
		   			<%
					}	
					%>
		 			 </select>
		  			 <select class="form-control" <%=type%> name="mes_consulta">
		  			 <option value="01" <%=mes_pago.equals("01") ? "selected" : ""%>>Enero</option>
					 <option value="02" <%=mes_pago.equals("02") ? "selected" : ""%>>Febrero</option>
					 <option value="03" <%=mes_pago.equals("03") ? "selected" : ""%>>Marzo</option>
					 <option value="04" <%=mes_pago.equals("04") ? "selected" : ""%>>Abril</option>
					 <option value="05" <%=mes_pago.equals("05") ? "selected" : ""%>>Mayo</option>
					 <option value="06" <%=mes_pago.equals("06") ? "selected" : ""%>>Junio</option>
					 <option value="07" <%=mes_pago.equals("07") ? "selected" : ""%>>Julio</option>
					 <option value="08" <%=mes_pago.equals("08") ? "selected" : ""%>>Agosto</option>
					 <option value="09" <%=mes_pago.equals("09") ? "selected" : ""%>>Septiembre</option>
					 <option value="10" <%=mes_pago.equals("10") ? "selected" : ""%>>Octubre</option>
					 <option value="11" <%=mes_pago.equals("11") ? "selected" : ""%>>Noviembre</option>
					 <option value="12" <%=mes_pago.equals("12") ? "selected" : ""%>>Diciembre</option>	   			 		
		 			 </select>
		 			 
		</tr>
		<%}else{%>
		<tr>
			<td>Fecha </td>			
			<td>
				<input class="form-control" readonly size= 2 name="dia_plan" type="text" value="<%=dia_pago %>"> 				 		
  			 	<input class="form-control" readonly size= 10 name="mes_plan" type="text" value="<%=mespago%>">		  	      
		  	</td>
		</tr>
		<%}%>
		<% if(!pagos.equals("-1")){ %>
		<tr>		
		<td>Total Cuotas/Planes de Pago: </td>
		<td><%="$ " + pagos%></td>
		</tr>
		<tr>
		<td>Total Inscripciones: </td>
		<td><%="$ " + inscripciones%></td>
		</tr>	
	<% 
	}
	if(pagos.equals("-1")){ %>
		<tr>
			<td></td>
			<td>		
			    <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnSave">Aceptar</button>
				<button type="reset" class="btn btn-primary"  value="Reset" name="btnSave">Cancelar</button>		
	            <input type="hidden" name="accion" value="pagosDia">
	        </td>	        
	    </tr>	
	<%}%>        
	  </table>	  
	</form>	
	<br>
	<br>
<table>
<tr>
	<td> 
		<div class="form-group"> 
		   <form action="menu_cuotas.jsp">		   
		   <button type="submit" class="btn btn-primary"  value="Volver al Menú anterior">Volver al Menú anterior</button> 
		   </form>
		</div>
	</td>	
	
<%if(!pagos.equals("-1")){%>
	
	<td> 
		<div class="form-group"> 
		   <form action="pagos_dia.jsp">		   
		   <button type="submit" class="btn btn-primary"  value="Seleccionar otro dia">Seleccionar otro dia</button> 
		   </form>
		</div>
	</td>
	
<%}%>
</tr>
</table>
<br>
	
<div class="form-group">
<form action="CerrarSesion">
	<button type="submit" class="btn btn-primary"  value="Cerrar Sesión">Cerrar Sesión</button>
</form>
</div>
</center>
	<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</div>
</body>
</html>