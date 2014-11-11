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

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</head>
<body>
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
              <li class="active" class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Alumnos <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="menu_listado_alum.jsp">Listado</a></li>
                  <li><a href="alumno_edit.jsp">Nuevo alumno</a></li>          
                  <li class="divider"></li>
                  <li class="dropdown-header">Nav header</li>
                  <li><a href="alumnoInactivo?do=listar">Registro de bajas</a></li>
                </ul>
              </li>
              <li class="dropdown">
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
	<tr>
		<th>Apellido y Nombres</th>	
		<th>D.N.I.</th>
		<th>Domicilio</th>		
		<th>Teléfono</th>
		<th>Lugar nac.</th>
		<th>Iglesia</th>
		<th>Grupo</th>
		<th>Subsidio</th>
		<th>Estado</th>
		<th>Cert.</th>	
		<th>&nbsp;</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>		
	</tr>
	<thead>
<% 			int prom = 0;
			for (Alumno a : alumnos.getLista()) {
				EstadoAlumno ea = AccionesEstado.getOne(a.getDni());
			//valida si el alumno está promocionado, repite o si está en condiciones de ambas cosas
			    prom = AccionesAlumno.checkPromocion(a.getDni(), año);  
%>
	<tbody>
	<tr>
		<td><a href="alumnoEdit?do=modificar&dni_alum=<%=a.getDni()%>"><%= a.getApellido() + ", " + a.getNombre() %></a></td>
		<td><%= a.getDni() %></td>		
		<td><%= a.getDomicilio() %></td>		
		<td><%= a.getTelefono() %></td>
		<td><%= a.getLugar_nac() %></td>
		<td><%= a.getIglesia() %></td>
		<td><input type="checkbox" name="ind_grupo" disabled <%= a.isInd_grupo() ? "checked" : "" %>/></td>
		<td><input type="checkbox" name="ind_sub" disabled <%= a.isInd_subsidio() ? "checked" : "" %>/></td>
		<%if (ea.isActivo()){%><td>ACTIVO</td><%} else {%><td><a href="alumnoInactivo?do=listar">INACTIVO</a></td><%}%>	
		<td><a href="certificadoEdit?do=modificar&dni=<%= a.getDni() %>">Ver</a></td>		
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
			
				<td><a name="delete-link" href="alumnoEdit?do=baja&dni_alum=<%= a.getDni() %>" onclick="return confirm('Esta seguro que desea dar de baja');">BAJA</a></td>
			
				<%if(!grado.equals("7° Grado")){%>							
					<td><a href="AlumnoEdit?do=promocion&dni_alum=<%=a.getDni()%>" onclick="return confirm('Esta seguro que desea promocionar');">PROMOCION</a></td>											
			   <%}%>
					<td><a href="AlumnoEdit?do=repeticion&dni_alum=<%=a.getDni()%>" onclick="return confirm('Esta seguro que desea repetir año');">REPETICION</a></td>
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
<a href="certificado_list.jsp"><%= "VER CERTIFICADOS DE " + titulo.toUpperCase() %></a>
<br>
<br>
<div class="form-group">
<form action="menu_alumnos.jsp" method="post">
<button type="submit" class="btn btn-primary" value="Volver">Volver</button>
</form>
</div>
<%
}	
%>
</div>
</body>
</html>