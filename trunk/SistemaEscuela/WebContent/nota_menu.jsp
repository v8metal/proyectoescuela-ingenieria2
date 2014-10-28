<%@page import="conexion.AccionesMaestro"%>
<%@ page import="datos.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Notas</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</head>
<body>
<%
	if (session.getAttribute("usuario") != null) {
		
		// recupero el año_sys de la sesion y lo utilizo como año lectivo
		int año = Integer.parseInt((String)session.getAttribute("año_sys"));
		
		Maestro maestro = (Maestro)session.getAttribute("maestro");
		String nombre = maestro.getNombre();
		String apellido = maestro.getApellido();
		String titulo = "Grados de " + nombre + " como titular";
		
		Grados grados = AccionesMaestro.getGradosTitular(maestro.getDni());
%>
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
              <li><a href="menu_user.jsp">Menú</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Asistencias <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="AsistenciaList">Listado</a></li>
                  <li><a href="AsistenciaListEdit">Nueva asistencia</a></li>          
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Citaciones <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="citaciones_select.jsp?action=listar">Listado</a></li>                 
                  <li><a href="CitacionEdit?do=alta">Nueva citación</a></li>          
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Sanciones <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="sanciones_select.jsp?action=listar">Listado</a></li>
                  <li><a href="SancionEdit?do=alta">Nueva sanción</a></li>          
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Entrevistas <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="EntrevistaList">Listado</a></li>
                </ul>
              </li>
              <li class="active"><a href="nota_menu.jsp">Notas</a></li>
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
        		  <p class="navbar-text navbar-right"><strong><%= nombre + " " + apellido %></strong></p>
        		</div>
			</li>
          </ul>
        </div>
      </div>
    </div>
  
  <br>
  <br>
  
<div class="page-header">
<h1><%= titulo %></h1>
</div>
	
<%
			if (grados.getLista().isEmpty()) {
%>
<br>
<div class="alert alert-info" role="alert">
    <strong>Atención!</strong> No hay grados cargados
</div>
<br>
<%
			} else {
%>
<table class="table table-hover table-bordered">
	<tr>
		<th>Grado</th>
		<th>Turno</th>
		<th>Salón</th>
		<th>&nbsp;</th>
	</tr>
<% 	int i = 0;
	for (Grado g : grados.getLista()) {
		i++;
%>
	<tr>
		<td><%= g.getGrado() %></td>
		<td><%= g.getTurno() %></td>		
		<td><%= g.getSalon() %></td>	
		<td><a href="alumnoList?from=nota_menu&grado=<%= g.getGrado()%>&turno=<%= g.getTurno()%>&año=<%=año%>">Ver alumnos</a></td>
	</tr>
<%
	}
 %>
</table>
<br>
<%
			}
%>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</div>
</body>
</html>