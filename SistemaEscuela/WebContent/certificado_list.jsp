<%@page import="conexion.AccionesCertificado"%>
<%@page import="datos.*"%>
<%@page import="java.util.*"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "alumno_list.jsp") != 1){							
		response.sendRedirect("Login");						
	}
	
	String titulo = (String) session.getAttribute("titulo_alumno");
%>
<title><%="Certificados - " + titulo%></title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">

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
              <li class="active" class="dropdown">
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

<div class="page-header">
<h1>Certificados</h1>
</div>
<h3><%=titulo%></h3>

<br>
<table class="table table-hover table-bordered">
	<thead>
	<tr>
		<th>Nº</th>
		<th>Apellido y Nombres</th>
		<th>Salud</th>
		<th>Bucal</th>
		<th>Auditivo</th>
		<th>Visual</th>
		<th>Vacunas</th>
		<th>D.N.I.</th>
		<th>Observaciones</th>
	</tr>
	<thead>	
<% 
	int i = 0;
	int año = (Integer) session.getAttribute("año");
	Alumnos alumnos = (Alumnos)session.getAttribute("alumnos_alumno");
	
	for (Alumno a : alumnos.getLista()) {	
		Certificado c = AccionesCertificado.getOneByDniYAño(a.getDni(), año);
		i++;
%>
	<tbody>
	<tr><td><%=i%></td>
		<td><%= a.getApellido() + ", " + a.getNombre() %></td>
		<td><input type="checkbox" name="ind_salud" disabled 
			<%= c.isInd_salud() ? "checked" : "" %> /></td>
		<td><input type="checkbox" name="ind_bucal" disabled 
			<%= c.isInd_bucal() ? "checked" : "" %> /></td>
		<td><input type="checkbox" name="ind_auditivo" disabled 
			<%= c.isInd_auditivo() ? "checked" : "" %> /></td>
		<td><input type="checkbox" name="ind_visual" disabled 
			<%= c.isInd_visual() ? "checked" : "" %> /></td>	
		<td><input type="checkbox" name="ind_vacunas" disabled 
			<%= c.isInd_vacunas() ? "checked" : "" %> /></td>	
		<td><input type="checkbox" name="ind_dni" disabled 
			<%= c.isInd_dni() ? "checked" : "" %> /></td>
		<td><a href="certificadoEdit?from=certificado_list&do=modificar&dni=<%= a.getDni() %>">Ver</a></td>				
	</tr>
	<tbody>
<%	
	}
 %>
</table>
<br>
<form action="alumno_list.jsp" method="post">
<button type="submit" class="btn btn-primary"  value="Volver">Volver</button>
</form>
</div>
</body>
</html>