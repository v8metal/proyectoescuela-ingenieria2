<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesCuota"%>
<%@page import="conexion.AccionesAlumno"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>			
<head>
<%session.setAttribute("modulo", "cuotas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de pagos por d�a</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<!--<link rel="stylesheet" href="style/jquery-ui.css">  con ese no se ven las flechitas-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">

</head>
<body>
<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el men� superior -->
  </div>
  
<% 
	int tipo = (Integer) session.getAttribute("tipoUsuario");
	if (AccionesUsuario.validarAcceso(tipo, "pagos_dia.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
	
	String type = "";

	String cuotas = "-1";
	String planes = "-1";
	String inscripciones = "-1";
	String total = "-1";
	
	if (request.getAttribute("totalcuotas") != null){
		
		cuotas = (String) request.getAttribute("totalcuotas");
		planes = (String) request.getAttribute("totalplanes");
	    inscripciones = (String) request.getAttribute("totalinscripciones");
	    total = (String) request.getAttribute("totaldia");	    
	    
	    //las utilizo si ya se hab�a seleccionado un a�o en el menu de cobro
	    session.setAttribute("a�oMenuCuota", (Integer) session.getAttribute("a�oPlan"));
		session.setAttribute("gradosMenuCuota", (Grados) session.getAttribute("gradosPlan"));
		//las utilizo si ya se hab�a seleccionado un a�o en el menu de cobro
	}
	
    String fecha = null;
    
    if( request.getAttribute("fecha_dia") != null){
    	type = "readonly";
    	fecha = (String) request.getAttribute("fecha_dia");
    }
    
    int min = AccionesAlumno.getA�oAlumnos("MIN");
	int max = AccionesAlumno.getA�oAlumnos("MAX");
    
%>

	<div class="page-header">  	  
		<h1>Listado de pagos por dia</h1>		
    </div>
    
    <div class="form-group">
    		
	<form action="CuotaList" method="get">
	
	<input name="fecha" id="fecha" type="hidden" value="<%=fecha!=null?fecha:"0"%>">
	<input name="min" id="min" type="hidden" value="<%=min%>">
	<input name="max" id="max" type="hidden" value="<%=max%>">
	
	<table class="table table-hover table-bordered">	
		<tr>
			<th><label for="input">Fecha:</label></th>			
			<td>
			<div class="col-xs-3">
				<input <%=type%> class="form-control" type="text" id="datepicker" required autofocus name="fecha_pagos">
			</div>
			</td>			
		</tr>
		<% if(!cuotas.equals("-1")){ %>
		<tr>			
		<td>Total Cuotas: </td>		
		<td>
			<div class="col-xs-5">	
			<%="$ " + cuotas%>
			</div>		
		</td>		
		</tr>
				<tr>			
		<td>Planes de Pago: </td>		
		<td>
			<div class="col-xs-5">	
			<%="$ " + planes%>
			</div>		
		</td>		
		</tr>	
		<tr>		
		<td>Total Inscripciones: </td>				
		<td><div class="col-xs-5">
			<%="$ " + inscripciones%>
			</div>
		</td>				
		</tr>
		<tr>		
		<th>Total dia: </th>				
		<td><div class="col-xs-5">
			<%="$ " + total%>
			</div>
		</td>				
		</tr>		
		<% 
		}
		
	if(cuotas.equals("-1")){ %>
		<tr>
			<td></td>
			<td>
			<div class="col-xs-5">
			    <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnSave"><i class="glyphicon glyphicon-floppy-disk"></i> Aceptar</button>
				<button type="reset" class="btn btn-primary"  value="Reset" name="btnSave"><i class="glyphicon glyphicon-remove"></i> Cancelar</button>		
	            <input type="hidden" name="accion" value="pagosDia">
	         </div>
	        </td>	        
	    </tr>	
	<%}%>        
	  </table>	  
	</form>	
	</div>
	<br>
	<br>
<table>
<tr>
	<td> 
		<div class="form-group"> 
		   <form action="menu_cuotas.jsp">		   
		   <button type="submit" class="btn btn-primary"  value="Volver al Men� anterior"><i class="glyphicon glyphicon-share-alt"></i> Volver al Men� anterior</button> 
		   </form>
		</div>
	</td>	
	
<%if(!cuotas.equals("-1")){%>
	
	<td> 
		<div class="form-group"> 
		   <form action="pagos_dia.jsp">		   
		   <button type="submit" class="btn btn-primary"  value="Seleccionar otro dia"> Seleccionar otro dia <i class="glyphicon glyphicon-pushpin"></i></button> 
		   </form>
		</div>
	</td>
<%}%>
</tr>
</table>
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
	
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/pagosdia.js"></script> <!-- DatePic para tardanzas -->	
</body>
</html>