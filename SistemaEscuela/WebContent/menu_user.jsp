<%@ page import="datos.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Menú Usuario</title>
<link rel="stylesheet" href="style/bootstrap.min.css">
</head>
<body>
<%
	if (session.getAttribute("usuario") != null) {
		
		Maestro maestro = (Maestro)session.getAttribute("maestro");
		String titulo = "Bienvenido/a " + maestro.getNombre();
%>
<div class="container">  
  <div class="page-header">
  <center> 
<h1><%= titulo %></h1>
  </center>
  </div>

    <ul class="nav nav-pills">
    
		<li class="active"><a href="#">Inicio</a></li>		
        <li class="dropdown">      
            <a href="#" data-toggle="dropdown" class="dropdown-toggle">Sanciones   <b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li><a href="sanciones_select.jsp?action=listar">Listado</a></li>               
                <li><a href="SancionEdit?do=alta">Nueva sancion</a></li>      
            </ul>
        </li>
        
         <li class="dropdown">      
            <a href="#" data-toggle="dropdown" class="dropdown-toggle">Asistencias   <b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li><a href="AsistenciaList">Listado</a></li>               
                <li><a href="AsistenciaListEdit">Nueva asistencia</a></li>      
            </ul>
        </li>
        
         <li> <a href="nota_menu.jsp">Notas</a></li>
  			
  		<li class="dropdown">      
            <a href="#" data-toggle="dropdown" class="dropdown-toggle">Entrevistas   <b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li><a href="EntrevistaList">Listado</a></li>                     
            </ul>
        </li>
        
        <li class="dropdown">      
            <a href="#" data-toggle="dropdown" class="dropdown-toggle">Citaciones   <b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li><a href="citaciones_select.jsp?action=listar">Listado</a></li>
                <li><a href="CitacionEdit?do=alta">Nueva citacion</a></li>                      
            </ul>
        </li>
        
        <li> <a href="admin_user.jsp">Administración de cuenta   </a></li>
        
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