<%@page import="datos.Alumno"%>
<%@page import="datos.Tardanza"%>
<%@page import="datos.Tardanzas"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesTardanza"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de Tardanzas</title>

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
              <li class="active"><a href="menu_tardanzas.jsp">Tardanzas</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Entrevistas <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="EntrevistaList">Listado</a></li>
                  <li><a href="EntrevistaEdit?do=alta">Nueva entrevista</a></li>          
                </ul>
              </li>
              <li><a href="menu_cuotas.jsp">Cuotas</a></li>
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

if(session.getAttribute("admin")!=null){
		
	Tardanzas tardanzas = (Tardanzas)session.getAttribute("tardanzas");

	if (tardanzas.getTardanzas().isEmpty()){
%>
<div class="page-header">
<h1>No hay tardanzas cargadas</h1>
</div>
<%}else{%> 
<div class="page-header">
<h1>Listado de Tardanzas</h1>
</div>
<table class="table table-hover table-bordered">
	<tr>
		<th>Alumno</th>
		<th>Fecha</th>
		<th>Observaciones</th>			
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
<%	
	Alumno a = new Alumno();

	for (Tardanza t : tardanzas.getTardanzas()) {		
		a = AccionesAlumno.getOne(t.getDni());		
%>
	<tr>
		<td><%= a.getNombre() + " " + a.getApellido() %></td>		
		<td><%= t.getFecha() %></td>
		<td><%= t.getObservaciones() %></td>				
		<td><a href="TardanzaEdit?do=modificar&&dni=<%=t.getDni()%>&&fecha=<%=t.getFecha()%>">Modificar</a></td>		
		<td><a href="TardanzaEdit?do=borrar&&dni=<%=t.getDni()%>&&fecha=<%=t.getFecha()%>>" onclick="return confirm('Esta seguro que desea borrar la tardanza?');">Borrar</a></td>				
	</tr>
<%
	}
 %>
</table>
<%
	}
 %>
	<br>
	<a href="TardanzaEdit?do=alta">Agregar Tardanza</a>
	<br>
	<br>
	<br>
	<div class="form-group"> 
	  	<form action="menu_tardanzas.jsp">
	  	<input type="hidden" name="volver" value="volver">		   
	   	<button type="submit" class="btn btn-primary"  value="Volver al Menú de Tardanzas">Volver al Menú de Tardanzas</button> 
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