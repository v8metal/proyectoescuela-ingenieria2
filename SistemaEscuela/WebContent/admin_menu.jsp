<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="conexion.AccionesUsuario"%>
<!DOCTYPE html>
<html>
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
          <a class="navbar-brand" href="#">Sistema</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
          
            <li><a href="menu_admin.jsp">Menú</a></li>
            
              <li <%if(modulo.equals("alumnos")){%> class=active <%}%> class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Alumnos <span class="caret"></span></a>                
                <ul class="dropdown-menu" role="menu">
                  <li><a href="menu_alumnos.jsp">Listado</a></li>
                  <li><a href="alumno_edit.jsp">Nuevo alumno</a></li>          
                  <li class="divider"></li>                  
                  <li><a href="alumnoInactivo?do=listar">Registro de bajas</a></li>
                </ul>
              </li>
              
              <li <%if(modulo.equals("grados")){%> class=active <%}%> class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Grados <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="GradoList?listar=mañana">Turno mañana</a></li>                 
                  <li><a href="GradoList?listar=tarde">Turno tarde</a></li>          
                </ul>
              </li>
              
              <li <%if(modulo.equals("maestros")){%> class=active <%}%> class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Maestros <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="maestroList">Listado</a></li>
                  <li><a href="maestroEdit?accion=alta">Nuevo maestro</a></li>          
                  <li class="divider"></li>
                  <li><a href="MaestroList?tipo=inactivos">Registro de bajas</a></li>
                </ul>
              </li>
              
              <li <%if(modulo.equals("materias")){%> class=active <%}%> class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Materias <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="materiaList?from=menu_admin">Listado</a></li>
                  <li><a href="materiaEdit?do=alta">Nueva materia</a></li>          
                  <li class="divider"></li>
                  <li><a href="materiaList?from=materia_inactiva_list">Materias inactivas</a></li>
                </ul>
              </li>
              
              <li><a href="menu_tardanzas.jsp">Tardanzas</a></li>
              
              <li <%if(modulo.equals("entrevistas")){%> class=active <%}%> class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Entrevistas <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="EntrevistaList">Listado</a></li>
                  <li><a href="EntrevistaEdit?do=alta">Nueva entrevista</a></li>          
                </ul>
              </li>
              
              <li><a href="menu_cuotas.jsp">Cuotas</a></li>
              
              <li><a href="UsuarioList">Usuarios</a></li>
              
              <li <%if(modulo.equals("cuenta")){%> class=active <%}%> class="dropdown">
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
    
</body>
</html>