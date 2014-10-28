<%@page import="datos.Alumno"%>
<%@page import="datos.Alumnos"%>
<%@page import="datos.Grados"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesCuota"%>
<%@page import="conexion.AccionesPlanPago"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<% 
if (session.getAttribute("admin") != null) {	

     Alumnos alumnos = (Alumnos) session.getAttribute("alumnos_cuota");
     String grado = (String) session.getAttribute("gradoCuota");
     String turno = (String) session.getAttribute("turnoCuota");	
     int año = (Integer) session.getAttribute("añoCuota");
     
	 //las utilizo si ya se había seleccionado un año en el menu de cobro
	 session.setAttribute("añoMenuCuota", (Integer) session.getAttribute("añoPlan"));
	 session.setAttribute("gradosMenuCuota", (Grados) session.getAttribute("gradosPlan"));
	 //las utilizo si ya se había seleccionado un año en el menu de cobro

   
   %>			
<head>
<meta name="viewport" content="widtd=device-widtd; initial-scale=1.0"> 
<title>Listado de Cuotas</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

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
  
	<div class="page-header"> 
		<h1>Cuotas <%= grado + " - " + turno + " - " + año%> </h1>
	</div>	
	
	<table class="table table-hover">
	  <tr>	  	    
	    <td> NOMBRE </td>
	    <td> TIPO DE COBRO</td>
	    <td> INSCRIPCION - <%= año%> </td>	    
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
	    <td> INSCRIPCION - <%= año+1%> </td>	    	    
	  </tr>
	  <% int cod_plan = 0;
	  
	  	for (Alumno a : alumnos.getLista()) { %>
	  <tr>	    
	  <% String tipoCobro = AccionesAlumno.getTipoCobro(a.getDni(), año); %>
	  
	    <td> <%=a.getNombre() + " " + a.getApellido() %></td>
	    	    
	    <td> <%= tipoCobro %> </td>
	    
	    	    
	    <%if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), año-1, 13)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año-1%>&&dni=<%=a.getDni()%>&&mes=13"> <%= "$"+ AccionesCuota.getPagosDoublelMes(a.getDni(), año-1, 13)%></a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    <%}%>    

	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), año, 3)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=3"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), año, 3) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO</td>
	    <%}%>
	    
	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), año, 4)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=4"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), año, 4) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO</td>
	    <%}%>

	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), año, 5)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=5"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), año, 5) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO</td>
	    <%}%>

	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), año, 6)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=6"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), año, 6) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO</td>
	    <%}%>
	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), año, 7)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=7"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), año, 7) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO</td>
	    <%}%>
	    	    
	    	    
	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), año, 8)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=8"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), año, 8) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO</td>
	    <%}%>
	    	    
	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), año, 9)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=9"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), año, 9) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO</td>
	    <%}%>
	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), año, 10)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=10"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), año, 10) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO</td>
	    <%}%>

   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), año, 11)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=11"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), año, 11) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO</td>
	    <%}%>
	    
   	    <%if(!tipoCobro.equals("SUBSIDIO")){
	    	
	    	if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), año, 12)) == 0){ %>
	    		    		    	
	    		<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=12"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), año, 12) %> </a></td>
	    		 
	    	<%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>
	    	
	    	<%}%>
	    	    	
	    <%}else{%>
	    	<td> SUBSIDIO</td>
	    <%}%>
	   
		<%if ((cod_plan = AccionesPlanPago.checkPlanPagosMes(a.getDni(), año, 13)) == 0){ %>
	    		    		    	
	    	<td> <a href="CuotaList?accion=visualizarPagos&&año=<%=año%>&&dni=<%=a.getDni()%>&&mes=13"> <%= "$"+AccionesCuota.getPagosDoublelMes(a.getDni(), año, 13)%></a></td>
	    		 
	    <%}else{%>
	    	
	    		<td> <a href="PlanPagoList?accion=visualizarPlan&&codplan=<%=cod_plan%>"> <%= "PLAN DE PAGOS= $" + AccionesPlanPago.getTotalPlanPago(cod_plan) %></a></td>	    	
	    <%}%>	  	
	  	
	  <%}%>
	  </tr>
	  </table>	
	<br>
	<br>
	<a href="planPago_edit.jsp"> Armar plan de pagos</a>
	<br>
	<br>
		<a href="PrecioList?año=<%=año%>">Ver Precios <%=año%></a>
	<br>
	<br>	
	<div class="form-group"> 
	  <form action="menu_cuotas.jsp">		   
	   	<button type="submit" class="btn btn-primary"  value="Volver al Menú de Cuotas">Volver al Menú de Cuotas</button> 
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