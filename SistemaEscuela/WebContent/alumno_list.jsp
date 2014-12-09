<%@page import="conexion.AccionesEstado"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="datos.EstadoAlumno"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.Alumnos"%>
<%@page import="datos.Mensaje"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMensaje"%>
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
  	<!-- sirve para visualizar el men� superior -->
  </div>


  <div class="page-header"> 
	<h1><%=titulo%></h1>
	</div>	
	
<%
		Alumnos alumnos = (Alumnos)session.getAttribute("alumnos_alumno");
		
		String grado = (String)session.getAttribute("grado_alumno");
		String turno = (String)session.getAttribute("turno_alumno");
		Integer a�o = (Integer) session.getAttribute("a�oAlumno");
		
		//para alumno_edit, que aparezcan los mismos datos de grado del listado	
		session.setAttribute("grado_alta",grado);
		session.setAttribute("turno_alta",turno);
		session.setAttribute("a�oAlta",a�o);
		//para alumno_edit, que aparezcan los mismos datos de grado del listado
		
		
		if (alumnos.getLista().isEmpty()){
	
%>

<br>
	<%Mensaje m = AccionesMensaje.getOne(53);%>
	<div class="alert <%=m.getTipo() %>" role="alert">
  	<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
  	<%=m.getMensaje()%>  <%if(a�o == AccionesAlumno.getA�oAlumnos("MAX")){%><a href="alumno_edit.jsp" class="alert-link"> Alta de Alumno <i class="glyphicon glyphicon-edit"></i></a> <%}%>
 	</div>
<%}else {%> 	

<br>

<table class="table table-hover table-bordered">
	<thead>
	<tr class="active">
		<th>&nbsp;</th>
		<th>Apellido y Nombres</th>	
		<th>D.N.I.</th>
		<th>Domicilio</th>		
		<th>Tel�fono</th>
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
			//valida si el alumno est� promocionado, repite o si est� en condiciones de ambas cosas
			    prom = AccionesAlumno.checkPromocion(a.getDni(), a�o);  
			i++;
%>
	<tbody>
	<tr>
		<td><%=i%></td>
		<td><strong><a href="alumnoEdit?do=modificar&dni_alum=<%=a.getDni()%>"><%= a.getApellido() + ", " + a.getNombre() %></a></strong></td>
		<td><%= a.getDni() %></td>		
		<td><%= a.getDomicilio() %></td>		
		<td><%= a.getTelefono() %></td>
<!--	<td><%= a.getLugar_nac() %></td>	-->
<!--	<td><%= a.getIglesia() %></td>	-->
		<td><input type="checkbox" name="ind_grupo" disabled <%= a.isInd_grupo() ? "checked" : "" %>/></td>
		<td><input type="checkbox" name="ind_sub" disabled <%= a.isInd_subsidio() ? "checked" : "" %>/></td>
		<%if (ea.isActivo()){%><td>ACTIVO</td><%} else {%><td><strong><a href="alumnoInactivo?do=listar">INACTIVO</a></strong></td><%}%>	
		<td><strong><a href="certificadoEdit?do=modificar&dni=<%= a.getDni() %>"><i class="glyphicon glyphicon-pencil"></i> Editar</a></strong></td>		
		<% 	
		  if (ea.isActivo()){ //verifica si el alumno est� activo
				
			boolean menor= false, mayor=false, cero = false;			
			if (prom > 0)  mayor = true;
			if (prom < 0)  menor = true;
			if (prom == 0) cero  = true;
			
			if (cero){%>
				<td>REPITE A�O</td>
		  <%}
			if (menor){%> <!--esta en condiciones de repetir o promocionar-->
			
				<td><strong><a name="delete-link" href="alumnoEdit?do=baja&dni_alum=<%= a.getDni() %>" onclick=<%=AccionesMensaje.getOne(22).getMensaje()%>><i class="glyphicon glyphicon-arrow-down"></i> BAJA</a></strong></td>
			
				<%if(!grado.equals("7� Grado")){%>							
					<td><strong><a href="AlumnoEdit?do=promocion&dni_alum=<%=a.getDni()%>" onclick=<%=AccionesMensaje.getOne(23).getMensaje()%>>PROMOCION</a></strong></td>											
			   <%}%>
					<td><strong><a href="AlumnoEdit?do=repeticion&dni_alum=<%=a.getDni()%>" onclick=<%=AccionesMensaje.getOne(24).getMensaje()%>>REPETICION</a></strong></td>
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
<br>
 <!-- MENSAJE -->
 <%	
	Mensaje mensaje = null;
	if (session.getAttribute("mensaje") != null) {
		mensaje = (Mensaje) session.getAttribute("mensaje");
		session.setAttribute("mensaje", null);
 %> 
   <div class="bs-example">
    	 <div class="alert <%=mensaje.getTipo()%> fade in" role="alert">
     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <%= mensaje.getMensaje()%>
  	  </div>
  </div>
<br>
 <%}%>  
<%if(a�o == AccionesAlumno.getA�oAlumnos("MAX")){%>
 <strong><a href="alumno_edit.jsp"><i class="glyphicon glyphicon-edit"></i> Alta de Alumno </a></strong>
<br>
<br>
<%}%>
<br>
<strong><a href="certificado_list.jsp"><%= "VER CERTIFICADOS DE " + titulo.toUpperCase() %></a></strong>
<br>
<br>
<br>
<%
}	
%>

<div class="form-group">
<form action="menu_alumnos.jsp" method="post">
<input type="hidden" name="volver" value="volver">
<button type="submit" class="btn btn-primary" value="Volver"><i class="glyphicon glyphicon-share-alt"></i> Volver</button>
</form>
</div>
</div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

	<!-- men� superior -->
	<script src="js/menu_admin.js"></script> 
</body>
</html>