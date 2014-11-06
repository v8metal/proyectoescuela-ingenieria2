<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesCuota"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>			
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de pagos por día</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<!--<link rel="stylesheet" href="style/jquery-ui.css">  con ese no se ven las flechitas-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="js/jquery-1.10.2.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/tardanzas.js"></script> <!-- DatePic para entrevistas -->

</head>
<body>
<div class="container">

<!-- Fixed navbar -->
    <div class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Sistema</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li><a href="menu_admin.jsp">Menú</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Alumnos <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="menu_listado_alum.jsp">Listado</a></li>
                  <li><a href="alumno_edit.jsp">Nuevo alumno</a></li>          
                  <li class="divider"></li>
                  <li class="dropdown-header">Nav header</li>
                  <li><a href="alumnoInactivo?do=listar">Registro de bajas</a></li>
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Grados <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="GradoList?listar=mañana">Turno mañana</a></li>                 
                  <li><a href="GradoList?listar=tarde">Turno tarde</a></li>          
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Maestros <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="maestroList">Listado</a></li>
                  <li><a href="maestroEdit?accion=alta">Nuevo maestro</a></li>          
                  <li class="divider"></li>
                  <li><a href="MaestroList?tipo=inactivos">Registro de bajas</a></li>
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Materias <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="materiaList?from=menu_admin">Listado</a></li>
                  <li><a href="materiaEdit?do=alta">Nueva materia</a></li>          
                  <li class="divider"></li>
                  <li><a href="materiaList?from=materia_inactiva_list">Materias inactivas</a></li>
                </ul>
              </li>
              <li><a href="menu_tardanzas.jsp">Tardanzas</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Entrevistas <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="EntrevistaList">Listado</a></li>
                  <li><a href="EntrevistaEdit?do=alta">Nueva entrevista</a></li>          
                </ul>
              </li>
              <li class="active"><a href="menu_cuotas.jsp">Cuotas</a></li>
              <li><a href="UsuarioList">Usuarios</a></li>
               <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Cuenta <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="admin_user.jsp">Cambiar usuario</a></li>
                  <li><a href="admin_pass.jsp">Cambiar contraseña</a></li>          
                </ul>
              </li>
           </ul>
           <ul class="nav navbar-nav navbar-right">
            <li>
            	<div class="navbar-collapse collapse">
        		  <form action="cerrarSesion" method="post" class="navbar-form navbar-right" role="form">
           		 	<button type="submit" class="btn btn-primary">Salir</button>
        		  </form>
        		</div>
			</li>
          </ul>
        </div>
      </div>
    </div>
  
  <br>
  <br>
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
	    
	    //las utilizo si ya se había seleccionado un año en el menu de cobro
	    session.setAttribute("añoMenuCuota", (Integer) session.getAttribute("añoPlan"));
		session.setAttribute("gradosMenuCuota", (Grados) session.getAttribute("gradosPlan"));
		//las utilizo si ya se había seleccionado un año en el menu de cobro
	}
	
    String fecha = null;
    
    if( request.getAttribute("fecha_dia") != null){
    	type = "readonly";
    	fecha = (String) request.getAttribute("fecha_dia");
    }
    
%>
	<!-- <center> -->
	<div class="page-header">  	  
		<h1>Listado de pagos por dia</h1>		
    </div>
    
    <div class="form-group">
    		
	<form action="CuotaList" method="get">
	
	<input name="fecha" id="fecha" type="hidden" value="<%=fecha!=null?fecha:"0"%>">
	
	<table class="table table-hover table-bordered">	
		<tr>
			<th><label for="input">Fecha:</label></th>			
			<td>
			<div class="col-xs-5">
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
			    <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnSave">Aceptar</button>
				<button type="reset" class="btn btn-primary"  value="Reset" name="btnSave">Cancelar</button>		
	            <input type="hidden" name="accion" value="pagosDia">
	         </div>
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
	
<%if(!cuotas.equals("-1")){%>
	
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
<!-- </center> -->
</div>
</body>
</html>