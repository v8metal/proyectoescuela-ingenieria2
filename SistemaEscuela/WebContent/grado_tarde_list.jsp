<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="datos.Maestro"%>
<%@page import="conexion.AccionesMaestro"%>
<%@page import="conexion.AccionesGrado"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding ="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de Grados</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</head>
<body>

<%
	if (session.getAttribute("admin") != null) {	
		 
		Grados grados = (Grados)session.getAttribute("grados_alta");
		Grados gradosp = (Grados)session.getAttribute("grados_pendientes"); //aca debe ser grados pendiente tarde
		session.removeAttribute("grado_edit");
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
            <li><a href="menu_admin.jsp">Menú</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Alumnos <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="menu_listado_alum.jsp">Listado</a></li>
                  <li><a href="alumno_edit.jsp">Nuevo alumno</a></li>          
                  <li class="divider"></li>
                  <li class="dropdown-header">Nav header</li>
                  <li><a href="alumnoInactivo?do=listar">Registro de bajas</a></li>
                </ul>
              </li>
              <li class="active" class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Grados <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="GradoList?listar=mañana">Turno mañana</a></li>                 
                  <li><a href="GradoList?listar=tarde">Turno tarde</a></li>          
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Maestros <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="maestroList">Listado</a></li>
                  <li><a href="maestroEdit?accion=alta">Nuevo maestro</a></li>          
                  <li class="divider"></li>
                  <li><a href="MaestroList?tipo=inactivos">Registro de bajas</a></li>
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Materias <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="materiaList?from=menu_admin">Listado</a></li>
                  <li><a href="materiaEdit?do=alta">Nueva materia</a></li>          
                  <li class="divider"></li>
                  <li><a href="materiaList?from=materia_inactiva_list">Materias inactivas</a></li>
                </ul>
              </li>
              <li><a href="menu_tardanzas.jsp">Tardanzas</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Entrevistas <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="EntrevistaList">Listado</a></li>
                  <li><a href="EntrevistaEdit?do=alta">Nueva entrevista</a></li>          
                </ul>
              </li>
              <li><a href="menu_cuotas.jsp">Cuotas</a></li>
              <li><a href="UsuarioList">Usuarios</a></li>
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
        		</div>
			</li>
          </ul>
        </div>
      </div>
    </div>
  
  <br>
  <br>
  
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
    
<%}else if (gradosp.getLista().isEmpty()){%>
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
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</div>
</body>
</html>