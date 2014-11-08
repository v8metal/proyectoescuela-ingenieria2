<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Alumno"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de pagos por dia</title>

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
  
 <% 
 int tipo = (Integer) session.getAttribute("tipoUsuario");						
 if (AccionesUsuario.validarAcceso(tipo, "pago_edit.jsp") != 1){							
 	response.sendRedirect("Login"); //redirecciona al login, sin acceso						
 }
	 
 	Cuota cuota = (Cuota) session.getAttribute("pagoEdit");
    int dni = (Integer) session.getAttribute("dni");
 	int año = (Integer) session.getAttribute("año");
 	int mes = (Integer) session.getAttribute("mes");
 	
 	if (cuota != null){
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
	Alumno a = null;
		
	if (cuota != null){
	
		a = AccionesAlumno.getOne(cuota.getDni());
	%>	
<h2><%=a.getNombre() + " " + a.getApellido() + " - Año " + cuota.getAño() + " - Mes = " + cuota.getPeriodo() %></h2>
   <%}else{ 
   		
   		a = AccionesAlumno.getOne(dni);
   	%>
   	
<h2><%=a.getNombre() + " " + a.getApellido() + " - Año " + año + " - Mes= " + mes %></h2>

   <%}%>
   	<div class="form-group">   	
	<form action="CuotaEdit" method="<%=cuota!= null?"post":"get"%>">
	<input name="fecha" id="fecha" type="hidden" value="<%=cuota!=null?cuota.getFecha():"0"%>">
	<%if (cuota != null) { %>
	<input name=accion type=hidden value ="modificarPago">
	<%}else{%>
	<input name=accion type=hidden value ="altaPago">
	<%}%>	
	<table class="table table-hover table-bordered">
		<tr>
			<th><label for="input">Fecha:</label></th>			
			<td>
			<div class="col-xs-5">
			<input class="form-control" type="text" id="datepicker" required autofocus name="fecha_pago">
			</div>
			</td>			
	    </tr>
		<tr>
			<td>PAGO</td>
			<td>
				<div class="col-xs-5">
				<input type="text" class="form-control" placeholder="importe" name="pago" value="<%=cuota!=null?cuota.getPago(): ""%>">
				</div>				
			</td>
		</tr>
		
		<tr>
			<td>OBSERVACIONES</td>
			<td>
				<div class="col-xs-5">
				<textarea class="form-control" placeholder="Observaciones" name="obs" cols="40" rows="1"><%=cuota!=null?cuota.getObservaciones(): ""%></textarea>
				</div>
			</td>			
		</tr>
		
	</table> 
	<br>
	<br>
	<%if (cuota != null) { %>	
	<button type="submit" class="btn btn-primary"  value="Realizar modificación">Realizar modificación</button>	
	<%}else{%>	
	<button type="submit" class="btn btn-primary"  value="Realizar alta">Realizar alta</button>
	<%}%>	
	</form>
</div>
<br>
<br>
<div class="form-group">
	<form action="CuotaList" method="get">
	<input name="accion" type="hidden" value="visualizarPagos">
	<button type="submit" class="btn btn-primary"  value="Volver atrás">Volver atrás</button>
</form>
</div>
</div>
</body>
</html>