<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="datos.Maestro"%>
<%@page import="datos.Mensaje"%>
<%@page import="conexion.AccionesMaestro"%>
<%@page import="conexion.AccionesGrado"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMensaje"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding ="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "grados");%>

<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de Grados</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

</head>
<body>
<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "grado_tarde_list.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}

		 
	Grados grados = (Grados)session.getAttribute("grados_alta");
	Grados gradosp = (Grados)session.getAttribute("grados_pendientes"); //aca debe ser grados pendiente mañana
	session.removeAttribute("grado_edit");
%>

<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>
  
<div class="page-header"> 
	<h1>Listado de Grados Turno Mañana</h1>
  </div>
<%   
if (grados.getListaTM().isEmpty()){
%> 
<br>
  	<%Mensaje m = AccionesMensaje.getOne(26);%>
	<!-- MENSAJE INFORMATIVO -->
     <div class="bs-example">
    	<div class="alert <%=m.getTipo()%> fade in" role="alert">
     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <%=m.getMensaje()%> <a href="GradoEdit?do=alta" class="alert-link"> Nuevo grado <i class="glyphicon glyphicon-edit"></i></a>
  	  	</div>
  	</div>
<%}else{%>
<table class="table table-hover table-bordered">
	<thead>
	<tr class="active">
		<th>Grado</th>				
		<th>Tipo</th>
		<th>Evaluación</th>
		<th>Salón</th>
		<th>Maestro Titular</th>
		<th>Maestro Paralelo</th>
		<th>Ciclo Lectivo</th>
		<th>Materias</th>
		<th>Promoción</th>
		<th>&nbsp;</th>
	</tr>
	<thead>
<% 
		for (Grado g : grados.getListaTM()) {
			
			Maestro m1 = AccionesMaestro.getOne(g.getMaestrotit());
			Maestro m2 = AccionesMaestro.getOne(g.getMaestropar());
			
			int dni1=1;			
			if(m1 != null) dni1=m1.getDni();
				
			String ciclo = "No hay alumnos cargados";
			int año = AccionesGrado.getCurrentYear(g);
			
			if (año != 0){		
				ciclo = Integer.toString(año);
			}			
%>
	<tbody>
	<tr>
		<td><%= g.getGrado() %></td>		
		<td><%= g.getEvaluacionNombre() %></td>
		<td><%= g.getPeriodo() %></td>
		<td><%= g.getSalon() %></td>
		<%if (m1 != null){ %> 
		<td><%= m1.getNombre() + " " + m1.getApellido() %></td>
		<%}else{%>
		<td class="warning"> No hay maestro asignado <i class="glyphicon glyphicon-warning-sign"></i></td>
		<%}%>
		<%if (m2 != null){ %> 
		<td><%= m2.getNombre() + " " + m2.getApellido() %></td>
		<%}else{%>
		<td class="warning"> No hay maestro asignado <i class="glyphicon glyphicon-warning-sign"></i></td>
		<%}%>
		<td><%= ciclo %></td>		
		<%if(g.getGrado().equals("Sala 4") || g.getGrado().equals("Sala 5")){%>
		<td class="info">Grado con áreas de trabajo <i class="glyphicon glyphicon-exclamation-sign"></i></td>
		<%}else{
		 if (año == 0){%>		
		<td class="warning"> Debe asignar alumnos primero <i class="glyphicon glyphicon-warning-sign"></i></td>
		<%}else{ 
		if(dni1 == 1){%>
		<td class="warning"> Debe asignar Maestro titular primero <i class="glyphicon glyphicon-warning-sign"></i></td>
		<%}else{%>		
		<td><strong><a href="MateriaGradoList?do=listar&grado_list=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>&grado_año=<%=año%>" ><i class="glyphicon glyphicon-eye-open"></i> Ver Materias</a></strong></td>
		<%}}}%>
		<% if ((g.getGrado().equals("7mo") || año == 0) || m1 == null){%>
		<td class="warning"> No se puede promocionar <i class="glyphicon glyphicon-warning-sign"></i></td>
		<%}else{ %>
		<td><a href="GradoEdit?do=promocion&grado_modif=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>&año=<%=año%>" onclick="<%="return confirm('Esta seguro que desea promocionar "+  g.getGrado() + "-" + g.getTurno()  +"?');"%>"><strong>Promocionar</strong></a></td>		
		<% } %>	
		<td><strong><a href="GradoEdit?do=modificar&grado_modif=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>"><i class="glyphicon glyphicon-pencil"></i> Editar</a></strong></td>			
	</tr>
	<tbody>
<%	 
		}	
%>
</table>
 <%}%>
  <!-- MENSAJE -->
 <%	
	Mensaje mensaje = null;
	if (session.getAttribute("mensaje") != null) {
		mensaje = (Mensaje) session.getAttribute("mensaje");
		session.setAttribute("mensaje", null);
 %> 
   <br>
   <div class="bs-example">
    	 <div class="alert <%=mensaje.getTipo()%> fade in" role="alert">
     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <%= mensaje.getMensaje()%>
  	  </div>
  </div>
 <%}%>
<% if (!gradosp.getLista().isEmpty() && !grados.getListaTM().isEmpty()){ %>
<br>
    <p><strong><a href="GradoEdit?do=alta"><i class="glyphicon glyphicon-edit"></i> Nuevo Grado</a></strong></p>
<%}else if (gradosp.getLista().isEmpty() && !grados.getListaTM().isEmpty() ){%>
<br>
	<%Mensaje m1 = AccionesMensaje.getOne(27);%>
	<!-- MENSAJE INFORMATIVO -->
     <div class="bs-example">
    	<div class="alert <%=m1.getTipo()%> fade in" role="alert">
     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <%=m1.getMensaje()%>
  	  	</div>
  	</div>
<%}%>
<br>
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
</body>
</html>