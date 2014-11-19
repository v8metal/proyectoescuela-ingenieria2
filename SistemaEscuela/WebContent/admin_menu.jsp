<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="conexion.AccionesUsuario"%>
<!DOCTYPE html>
<html>
<head>
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet"> 
</head>
<body>
<% String modulo = (String) session.getAttribute("modulo");%>
							 
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
          <a class="navbar-brand" href="#">Admin Test</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
          
            <li><a href="menu_admin.jsp"><i class="glyphicon glyphicon-home"></i> Home</a></li>
            
              <li <%if(modulo.equals("alumnos")){%> class=active <%}%> class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Alumnos <span class="caret"></span></a>                
                <ul class="dropdown-menu" role="menu">
                  <li><a href="menu_alumnos.jsp"><i class="glyphicon glyphicon-list"></i> Listado</a></li>
                  <li><a href="alumno_edit.jsp"><i class="glyphicon glyphicon-edit"></i> Nuevo alumno</a></li>          
                  <li class="divider"></li>                  
                  <li><a href="alumnoInactivo?do=listar"><i class="glyphicon glyphicon-list-alt"></i> Registro de bajas</a></li>
                </ul>
              </li>
              
              <li <%if(modulo.equals("grados")){%> class=active <%}%> class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Grados <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="GradoList?listar=mañana"><i class="glyphicon glyphicon-time"></i> Turno mañana</a></li>                 
                  <li><a href="GradoList?listar=tarde"><i class="glyphicon glyphicon-time"></i> Turno tarde</a></li>          
                </ul>
              </li>
              
              <li <%if(modulo.equals("maestros")){%> class=active <%}%> class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Maestros <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="maestroList"><i class="glyphicon glyphicon-list"></i> Listado</a></li>
                  <li><a href="maestroEdit?accion=alta"><i class="glyphicon glyphicon-edit"></i> Nuevo maestro</a></li>          
                  <li class="divider"></li>
                  <li><a href="MaestroList?tipo=inactivos"><i class="glyphicon glyphicon-list-alt"></i> Registro de bajas</a></li>
                </ul>
              </li>
              
              <li <%if(modulo.equals("materias")){%> class=active <%}%> class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Materias <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="materiaList?from=menu_admin"><i class="glyphicon glyphicon-list"></i> Listado</a></li>
                  <li><a href="materiaEdit?do=alta"><i class="glyphicon glyphicon-edit"></i> Nueva materia</a></li>          
                  <li class="divider"></li>
                  <li><a href="materiaList?from=materia_inactiva_list"><i class="glyphicon glyphicon-ban-circle"></i> Materias inactivas</a></li>
                </ul>
              </li>
              
              <li <%if(modulo.equals("tardanzas")){%> class=active <%}%>><a href="menu_tardanzas.jsp">Tardanzas</a></li>
              
              <li <%if(modulo.equals("entrevistas")){%> class=active <%}%> class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Entrevistas <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="EntrevistaList"><i class="glyphicon glyphicon-list"></i> Listado</a></li>
                  <li><a href="EntrevistaEdit?do=alta"><i class="glyphicon glyphicon-edit"></i> Nueva entrevista</a></li>          
                </ul>
              </li>
              
              <li <%if(modulo.equals("cuotas")){%> class=active <%}%>><a href="menu_cuotas.jsp">Cuotas</a></li>
              
              <li <%if(modulo.equals("usuarios")){%> class=active <%}%>><a href="UsuarioList">Usuarios</a></li>
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
        		</div>
			</li> 			
          </ul>
 -->          		
  			 <ul class="nav navbar-nav navbar-right">
  				<li <%if(modulo.equals("cuenta")){%> class=active <%}%> class="dropdown">
         			<a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#"><i class="glyphicon glyphicon-user"></i> <strong> Admin </strong> <span class="caret"></span></a>
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