<%@page import="datos.Alumno"%>
<%@page import="datos.Maestro"%>
<%@page import="datos.Citacion"%>
<%@page import="datos.Citaciones"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "citaciones");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de Citaciones</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">

</head>
<body>

<%
		//modulo de seguridad
		int tipo = (Integer) session.getAttribute("tipoUsuario");						
		if (AccionesUsuario.validarAcceso(tipo, "citaciones_list.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}

		//Recupero el maestro para mostrar su nombre y apellido en el menú superior	
		Maestro maestro = (Maestro)session.getAttribute("maestro");
		String nombre = maestro.getNombre();
		String apellido = maestro.getApellido();
%>

<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>
  
<%
		session.removeAttribute("citacion_edit");
		session.removeAttribute("alumnos_citacion");
		
		Citaciones citaciones  = (Citaciones)session.getAttribute("citaciones_list");	
		
		String volver = "citaciones_select.jsp?action=listar";		
		String method = "post";
		
		Boolean b = (session.getAttribute("exit_alta") != null);
		
		String exit = null;
		
		if (b){						
			volver = "CitacionEdit";			
			method = "get";
			exit= "salir";						
		}
%>

<%
if (citaciones.getLista().isEmpty()){	
%>
<div class="page-header"> 
<h1>Citaciones</h1>
</div>
<br>
<!-- MENSAJE ATENCION -->
	<div class="alert alert-info" role="alert">
		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	<strong>Atención!</strong> No hay citaciones para el año seleccionado. <a href="citaciones_select.jsp" class="alert-link">Volver a selección de año</a>
    </div>
<%	
}else{
%>
<div class="page-header"> 
<h1>Listado de Citaciones</h1>
</div>
<table class="table table-hover table-bordered">
	<thead>
	<tr class="active">
		<th>Apellido y Nombres</th>
		<th>Grado</th>
		<th>Turno</th>				
		<th>Fecha</th>
		<th>Hora</th>
		<th>Descripción</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
	</thead>
<%	
	Alumno m = new Alumno();

	for (Citacion c : citaciones.getLista()) {
		
		m = AccionesAlumno.getOne(c.getDni());
		
		String fecha_entrevista = c.getFecha();		
		String[] fecha_ent = fecha_entrevista.split ("-");
		String dia = fecha_ent[fecha_ent.length - 1];
		String mes = fecha_ent[fecha_ent.length - 2];
		String año = fecha_ent[fecha_ent.length - 3];
%>
	<tbody>
	<tr>
		<td><%= m.getApellido() + ", " + m.getNombre() %></td>
		<td><%= c.getGrado() %></td>
		<td><%= c.getTurno() %></td>		
		<td><%= dia +"/" + mes + "/" + año %></td>
		<td><%= c.getHora().substring(0,5) %></td>
		<td><%= c.getDescripcion() %></td>						
		<td><strong><a href="CitacionEdit?do=modificar&dni_citacion=<%=c.getDni()%>&fecha_citacion=<%=c.getFecha()%>&hora_citacion=<%=c.getHora()%>&exit=<%=exit%>"><i class="glyphicon glyphicon-pencil"></i> Editar</a></strong></td>
		<td><strong><a href="CitacionEdit?do=baja&dni_citacion=<%=c.getDni()%>&fecha_citacion=<%=c.getFecha()%>&hora_citacion=<%=c.getHora()%>&exit=<%=exit%>" onclick="return confirm('Esta seguro que desea borrar?');"><i class="glyphicon glyphicon-trash"></i> Borrar</a></strong></td>
	</tr>
	</tbody>
<%
	}
 %>
</table>
<br>
	<strong><a href="CitacionEdit?do=alta"><i class="glyphicon glyphicon-edit"></i> Nueva Citación</a></strong>
<br>
<br>
<br>
<form action="<%=volver%>" method="<%=method%>">
<div class="form-group">
<%if (b){%> 
<input type="hidden" name="accion" value="alta">
<%}%>
<button type="submit" class="btn btn-primary"  value="Volver"><i class="glyphicon glyphicon-share-alt"></i> Volver a selección de año</button>
</div>
</form>

<%} %>

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