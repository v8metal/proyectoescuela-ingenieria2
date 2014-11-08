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
              <li><a href="menu_user.jsp">Men�</a></li>
              <li class="active"> <a href="menu_asistencias.jsp">Asistencias</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Citaciones <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="citaciones_select.jsp?action=listar">Listado</a></li>                 
                  <li><a href="CitacionEdit?do=alta">Nueva citaci�n</a></li>          
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Sanciones <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="sanciones_select.jsp?action=listar">Listado</a></li>
                  <li><a href="SancionEdit?do=alta">Nueva sanci�n</a></li>          
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
                  <li><a href="admin_pass.jsp">Cambiar contrase�a</a></li>          
                </ul>
              </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
            <li>
            	<div class="navbar-collapse collapse">
        		  <form action="cerrarSesion" method="post" class="navbar-form navbar-right" role="form">
           		 	<button type="submit" class="btn btn-primary">Salir</button>
        		  </form>
        		  <p class="navbar-text navbar-right"><strong><%= nombre + " " + apellido %></strong></p>
        		</div>
			</li>
          </ul>
        </div>
      </div>
    </div>
  
  <br>
  <br>
  
<%
	if (tardanzas.getTardanzas().isEmpty()){
%>
<div class="page-header">
<h1>Listado de Asistencias</h1>
</div>
<br>
<div class="alert alert-info fade in" role="alert">
	   <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	   <strong>Atenci�n!</strong> No hay Asistencias cargadas el d�a <%=fechaDisplay%>. <a href="menu_asistencias.jsp" class="alert-link">Seleccionar otro grado/fecha</a>
</div> 
<%}else{%> 
<div class="page-header">
<h1>Listado de Asistencias</h1>
</div>
<h3>Fecha: <%=fechaDisplay%></h3>
<br>
<table class="table table-hover table-bordered">
	<thead>
	<tr class="active">
		<th>Alumno</th>		
		<th>Condici�n</th>	
		<th>Observaciones</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
	</thead>
<%	
	Alumno a = new Alumno();	
	String accion = "";
	
	for (Tardanza t : tardanzas.getTardanzas()) {		
		a = AccionesAlumno.getOne(t.getDni());
		accion = "Modificar";
		
		if (t.getTipo().equals("V")) accion = "Alta";
	%>
	<tbody>
	<tr>
		<td><%= a.getNombre() + " " + a.getApellido() %></td>		
		<td><%= t.getIndicador() %></td>	
		<td><%= t.getObservaciones() %></td>	
		<td><strong><a href="AsistenciaEdit?do=<%=accion%>&&dni=<%=t.getDni()%>&&fecha=<%=fecha%>"><%=accion%></a></strong></td>
		<%if (t.getTipo().equals("A")){%>		
		<td><strong><a href="AsistenciaEdit?do=borrar&&dni=<%=t.getDni()%>&&fecha=<%=fecha%>>" onclick="return confirm('Esta seguro que desea borrar la Asistencia?');">Borrar</a></strong></td>
		<%}else{%>
		<td></td>
		<%}%>
	</tr>
	</tbody>
<%
	}
 %>
</table>

 	<br>
	<br>
	<div class="form-group"> 
	  	<form action="menu_asistencias.jsp">
	  	<input type="hidden" name="volver" value="volver">		   
	   	<button type="submit" class="btn btn-primary"  value="Seleccionar otro grado/fecha">Seleccionar otro grado/fecha</button> 
	   </form>
	</div>
	
<%
	}
 %>

</div>
</body>
</html>