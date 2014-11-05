<%@page import="datos.Maestro"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Tardanza"%>
<%@page import="datos.Tardanzas"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesTardanza"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de Asistencias</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</head>
<body>
<div class="container">

<%

	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "asistencia_list.jsp") != 1){							
		response.sendRedirect("Login");
	}
	
	Maestro maestro = (Maestro)session.getAttribute("maestro");
	String nombre = maestro.getNombre();
	String apellido = maestro.getApellido();
	
	Tardanzas tardanzas = (Tardanzas)session.getAttribute("Asistencias");
	Grado grado = (Grado)session.getAttribute("gradoAltaAsistencia");
	String fechaDisplay = (String) session.getAttribute("fechaDisplayAsistencia");
	String fecha = (String) session.getAttribute("fechaAsistencia");
	
%>
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
              <li><a href="menu_user.jsp">Menú</a></li>
              <li class="active"> <a href="menu_asistencias.jsp">Asistencias</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Citaciones <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="citaciones_select.jsp?action=listar">Listado</a></li>                 
                  <li><a href="CitacionEdit?do=alta">Nueva citación</a></li>          
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Sanciones <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="sanciones_select.jsp?action=listar">Listado</a></li>
                  <li><a href="SancionEdit?do=alta">Nueva sanción</a></li>          
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Entrevistas <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="EntrevistaList">Listado</a></li>
                </ul>
              </li>
              <li><a href="nota_menu.jsp">Notas</a></li>
               <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Cuenta <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="admin_user.jsp">Cambiar usuario</a></li>
                  <li><a href="admin_pass.jsp">Cambiar contraseña</a></li>          
                </ul>
              </li>
            </ul>
             <ul class="nav navbar-nav navbar-right">
              <li class="active"><a href="CerrarSesion">Salir</a></li>
            </ul>
            <ul>
          		<p class="navbar-text navbar-right"><strong><%= nombre + " " + apellido %></strong></p>
            </ul> 
        </div>
      </div>
    </div>
  
  <br>
  
<%
	if (tardanzas.getTardanzas().isEmpty()){
%>
<div class="page-header">
<h1>No hay Asistencias cargadas - Fecha <%=fechaDisplay%></h1>
</div>
<%}else{%> 
<div class="page-header">
<h1>Listado de Asistencias - Fecha <%=fechaDisplay%></h1>
</div>
<table class="table table-hover table-bordered">
	<tr>
		<th>Alumno</th>		
		<th>Observaciones</th>
		<th>Condición</th>			
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
<%	
	Alumno a = new Alumno();	
	String accion = "";
	
	for (Tardanza t : tardanzas.getTardanzas()) {		
		a = AccionesAlumno.getOne(t.getDni());
		accion = "Modificar";
		
		if (t.getTipo().equals("V")) accion = "Alta";
	%>

	<tr>
		<td><%= a.getNombre() + " " + a.getApellido() %></td>		
		<td><%= t.getObservaciones() %></td>
		<td><%= t.getIndicador() %></td>		
		<td><a href="AsistenciaEdit?do=<%=accion%>&&dni=<%=t.getDni()%>&&fecha=<%=fecha%>"><%=accion%></a></td>
		<%if (t.getTipo().equals("A")){%>		
		<td><a href="AsistenciaEdit?do=borrar&&dni=<%=t.getDni()%>&&fecha=<%=fecha%>>" onclick="return confirm('Esta seguro que desea borrar la Asistencia?');">Borrar</a></td>
		<%}else{%>
		<td></td>
		<%}%>
	</tr>
<%
	}
 %>
</table>
<%
	}
 %>
 	<br>
	<br>
	<div class="form-group"> 
	  	<form action="menu_asistencias.jsp">
	  	<input type="hidden" name="volver" value="volver">		   
	   	<button type="submit" class="btn btn-primary"  value="Seleccionar otro grado/fecha">Seleccionar otro grado/fecha</button> 
	   </form>
	</div>
</div>
</body>
</html>