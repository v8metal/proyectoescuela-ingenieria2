<%@ page import="datos.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="conexion.AccionesUsuario"%> 
<!DOCTYPE html>
<html>
<head>
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet"> 
</head>
<body>
<% 
	String modulo = (String) session.getAttribute("modulo");

	Maestro maestro = (Maestro)session.getAttribute("maestro");
	String nombre = maestro.getNombre();
	String apellido = maestro.getApellido();
	String titulo = "Bienvenido/a " + maestro.getNombre() + " " + maestro.getApellido();
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
          <a class="navbar-brand" href="#">User Test</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
              <li><a href="menu_user.jsp"><i class="glyphicon glyphicon-home"></i> Home</a></li>
              
              <li <%if(modulo.equals("asistencias")){%> class=active <%}%>> <a href="menu_asistencias.jsp">Asistencias</a></li>
              
              <li <%if(modulo.equals("citaciones")){%> class=active <%}%> class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Citaciones <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="citaciones_select.jsp?action=listar"><i class="glyphicon glyphicon-list"></i> Listado</a></li>                 
                  <li><a href="CitacionEdit?do=alta"><i class="glyphicon glyphicon-edit"></i> Nueva citación</a></li>          
                </ul>
              </li>
              
              <li <%if(modulo.equals("sanciones")){%> class=active <%}%> class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Sanciones <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="sanciones_select.jsp?action=listar"><i class="glyphicon glyphicon-list"></i> Listado</a></li>
                  <li><a href="SancionEdit?do=alta"><i class="glyphicon glyphicon-edit"></i> Nueva sanción</a></li>          
                </ul>
              </li>
              
              <li <%if(modulo.equals("entrevistas")){%> class=active <%}%> class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Entrevistas <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="EntrevistaList"><i class="glyphicon glyphicon-list"></i> Listado</a></li>
                </ul>
              </li>
              
              <li <%if(modulo.equals("notas")){%> class=active <%}%>><a href="menu_notas.jsp">Notas</a></li>
  <!--             
               <li <%if(modulo.equals("cuenta")){%> class=active <%}%> class="dropdown">
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
            <li>
            	<div class="navbar-collapse collapse">
        		  <form action="cerrarSesion" method="post" class="navbar-form navbar-right" role="form">
           		 	<button type="submit" class="btn btn-primary">Salir</button>
        		  </form>
        		   <p class="navbar-text navbar-right"><i class="glyphicon glyphicon-user"></i><strong> <%= nombre + " " + apellido %></strong></p>
        		</div>
			</li>
			</ul>
 --> 
 			<ul class="nav navbar-nav navbar-right">
  				<li <%if(modulo.equals("cuenta")){%> class=active <%}%> class="dropdown">
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
  			
        </div>
      </div>
    </div>
       
    <br>
    <br>

</body>
</html>