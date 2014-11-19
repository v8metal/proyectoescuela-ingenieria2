<%@page import="conexion.AccionesEstado"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="datos.EstadoAlumno"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.Alumnos"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "alumnos");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<%

	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "alumno_list.jsp") != 1){							
		response.sendRedirect("Login");						
	}		
	
	String error = "";
	if (session.getAttribute("error") != null) {
		error = (String)session.getAttribute("error");
		session.setAttribute("error", "");
	}
	
	String titulo = (String) session.getAttribute("titulo_alumno");
		
%>
<title><%=titulo%></title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">

</head>
<body>
<div class="container">  

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>

<%
		Alumnos alumnos = (Alumnos)session.getAttribute("alumnos_alumno");
		
		String grado = (String)session.getAttribute("grado_alumno");
		String turno = (String)session.getAttribute("turno_alumno");
		Integer año = (Integer) session.getAttribute("añoAlumno");
		
		//para alumno_edit, que aparezcan los mismos datos de grado del listado	
		session.setAttribute("grado_alta",grado);
		session.setAttribute("turno_alta",turno);
		session.setAttribute("añoAlta",año);
		//para alumno_edit, que aparezcan los mismos datos de grado del listado
		
		
		if (alumnos.getLista().isEmpty()){
						
			String rta = "No hay alumnos cargados en " + grado + ", turno " + turno.toLowerCase() + ", año " + año;
			
%>

<br>
<br>
<br>

 <div class="alert alert-info" role="alert">
     <strong>Atención!</strong> <%=rta%>
 </div>
<%		
		} else {
%> 	

  <div class="page-header"> 
	<h1><%=titulo%></h1>
	</div>	

<br>

<table class="table table-hover table-bordered">
	<thead>
	<tr class="active">
		<th>&nbsp;</th>
		<th>Apellido y Nombres</th>	
		<th>D.N.I.</th>
		<th>Domicilio</th>		
		<th>Teléfono</th>
<!-- 	<th>Lugar nac.</th>	 -->
<!--	<th>Iglesia</th>	-->
		<th>Grupo</th>
		<th>Subsidio</th>
		<th>Estado</th>
		<th>Cert.</th>	
		<th>&nbsp;</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>		
	</tr>
	<thead>
<%			int i = 0;
 			int prom = 0;
			for (Alumno a : alumnos.getLista()) {
				EstadoAlumno ea = AccionesEstado.getOne(a.getDni());
			//valida si el alumno está promocionado, repite o si está en condiciones de ambas cosas
			    prom = AccionesAlumno.checkPromocion(a.getDni(), año);  
			i++;
%>
	<tbody>
	<tr>
		<td><%=i%></td>
		<td><a href="alumnoEdit?do=modificar&dni_alum=<%=a.getDni()%>"><%= a.getApellido() + ", " + a.getNombre() %></a></td>
		<td><%= a.getDni() %></td>		
		<td><%= a.getDomicilio() %></td>		
		<td><%= a.getTelefono() %></td>
<!--	<td><%= a.getLugar_nac() %></td>	-->
<!--	<td><%= a.getIglesia() %></td>	-->
		<td><input type="checkbox" name="ind_grupo" disabled <%= a.isInd_grupo() ? "checked" : "" %>/></td>
		<td><input type="checkbox" name="ind_sub" disabled <%= a.isInd_subsidio() ? "checked" : "" %>/></td>
		<%if (ea.isActivo()){%><td>ACTIVO</td><%} else {%><td><strong><a href="alumnoInactivo?do=listar">INACTIVO</a></strong></td><%}%>	
		<td><strong><a href="certificadoEdit?do=modificar&dni=<%= a.getDni() %>"><i class="glyphicon glyphicon-eye-open"></i> Ver</a></strong></td>		
		<% 	
		  if (ea.isActivo()){ //verifica si el alumno está activo
				
			boolean menor= false, mayor=false, cero = false;			
			if (prom > 0)  mayor = true;
			if (prom < 0)  menor = true;
			if (prom == 0) cero  = true;
			
			if (cero){%>
				<td>REPITE AÑO</td>
		  <%}
			if (menor){%> <!--esta en condiciones de repetir o promocionar-->
			
				<td><strong><a name="delete-link" href="alumnoEdit?do=baja&dni_alum=<%= a.getDni() %>" onclick="return confirm('Esta seguro que desea dar de baja');"><i class="glyphicon glyphicon-arrow-down"></i> BAJA</a></strong></td>
			
				<%if(!grado.equals("7° Grado")){%>							
					<td><strong><a href="AlumnoEdit?do=promocion&dni_alum=<%=a.getDni()%>" onclick="return confirm('Esta seguro que desea promocionar');">PROMOCION</a></strong></td>											
			   <%}%>
					<td><strong><a href="AlumnoEdit?do=repeticion&dni_alum=<%=a.getDni()%>" onclick="return confirm('Esta seguro que desea repetir año');">REPETICION</a></strong></td>
			<%}
			if (mayor){%>			    
				<td>PROMOCIONADO</td>
			<%}%>
			
		<%}%>			
	</tr>
	<tbody>
<%
			}
 %>
</table>
<% 
			if (!error.equals("")) {
%>
<br>
<br>
<%=error%>
<br>
<br>
<%
			}
%> 
<br>
<%if(año == AccionesAlumno.getAñoAlumnos("MAX")){%>
 <a href="alumno_edit.jsp">Alta de Alumno</a>
<br>
<br>
<%}%>
<br>
<strong><a href="certificado_list.jsp"><%= "VER CERTIFICADOS DE " + titulo.toUpperCase() %></a></strong>
<br>
<br>
<div class="form-group">
<form action="menu_alumnos.jsp" method="post">
<input type="hidden" name="volver" value="volver">
<button type="submit" class="btn btn-primary" value="Volver"><i class="glyphicon glyphicon-share-alt"></i> Volver</button>
</form>
</div>
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
	<script src="js/menu_admin.js"></script> 
</body>
</html>