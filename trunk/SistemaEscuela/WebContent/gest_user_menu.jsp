<%@page import="conexion.AccionesMaestro"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="datos.Usuario"%>
<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@page import="datos.Usuarios"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Gestión de usuarios</title>

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
              <li><a href="menu_cuotas.jsp">Cuotas</a></li>
              <li class="active"><a href="UsuarioList">Usuarios</a></li>
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
	if (session.getAttribute("admin") != null) {
		String titulo = (String)session.getAttribute("titulo");
		Usuarios usuarios = (Usuarios) session.getAttribute("usuarios");
		Maestros maestros = (Maestros) session.getAttribute("activos");
%>
<div class="page-header">  
	<h1>Listado de usuarios registrados</h1>
</div>
<%  
		if (usuarios.getLista().isEmpty()) {
%>
<br>
<!-- MENSAJE DE WARNING -->
	<div class="alert alert-warning" role="alert">
      <strong>Cuidado!</strong> No hay usuarios registrados. <a href="registro_user.jsp?" class="alert-link">Registrar nuevo usuario</a>
    </div>
<%
		} else {
%>
<table class="table table-hover table-bordered">
	<thead>
	<tr class="active">		
		<th>Maestro</th>
		<th>Usuario</th>
		<th>Contraseña</th>
		<th>&nbsp;</th>
	</tr>
	<thead>
<% 	
	int i = 0;
	for (Usuario u : usuarios.getLista()) {
	Maestro m = AccionesMaestro.getOne(u.getCod_maest());
	i++;
%>
	<tbody>
	<tr>		
		<td><%= m.getApellido() + ", " + m.getNombre() %></td>
		<td><%= u.getUsuario() %></td>
		<td><%= u.getContraseña() %></td>
		<td><a name="delete-link" href="registroUser?do=baja&usuario=<%= u.getUsuario() %>" onclick="return confirm('Esta seguro que desea borrar?');">Borrar</a></td>
	</tr>
	</tbody>
<%
	}
 %>
</table>
<%
		}
%>
<br>
<%if ( (!usuarios.getLista().isEmpty()) && (usuarios.getLista().size() < maestros.getLista().size()) ) { //aca agregar a futuro los maestros activos%> 
  <!-- MENSAJE DE WARNING -->
	<div class="alert alert-warning" role="alert">
      <strong>Cuidado!</strong> No todos los maestros están registrados. <a href="registro_user.jsp?" class="alert-link">Registrar nuevo usuario</a>
    </div>
<%}else if ((usuarios.getLista().size() == maestros.getLista().size()))

		{%>
 		 <!-- MENSAJE DE EXITO -->
  		 <div class="bs-example">
    			 <div class="alert alert-success fade in" role="alert">
     			 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     			 <strong>Bien Hecho!</strong> Todos los maestros están registrados
  	  		</div>
  		</div><!-- /example -->
		<%}%>
<%

	} else {
		response.sendRedirect("login.jsp");
	}
%>
</div>
</body>
</html>