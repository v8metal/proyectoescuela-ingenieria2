<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.PlanPago"%>
<%@page import="datos.PagoPlanPago"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesPlanPago"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Pagos</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<!--<link rel="stylesheet" href="style/jquery-ui.css">  con ese no se ven las flechitas-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="js/jquery-1.10.2.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/entrevista.js"></script> <!-- DatePic para entrevistas -->


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
  
<!--  <center>  -->
 <% 
 	int tipo = (Integer) session.getAttribute("tipoUsuario");						
 	if (AccionesUsuario.validarAcceso(tipo, "pagoPlanPago_edit.jsp") != 1){							
 		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
 	}
 
 	 PlanPago plan = (PlanPago) session.getAttribute("planPagos");	
 	 PagoPlanPago ppp = (PagoPlanPago) request.getAttribute("pagopp");
 	
 		if (ppp != null){
 %>  		
 <div class="page-header">  
	<h1>Modificar Pago</h1>
</div> 
 <%}else{%>
 <div class="page-header">  
	<h1>Alta de Pago</h1>
</div> 
 <%}%>
<%
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
		if(plan.getPeriodoini() == 13) mesini="Inscripción";
		
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
		if(plan.getPeriodofin() == 13) mesfin="Inscripción";
	%>
<div class="page-header">  
	<h2><%= "Plan de pagos - "+ a.getNombre() + " " + a.getApellido()  + " - De " + mesini + " " + plan.getAñoini() + " a "  + mesfin + " " + plan.getAñofin()%></h2>
</div>
<%
	/*
	int dia_pp = 0;
	String mes_pp = "";
	int año_pp = 0;
	*/
	
	/*
	if (ppp != null) {
		//recupero la fecha
		String fecha_pago = ppp.getFecha() ;
		//separo la fecha (1990-01-01) por el "-"" y almaceno el año, mes y dia en un array
		String[] fecha_ent = fecha_pago.split ("-");
		//obtengo el dia, mes y año respectivamente
		dia_pp = Integer.parseInt(fecha_ent[fecha_ent.length - 1]);
		mes_pp = fecha_ent[fecha_ent.length - 2];
		año_pp= Integer.parseInt(fecha_ent[fecha_ent.length - 3]);
		
	}else{	
	//Alta de pago	
	   	dia_pp = Integer.valueOf((String)session.getAttribute("dia_sys"));
		
	   	mes_pp = (String) session.getAttribute("mes_sys");
	   	
	   	//System.out.println("mes_ppp= " + mes_ppp);
	   	//System.out.println("mes_pp.substring(0,1)= " + mes_pp.substring(0,1));	   	
	   	
	   	if (!mes_pp.substring(0,1).equals("1")){		
	   		mes_pp = "0" + mes_pp;	   	
	   	}
	   	
	   	año_pp = Integer.valueOf((String)session.getAttribute("año_sys"));
	 //Alta de pago
	 */
	//}	
	
	//System.out.println("mes= " + mes_ppp);
   	%>
   	<div class="form-group">
	<form action="PlanPagoList" method="get">
	<input name="fecha" id="fecha" type="hidden" value="<%=ppp!=null?ppp.getFecha():"0"%>">
	<%if (ppp != null) { %>
	<input name=accion type=hidden value ="modificarPagopp2">
	<%}else{%>
	<input name=accion type=hidden value ="altaPagopp">
	<%}%>	
	<table class="table table-hover table-bordered">
		<tr>
			<th><label for="input">Fecha:</label></th>			
			<td>
			<div class="col-xs-5">
			<input class="form-control" type="text" id="datepicker" required autofocus name="fecha_ppp">
			</div>
			</td>			
	    </tr>
		<tr>
			<td>PAGO</td>
			<td>
				<div class="col-xs-5">
				<input type="text" class="form-control" placeholder="Importe" name="pagopp" value="<%=ppp!=null?ppp.getPago(): ""%>">
				</div>
			</td>
		</tr>
		
		<tr>
			<td>OBSERVACIONES</td>
			<td>
				<div class="col-xs-5">
				<textarea class="form-control" placeholder="Observaciones" name="obspp" cols="40" rows="1"><%=ppp!=null?ppp.getObservaciones(): ""%></textarea>
				</div>
			</td>			
		</tr>
		
	</table> 
	<br>
	<br>
	<%if (ppp != null) { %>	
	<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="return confirm('Esta seguro que desea modificar?');">Realizar modificación</button>
	<input type="hidden" name="cod_pago" value="<%= ppp.getCod_pago()%>">	
	<%}else{%>
	<button type="submit" class="btn btn-primary"  value="Realizar Alta" name="btnSave" onclick="return confirm('Esta seguro que desea modificar?');">Realizar Alta</button>
	<%}%>	
	</form>
	</div>
<br>
<br>
<!--  </center>  -->
<div class="form-group">
<form action="PlanPagoList" method="get">
<input name="accion" type="hidden" value="listarPagosPlan">
<input name="codplan" type="hidden" value="<%=plan.getCod_plan()%>">
<button type="submit" class="btn btn-primary"  value="Volver atrás">Volver atrás</button>
</form>
</div>
</div>
</body>
</html>