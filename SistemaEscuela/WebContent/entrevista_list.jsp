<%@page import="datos.Entrevista"%>
<%@page import="datos.Entrevistas"%>
<%@page import="datos.Maestro"%>
<%@page import="datos.Mensaje"%>
<%@page import="conexion.AccionesMaestro"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMensaje"%>
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
	
	Integer dni_maestro = (Integer) session.getAttribute("dni_maestro");
%>

  <div id="divmenu">
  	<!-- sirve para visualizar el men� superior -->
  </div>
  
<%  
if (entrevistas.getLista().isEmpty()){
%>
<div class="page-header">
<h1>Listado de Entrevistas</h1>
</div>
<br>
<!-- MENSAJE INFORMATIVO -->
<% Mensaje m = AccionesMensaje.getOne(44);%>
  	 <div class="alert <%=m.getTipo()%> fade in" role="alert">
     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <%=m.getMensaje()%> <%if(session.getAttribute("dni_maestro") == null){%><a href="EntrevistaEdit?do=alta" class="alert-link"> Nueva Entrevista <i class="glyphicon glyphicon-edit"></i></a><%}%>
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
	<%if(dni_maestro != null){%>		
		<th>Descripci�n</th>
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
		String a�o = fecha_ent[fecha_ent.length - 3];
%>
	<tbody>
	<tr>
		<td><%= dia +"/" + mes + "/" + a�o %></td>		
		<td><%= e.getHora().substring(0,5)%></td>
		<td><%= m.getNombre() + " " + m.getApellido() %></td>
		<td><%= e.getNombre() %></td>
	<%if(session.getAttribute("dni_maestro") != null){%>		
		<td><%= e.getDescripcion() %></td>
	<%}%>				
		<td><strong><a href="EntrevistaEdit?do=modificar&fecha=<%=e.getFecha()%>&nombre=<%=e.getNombre()%>&hora=<%=e.getHora()%>"><i class="glyphicon glyphicon-pencil"></i> Editar</a></strong></td>		
		<td><strong><a href="EntrevistaEdit?do=borrar&fecha=<%=e.getFecha()%>&nombre=<%=e.getNombre()%>&hora=<%=e.getHora()%>"  onclick=<%=AccionesMensaje.getOne(32).getMensaje()%>><i class="glyphicon glyphicon-trash"></i> Borrar</a></strong></td>				
	</tr>
	</tbody>
<%
	}
 %>
</table>

<%
	if(session.getAttribute("dni_maestro") == null){
%>
	<br>
	<p><strong><a href="EntrevistaEdit?do=alta"><i class="glyphicon glyphicon-edit"></i> Nueva Entrevista</a></strong></p>
	<br>
	<br>
<%
	}
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

	<!-- men� superior -->
	<%if(dni_maestro == null){%>
	<script src="js/menu_admin.js"></script>
	<%}%>
	<%if(dni_maestro != null){%>
	<script src="js/menu_user.js"></script>
	<%}%> 
</body>
</html>