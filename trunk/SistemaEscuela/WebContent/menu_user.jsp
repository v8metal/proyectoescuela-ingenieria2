<%@ page import="datos.*"%>
<%@page import="conexion.AccionesUsuario"%> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Menú Usuario</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet"> 

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</head>
<body>
<%
	//modulo seguridad
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "menu_user.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
		
	Maestro maestro = (Maestro)session.getAttribute("maestro");
	String nombre = maestro.getNombre();
	String apellido = maestro.getApellido();
	String titulo = "Bienvenido/a " + maestro.getNombre() + " " + maestro.getApellido();
%>
<div class="container">  

<div class="page-header">
<h1>Maestro</h1>
</div>
  
  <!-- Static navbar -->
      <div class="navbar navbar-default" role="navigation">
        <div class="container-fluid">
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
              <li class="active"><a href="menu_admin.jsp"><i class="glyphicon glyphicon-home"></i> Home</a></li>              
              <li><a href="menu_asistencias.jsp">Asistencias</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Citaciones <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="citaciones_select.jsp?action=listar"><i class="glyphicon glyphicon-list"></i> Listado</a></li>                 
                  <li><a href="CitacionEdit?do=alta"><i class="glyphicon glyphicon-edit"></i> Nueva citación</a></li>        
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Sanciones <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="sanciones_select.jsp?action=listar"><i class="glyphicon glyphicon-list"></i> Listado</a></li>
                  <li><a href="SancionEdit?do=alta"><i class="glyphicon glyphicon-edit"></i> Nueva sanción</a></li>          
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Entrevistas <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="EntrevistaList"><i class="glyphicon glyphicon-list"></i> Listado</a></li>
                </ul>
              </li>
              <li><a href="nota_menu.jsp">Notas</a></li>
  <!--             
               <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Cuenta <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="admin_user.jsp">Cambiar usuario</a></li>
                  <li><a href="admin_pass.jsp">Cambiar contraseña</a></li>          
                </ul>
              </li>
   -->             
            </ul> 
 <!-- 
            <ul class="nav navbar-nav navbar-right">
              <li class="active"><a href="CerrarSesion">Salir</a></li>
            </ul>
            <ul>
          		<p class="navbar-text navbar-right"><strong><%= nombre + " " + apellido%></strong></p><br>
            </ul> 
  -->
  		
  			<ul class="nav navbar-nav navbar-right">
  				<li class="dropdown">
         			<a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#"><i class="glyphicon glyphicon-user"></i> <strong> <%= nombre + " " + apellido%> </strong> <span class="caret"></span></a>
          		 	<ul id="g-account-menu" class="dropdown-menu" role="menu">
  <!--
            			<li><a href="admin_user.jsp"><i class="glyphicon glyphicon-wrench"></i> Cambiar Usuario</a></li>
            			<li><a href="admin_pass.jsp"><i class="glyphicon glyphicon-cog"></i> Cambiar Contraseña</a></li>
 --> 
 						<li><a href="configuracion_cuenta.jsp"><i class="glyphicon glyphicon-cog"></i> Configuración</a></li>
            			<li><a href="cerrarSesion"><i class="glyphicon glyphicon-log-out"></i> Cerrar Sesión</a></li>
          			</ul>
       		    </li>
  			</ul>

          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </div>
      
        <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">
<!--      
        <h1>Navbar example</h1>
        <p>This example is a quick exercise to illustrate how the default, static navbar and fixed to top navbar work. It includes the responsive CSS and HTML, so it also adapts to your viewport and device.</p>
        <p>
          <a class="btn btn-lg btn-primary" href="#" role="button">View navbar docs &raquo;</a>
        </p>
-->     
      </div>
</div>
</body>
</html>