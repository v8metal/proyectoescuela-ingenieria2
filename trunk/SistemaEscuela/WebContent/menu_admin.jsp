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
	if (session.getAttribute("login") != null) {
%>
<div class="container">  
  <div class="page-header">
  <center>  
	<h1>Bienvenido Administrador</h1>
  </center>
  </div>

    <ul class="nav nav-pills">

		<li class="active"><a href="#">Inicio</a></li>
		
        <li class="dropdown">
         
            <a href="#" data-toggle="dropdown" class="dropdown-toggle">Alumnos <b class="caret"></b></a>

            <ul class="dropdown-menu">

                <li><a href="alumno_edit.jsp">Ingresar nuevo alumno</a></li>

                <li><a href="menu_listado_alum.jsp">Listado de alumnos</a></li>

				<li class="divider"></li>
				
                <li><a href="alumnoInactivo?do=listar">Alumnos dados de baja</a></li>       

            </ul>

        </li>

        <li> <a href="GradoList">Grados</a></li>            
        <li> <a href="maestroList">Maestros</a></li>
        <li> <a href="materiaList?from=menu_admin">Materias</a></li>
        
        <li class="dropdown">
         
            <a href="#" data-toggle="dropdown" class="dropdown-toggle">Tardanzas <b class="caret"></b></a>

            <ul class="dropdown-menu">

                <li> <a href="tardanza_edit.jsp">Alta</a></li>

                <li> <a href="tardanza_list.jsp">Listado</a></li>				      

            </ul>

        </li>
        
        <li> <a href="EntrevistaList">Entrevistas</a></li>                
        <li> <a href="menu_cuotas.jsp">Cobro de Cuotas</a></li>        
        <li> <a href="UsuarioList">Gestionar Usuarios</a></li>       


    </ul>

<br>
<br>
<center>
</center>
<br>
<br>
<center>
<form action="cerrarSesion" method="post">
<div class="form-group">
<button type="submit" class="btn btn-primary" value="Cerrar sesion">Cerrar sesion</button>
</div>
</form>
</center>
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