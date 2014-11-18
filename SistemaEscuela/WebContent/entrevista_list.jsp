<%@page import="datos.Entrevista"%>
<%@page import="datos.Entrevistas"%>
<%@page import="datos.Maestro"%>
<%@page import="conexion.AccionesMaestro"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "entrevistas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de Entevistas</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

</head>
<body>
<div class="container">
<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");
	if (AccionesUsuario.validarAcceso(tipo, "entrevista_list.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
	
	session.removeAttribute("entrevista_edit");
	session.removeAttribute("maestros_ent_alta");
	Entrevistas entrevistas = (Entrevistas)session.getAttribute("entrevistas");
	
	String nombre = "";
	String apellido = "";
	
//	if (session.getAttribute("dni_maestro") != null ){		
//	Maestro maestro = (Maestro)session.getAttribute("maestro");
//	nombre = maestro.getNombre();
//	apellido = maestro.getApellido();

//	user
//} else {
//	admin
//}
%>

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>
  
<%  
if (entrevistas.getLista().isEmpty()){
%>
<div class="page-header">
<h1>Listado de Entrevistas</h1>
</div>
<br>
		<!-- MENSAJE INFORMATIVO -->
    	 <div class="alert alert-info fade in" role="alert">
	     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	     	 <strong>Atención!</strong> No hay entrevistas cargadas
  	 	 </div>

<%}else{%> 
<div class="page-header">
<h1>Listado de Entrevistas</h1>
</div>
<table class="table table-hover table-bordered">
	<thead>
	<tr class="active">
		<th>Fecha</th>
		<th>Hora</th>
		<th>Maestro</th>
		<th>Nombre Alumno</th>
	<%if(session.getAttribute("dni_maestro") != null){%>		
		<th>Descripción</th>
	<%}%>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
	</thead>
<%
	Maestro m = new Maestro();	
	for (Entrevista e : entrevistas.getLista()) {
		
		m = AccionesMaestro.getOne(e.getdniMaestro());
		
		String fecha_entrevista = e.getFecha();		
		String[] fecha_ent = fecha_entrevista.split ("-");
		String dia = fecha_ent[fecha_ent.length - 1];
		String mes = fecha_ent[fecha_ent.length - 2];
		String año = fecha_ent[fecha_ent.length - 3];
%>
	<tbody>
	<tr>
		<td><%= dia +"/" + mes + "/" + año %></td>		
		<td><%= e.getHora().substring(0,5)%></td>
		<td><%= m.getNombre() + " " + m.getApellido() %></td>
		<td><%= e.getNombre() %></td>
	<%if(session.getAttribute("dni_maestro") != null){%>		
		<td><%= e.getDescripcion() %></td>
	<%}%>				
		<td><strong><a href="EntrevistaEdit?do=modificar&fecha=<%=e.getFecha()%>&nombre=<%=e.getNombre()%>&hora=<%=e.getHora()%>">Modificar</a></strong></td>		
		<td><strong><a href="EntrevistaEdit?do=borrar&fecha=<%=e.getFecha()%>&nombre=<%=e.getNombre()%>&hora=<%=e.getHora()%>"  onclick="return confirm('Esta seguro que desea borrar la entrevista?');">Borrar</a></strong></td>				
	</tr>
	</tbody>
<%
	}
 %>
</table>
<%}
if(session.getAttribute("dni_maestro") == null){
	%>
	<br>
	<p><strong><a href="EntrevistaEdit?do=alta">Agregar Entrevista</a></strong></p>
	<br>
	<br>
<%}%>
</div>
	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

	<!-- menú superior -->
	<script src="js/menu_admin.js"></script>
	<script src="js/menu_user.js"></script> 
</body>
</html>