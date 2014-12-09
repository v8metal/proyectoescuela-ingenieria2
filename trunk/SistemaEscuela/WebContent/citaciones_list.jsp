<%@page import="datos.Alumno"%>
<%@page import="datos.Maestro"%>
<%@page import="datos.Citacion"%>
<%@page import="datos.Citaciones"%>
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

		//Recupero el maestro para mostrar su nombre y apellido en el men� superior	
		Maestro maestro = (Maestro)session.getAttribute("maestro");
		String nombre = maestro.getNombre();
		String apellido = maestro.getApellido();
		
		int a�oc = (Integer) session.getAttribute("a�o_citacion");
		int dni = (Integer) session.getAttribute("dni_maestro");		
		int max = AccionesMaestro.getA�oMaestro("MAX", dni);
%>

<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el men� superior -->
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
<% Mensaje m = AccionesMensaje.getOne(52); %>

	<div class="alert <%=m.getTipo()%>" role="alert">
		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	<%=m.getMensaje()%> <a href="citaciones_select.jsp" class="alert-link"><i class="glyphicon glyphicon-share-alt"></i> Volver a selecci�n de a�o</a>
    </div>
<!--   
    <%if (a�oc == max){%>
    <br>    
	<strong><a href="CitacionEdit?do=alta"><i class="glyphicon glyphicon-edit"></i> Nueva Citaci�n</a></strong>
	<br>
	<%}%>
 -->  	
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
		<th>Descripci�n</th>
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
		String a�o = fecha_ent[fecha_ent.length - 3];
%>
	<tbody>
	<tr>
		<td><%= m.getApellido() + ", " + m.getNombre() %></td>
		<td><%= c.getGrado() %></td>
		<td><%= c.getTurno() %></td>		
		<td><%= dia +"/" + mes + "/" + a�o %></td>
		<td><%= c.getHora().substring(0,5) %></td>
		<td><%= c.getDescripcion() %></td>						
		<td><strong><a href="CitacionEdit?do=modificar&dni_citacion=<%=c.getDni()%>&fecha_citacion=<%=c.getFecha()%>&hora_citacion=<%=c.getHora()%>&exit=<%=exit%>"><i class="glyphicon glyphicon-pencil"></i> Editar</a></strong></td>
		<td><strong><a href="CitacionEdit?do=baja&dni_citacion=<%=c.getDni()%>&fecha_citacion=<%=c.getFecha()%>&hora_citacion=<%=c.getHora()%>&exit=<%=exit%>" onclick=<%=AccionesMensaje.getOne(32).getMensaje()%>><i class="glyphicon glyphicon-trash"></i> Borrar</a></strong></td>
	</tr>
	</tbody>
<%
	}
 %>
</table>
<%if (a�oc == max){%>
<br>
	<strong><a href="CitacionEdit?do=alta"><i class="glyphicon glyphicon-edit"></i> Nueva Citaci�n</a></strong>
<br>
<%}%>
<br>
<br>
<form action="<%=volver%>" method="<%=method%>">
<div class="form-group">
<%if (b){%> 
<input type="hidden" name="accion" value="alta">
<%}%>
<button type="submit" class="btn btn-primary"  value="Volver"><i class="glyphicon glyphicon-share-alt"></i> Volver a selecci�n de a�o</button>
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

	<!-- men� superior -->
	<script src="js/menu_user.js"></script> 
</body>
</html>