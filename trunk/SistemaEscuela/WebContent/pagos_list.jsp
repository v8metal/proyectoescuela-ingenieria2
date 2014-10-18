<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="datos.Alumno"%>
<%@page import="conexion.AccionesCuota"%>
<%@page import="conexion.AccionesAlumno"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% 
if (session.getAttribute("admin") != null) {

   Cuotas cuotas = (Cuotas) session.getAttribute("pagosMes");//lo dejamos como session para poder utilizarlo
   int año = (Integer) session.getAttribute("año");
   int dni = (Integer) session.getAttribute("dni");
   int mes = (Integer) session.getAttribute("mes");   
%>			
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de pagos</title>
<link rel="stylesheet" href="style/bootstrap.min.css">
</head>
<body>
<div class="container">
	<center>
	<% Alumno a = AccionesAlumno.getOne(dni); %>
	<h1><%= a.getNombre() + " " + a.getApellido() + " - " + año + "- Mes " + mes%> </h1>
	<% if (cuotas.getLista().isEmpty()) { %>
	<a href="pago_edit.jsp"> No hay pagos para el mes, agregar pagos</a>
	<%}else{%>	
	  <table class="table table-hover table-bordered">
	  <tr>	  	    
	    <th> FECHA </th>
	    <th> PAGO  </th>
	    <th> OBSERVACIONES </th>
	    <th> MODIFICAR </th>	    
	    <th> BORRAR </th>	    	    
	  </tr>	  
	  <% for (Cuota c : cuotas.getLista()) {
		  
	  	String fecha_pago = c.getFecha();		
		String[] fecha_ent = fecha_pago.split ("-");
				
		String dia_pago = fecha_ent[fecha_ent.length - 1];
		String mes_pago = fecha_ent[fecha_ent.length - 2];
		int año_pago = Integer.parseInt(fecha_ent[fecha_ent.length - 3]);
		%>
	  <tr>    
	  
	    <td><%= dia_pago + "/" + mes_pago + "/" + año_pago %></td>
	    <td><%="$" + c.getPago()%></td>
	    <td><%= c.getObservaciones() %></td>
	    <td><a href="CuotaEdit?accion=modificarPago&&cod_pago=<%=c.getCod_pago()%>" > Modificar pago </a></td>	  
	    <td><a href="CuotaEdit?accion=borrarPago&&cod_pago=<%=c.getCod_pago()%>" onclick="return confirm('Esta seguro que desea borrar el pago?');"> Borrar pago </a></td>	    
	  </tr>  
	  <%}%>
	  </table>
	  <br>
	  <br>
	  <a href="pago_edit.jsp"> Agregar pago </a>
	 <%}%>
	<br>
	<br>	
	<div class="form-group">
		<form action="CuotaList">
		<input name="accion" type="hidden" value="listarGrado">
		<button type="submit" class="btn btn-primary"  value="Volver al listado de Pagos">Volver al listado de Pagos</button>
		</form>
	</div>
	<br>
	<br>
	</center>
	<div class="form-group">
		<form action="CerrarSesion">		
		<button type="submit" class="btn btn-primary"  value="Cerrar Sesión">Cerrar Sesión</button>
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