<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Menú de administrador</title>
<link rel="stylesheet" href="style/bootstrap.min.css">
</head>
<body>
<%
	if (session.getAttribute("admin") != null) {
%>
<div class="container">  
  <div class="page-header">
  <center>  
	<h1>Bienvenido Administrador</h1>
  </center>
  </div>

    <ul class="nav nav-pills">

		  <li class="dropdown">
         
            <a href="#" data-toggle="dropdown" class="dropdown-toggle">Alumnos   <b class="caret"></b></a>

            <ul class="dropdown-menu">

                <li><a href="menu_listado_alum.jsp">Listado</a></li>               
                <li><a href="alumno_edit.jsp">Nuevo alumno</a></li>
				<li class="divider"></li>
				
                <li><a href="alumnoInactivo?do=listar">Registro de bajas</a></li>       

            </ul>

        </li>

        <li class="dropdown">
         
            <a href="#" data-toggle="dropdown" class="dropdown-toggle">Grados   <b class="caret"></b></a>

            <ul class="dropdown-menu">

                <li> <a href="GradoList?listar=mañana">Turno Mañana</a></li>
                <li> <a href="GradoList?listar=tarde">Turno Tarde</a></li>     

            </ul>

        </li>                    
        
        <li class="dropdown">
         
            <a href="#" data-toggle="dropdown" class="dropdown-toggle">Maestros   <b class="caret"></b></a>

            <ul class="dropdown-menu">

                <li><a href="maestroList">Listado</a></li>               
                <li><a href="maestroEdit?accion=alta">Nuevo maestro</a></li>
                
                <li class="divider"></li>
				
                <li><a href="MaestroList?tipo=inactivos">Registro de bajas</a></li> 		

            </ul>

        </li>           
        
        <li class="dropdown">
         
            <a href="#" data-toggle="dropdown" class="dropdown-toggle">Materias   <b class="caret"></b></a>

            <ul class="dropdown-menu">

                <li><a href="materiaList?from=menu_admin">Listado</a></li>               
                <li><a href="materiaEdit?do=alta">Nueva materia</a></li>
                
                <li class="divider"></li>
				
                <li><a href="materiaList?from=materia_inactiva_list">Materias inactivas</a></li> 		

            </ul>

        </li>
        
        <li> <a href="menu_tardanzas.jsp">Tardanzas   </a></li>                 
        
         <li class="dropdown">
         
            <a href="#" data-toggle="dropdown" class="dropdown-toggle">Entrevistas   <b class="caret"></b></a>

            <ul class="dropdown-menu">

                <li> <a href="EntrevistaList">Listado</a></li>
                <li> <a href="EntrevistaEdit?do=alta">Nueva entrevista</a></li>     

            </ul>

        </li>
                  
        <li> <a href="menu_cuotas.jsp">Cobro de Cuotas</a></li>           
        <li> <a href="UsuarioList">Gestión de Usuarios</a></li> 
        
        <li class="dropdown">      
            <a href="#" data-toggle="dropdown" class="dropdown-toggle">Administración de cuenta<b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li> <a href="admin_user.jsp">Cambiar Usuario </a></li>
                <li> <a href="admin_pass.jsp">Cambiar Contraseña </a></li>                  
            </ul>
        </li>

    </ul>

<br>
<br>
<br>
<br>
<form action="cerrarSesion" method="post">
<div class="form-group">
<button type="submit" class="btn btn-primary" value="Cerrar sesion">Cerrar sesion</button>
</div>
</form>
<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%> 
</div>
</body>
</html>