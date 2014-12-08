<%@page import="datos.Alumno"%>
<%@page import="datos.Maestro"%>
<%@page import="datos.Sancion"%>
<%@page import="datos.Sanciones"%>
<%@page import="datos.Mensaje"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMaestro"%>
<%@page import="conexion.AccionesMensaje"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "sanciones");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0">
<title>Listado de Sanciones</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">

</head>
<body>

<%
		//modulo de seguridad
		int tipo = (Integer) session.getAttribute("tipoUsuario");						
		if (AccionesUsuario.validarAcceso(tipo, "sanciones_list.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}

		//Recupero el maestro para mostrar su nombre y apellido en el menú superior	
		Maestro maestro = (Maestro)session.getAttribute("maestro");
		String nombre = maestro.getNombre();
		String apellido = maestro.getApellido();
		
		int añoc = (Integer) session.getAttribute("año_sancion");
		int dni = (Integer) session.getAttribute("dni_maestro");		
		int max = AccionesMaestro.getAñoMaestro("MAX", dni);
%>

<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>
  
<%
		session.removeAttribute("sancion_edit");
		session.removeAttribute("alumnos_sancion");
		
		Sanciones sanciones  = (Sanciones)session.getAttribute("sanciones_list");	
		
		String volver = "sanciones_select.jsp?action=listar";		
		String method = "post";
		
		Boolean b = (session.getAttribute("exit_alta") != null);
		
		String exit = null;
		
		if (b){						
			volver = "SancionEdit";			
			method = "get";
			exit= "salir";						
		}
%>

<%
if (sanciones.getLista().isEmpty()){	
%>
<div class="page-header">
<h1>Sanciones</h1>
</div>
<br>
<% Mensaje m = AccionesMensaje.getOne(55); %>
<!-- MENSAJE ATENCION -->
	<div class="alert <%=m.getTipo()%>" role="alert">
		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	<%=m.getMensaje()%> <a href="SancionEdit?do=alta" class="alert-link">Agregar nueva Sanción</a>
    </div>
    
   <%if (añoc == max){%>
   <br>
	<strong><a href="SancionEdit?do=alta"><i class="glyphicon glyphicon-edit"></i> Nueva Sanción</a></strong>
   <br>
   <%}%>
<%	
}else{
%>
<div class="page-header">
<h1>Listado de Sanciones</h1>
</div>
<table  class="table table-hover table-bordered">
	<thead>
	<tr class="active">
		<th>Apellido y Nombres</th>
		<th>Grado</th>
		<th>Turno</th>
		<th>Fecha</th>
		<th>Hora</th>
		<th>Motivo</th>		
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
	</thead>
<%	
	Alumno m = new Alumno();
	
	for (Sancion s : sanciones.getLista()) {
		
		m = AccionesAlumno.getOne(s.getDni());
		
		String fecha_entrevista = s.getFecha();		
		String[] fecha_ent = fecha_entrevista.split ("-");
		String dia = fecha_ent[fecha_ent.length - 1];
		String mes = fecha_ent[fecha_ent.length - 2];
		String año = fecha_ent[fecha_ent.length - 3];
%>
	<tbody>
	<tr>
		<td><%= m.getApellido() + ", " + m.getNombre() %></td>
		<td><%= s.getGrado()%></td>
		<td><%= s.getTurno() %></td>		
		<td><%= dia +"/" + mes + "/" + año %></td>
		<td><%= s.getHora().substring(0,5) %></td>
		<td><%= s.getMotivo() %></td>		
		<td><strong><a href="SancionEdit?do=modificar&dni_sancion=<%=s.getDni()%>&fecha_sancion=<%=s.getFecha()%>&hora_sancion=<%=s.getHora()%>&exit=<%=exit%>"><i class="glyphicon glyphicon-pencil"></i> Editar</a></strong></td>
		<td><strong><a href="SancionEdit?do=baja&dni_sancion=<%=s.getDni()%>&fecha_sancion=<%=s.getFecha()%>&hora_sancion=<%=s.getHora()%>&exit=<%=exit%>" onclick=<%=AccionesMensaje.getOne(32).getMensaje()%>><i class="glyphicon glyphicon-trash"></i> Borrar</a></strong></td>
	</tr>
	</tbody>
<%
	}
 %>
</table>
<%if (añoc == max){%>
<br>
	<strong><a href="SancionEdit?do=alta"><i class="glyphicon glyphicon-edit"></i> Nueva Sanción</a></strong>
<br>
<br>
<%}%>
<br>
<form action="<%=volver%>" method="<%=method%>">
<div class="form-group">
<%if (b){%> 
<input type="hidden" name="accion" value="alta">
<%}%>
<button type="submit" class="btn btn-primary"  value="Volver a selección de año"><i class="glyphicon glyphicon-share-alt"></i> Volver a selección de año</button> 
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