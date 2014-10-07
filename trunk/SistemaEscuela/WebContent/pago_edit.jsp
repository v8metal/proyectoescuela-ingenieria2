<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Alumno"%>
<%@page import="conexion.AccionesAlumno"%>
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
 if (session.getAttribute("login") != null) {
	 
 	Cuota cuota = (Cuota) session.getAttribute("pagoEdit");
    int dni = (Integer) session.getAttribute("dni");
 	int a�o = (Integer) session.getAttribute("a�o");
 	int mes = (Integer) session.getAttribute("mes");
 	
 	if (cuota != null){
 %>  		
 <h1>Modificar Pago</h1>
 <%}else{%> 
 <h1>Alta de Pago</h1>
 <%}%>
<%
	Alumno a = null;
		
	if (cuota != null){
	
		a = AccionesAlumno.getOne(cuota.getDni());
	%>	
<h2><%=a.getNombre() + " " + a.getApellido() + " - A�o " + cuota.getA�o() + " - Mes= " + cuota.getPeriodo() %></h2>
   <%}else{ 
   		
   		a = AccionesAlumno.getOne(dni);
   	%>
   	
<h2><%=a.getNombre() + " " + a.getApellido() + " - A�o " + a�o + " - Mes= " + mes %></h2>

   <%}  
	
	int dia_pago = 0;
	String mes_pago = "";
	int a�o_pago = 0;
	
	if (cuota != null) {
		//recupero la fecha
		String fecha_pago = cuota.getFecha();
		//separo la fecha (1990-01-01) por el "-"" y almaceno el a�o, mes y dia en un array
		String[] fecha_ent = fecha_pago.split ("-");
		//obtengo el dia, mes y a�o respectivamente
		dia_pago = Integer.parseInt(fecha_ent[fecha_ent.length - 1]);
		mes_pago = fecha_ent[fecha_ent.length - 2];
		a�o_pago = Integer.parseInt(fecha_ent[fecha_ent.length - 3]);
		
	}else{	
	//Alta de pago	
	   	dia_pago = Integer.valueOf((String)session.getAttribute("dia_sys"));
		
	   	mes_pago = (String) session.getAttribute("mes_sys");
	   	
	   	//System.out.println("mes_pago= " + mes_pago);
	   	//System.out.println("mes_pago.substring(0,1)= " + mes_pago.substring(0,1));	   	
	   	
	   	if (!mes_pago.substring(0,1).equals("1")){		
	   		mes_pago = "0" + mes_pago;	   	
	   	}
	   	
	   	a�o_pago = Integer.valueOf((String)session.getAttribute("a�o_sys"));
	 //Alta de pago  
	}
	
	//System.out.println("mes= " + mes_pago);
   	%>
	<form action="CuotaEdit" method="<%=cuota!= null?"post":"get"%>">
	<%if (cuota != null) { %>
	<input name=accion type=hidden value ="modificarPago">
	<%}else{%>
	<input name=accion type=hidden value ="altaPago">
	<%}%>	
	<table>		
				<tr>
				<td>Fecha </td>
				<td><select name="dia_pago">   
					<%  
					for (int i = 1; i <= 31; i++){			  	
		 			%>
					 	<option <%=dia_pago==i ? "selected" : ""%>><%=i%></option>		 	
		   			<%
					}	
					%>

		 		</select>
		 		
  			 	<select name="mes_pago">
  			 	
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
		  		</td>
		  		<td> <input name="a�o_pago" type="hidden" value="<%=a�o%>">  </td>
		  	<tr>	
		<tr>
			<td>PAGO</td>
			<td><input type="text" name="pago" value="<%=cuota!=null?cuota.getPago(): ""%>"></td>
		</tr>
		
		<tr>
			<td>OBSERVACIONES</td>
			<td><textarea name="obs" cols="40" rows="1"><%=cuota!=null?cuota.getObservaciones(): ""%></textarea></td>			
		</tr>
		
	</table> 
	<br>
	<br>
	<%if (cuota != null) { %>
	<input type="submit" value="Realizar modificaci�n">	
	<%}else{%>
	<input type="submit" value="Realizar alta">
	<%}%>	
	</form>
<br>
<br>
<form action="CuotaList" method="get">
<input name="accion" type="hidden" value="visualizarPagos">
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