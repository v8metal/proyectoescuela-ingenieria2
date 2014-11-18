<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="datos.Maestro"%>
<%@page import="conexion.AccionesMaestro"%>
<%@page import="conexion.AccionesGrado"%>
<%@page import="conexion.AccionesUsuario"%>
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
	Grados gradosp = (Grados)session.getAttribute("grados_pendientes"); //aca debe ser grados pendiente tarde
	session.removeAttribute("grado_edit");
%>

<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>

<div class="page-header">    
	<h1>Listado de Grados Turno Tarde</h1>
  </div>
<%   
if (grados.getListaTT().isEmpty()){
%>
<br>  	
  	<!-- MENSAJE ATENCION -->
	<div class="alert alert-info" role="alert">
		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	<strong>Atención!</strong> No hay grados para el turno tarde. <a href="GradoEdit?do=alta" class="alert-link">Ingresar nuevo grado</a>
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
		<th>Modificar</th>
		<th>Materias</th>
		<th>Promoción</th>
	</tr>
	<thead>
<% 
		for (Grado g : grados.getListaTT()) {
			
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
		<td class="warning">No hay maestro asignado</td>
		<%}%>
		<%if (m2 != null){ %> 
		<td><%= m2.getNombre() + " " + m2.getApellido() %></td>
		<%}else{%>
		<td class="warning">No hay maestro asignado</td>
		<%}%>
		<td><%= ciclo %></td>		
		<td><strong><a href="GradoEdit?do=modificar&grado_modif=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>">Modificar</a></strong></td>
		<%if(g.getGrado().equals("Sala 4") || g.getGrado().equals("Sala 5")){%>
		<td class="info">Grado con áreas de trabajo</td>
		<%}else{
		 if (año == 0){%>		
		<td class="warning">Debe asignar alumnos primero</td>
		<%}else{ 
		if(dni1 == 1){%>
		<td>Debe asignar Maestro titular primero</td>
		<%}else{%>		
		<td><a href="MateriaGradoList?do=listar&grado_list=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>&grado_año=<%=año%>" >Ver Materias</a></td>
		<%}}}%>
		<% if ((g.getGrado().equals("7mo") || año == 0) || m1 == null){%>
		<td class="warning">No se puede promocionar</td>
		<%}else{ %>		
		<td><a href="GradoEdit?do=promocion&grado_modif=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>&año=<%=año%>" onclick="<%="return confirm('Esta seguro que desea promocionar "+  g.getGrado() + "-" + g.getTurno()  +"?');"%>">Promocionar</a></td>		
		<% } %>				
	</tr>
	<tbody>	
<%	 
		}	
%>
</table>
 <%}%>	
<% if (!gradosp.getLista().isEmpty() && !grados.getListaTT().isEmpty()){ %>
<br>
    <p><strong><a href="GradoEdit?do=alta">Ingresar nuevo Grado</a></strong></p>
    
<%}else if (gradosp.getLista().isEmpty() && !grados.getListaTT().isEmpty()){%>
<br>
	<!-- MENSAJE DE ALERTA -->
     <div class="bs-example">
    	<div class="alert alert-info fade in" role="alert">
     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <strong>Atención!</strong> No quedan grados para dar de alta
  	  	</div>
  	</div><!-- /example -->
<%}%>
<br>
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