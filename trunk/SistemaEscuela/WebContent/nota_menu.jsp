<%@page import="conexion.AccionesMaestro"%>
<%@ page import="datos.*"%>
<%@page import="conexion.AccionesUsuario"%> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "notas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Notas</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">

</head>
<body>
<%	
		//modulo seguridad
		int tipo = (Integer) session.getAttribute("tipoUsuario");						
		if (AccionesUsuario.validarAcceso(tipo, "nota_menu.jsp") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}		

		// recupero el año_sys de la sesion y lo utilizo como año lectivo
		int año = Integer.parseInt((String)session.getAttribute("año_sys"));
		
		Maestro maestro = (Maestro)session.getAttribute("maestro");
		String nombre = maestro.getNombre();
		String apellido = maestro.getApellido();
		String titulo = "Grados de " + nombre + " como titular";
		
		Grados grados = AccionesMaestro.getGradosTitular(maestro.getDni());
%>
 <div class="container">
 
   <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>
  
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
	<thead>
	<tr class="active">
		<th>Grado</th>
		<th>Turno</th>
		<th>Salón</th>
		<th>&nbsp;</th>
	</tr>
	</thead>
<% 	int i = 0;
	for (Grado g : grados.getLista()) {
		i++;
%>
	<tbody>
	<tr>
		<td><%= g.getGrado() %></td>
		<td><%= g.getTurno() %></td>		
		<td><%= g.getSalon() %></td>	
		<td><strong><a href="alumnoList?from=nota_menu&grado=<%= g.getGrado()%>&turno=<%= g.getTurno()%>&año=<%=año%>"><i class="glyphicon glyphicon-eye-open"></i> Ver alumnos</a></strong></td>
	</tr>
	</tbody>
<%
	}
 %>
</table>
<br>
<%
			}
%>
</div>
	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

	<!-- menú superior -->
	<script src="js/menu_user.js"></script>
</body>
</html>