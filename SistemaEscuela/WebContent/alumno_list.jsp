<%@page import="conexion.AccionesEstado"%>
<%@page import="datos.EstadoAlumno"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.Alumnos"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<%
	if (session.getAttribute("admin") != null) {
		
		String error = "";
		if (session.getAttribute("error") != null) {
			error = (String)session.getAttribute("error");
			session.setAttribute("error", "");
		}
		
		String titulo = (String)session.getAttribute("titulo");
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
		Alumnos alumnos = (Alumnos)session.getAttribute("alumnos");

		if (alumnos.getLista().isEmpty()){
			String grado = (String)session.getAttribute("grado");
			String turno = (String)session.getAttribute("turno");
			String año = (String)session.getAttribute("año");
			
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
		<th>Nº</th>
		<th>Apellido y Nombres</th>
		<th>D.N.I.</th>
		<th>Domicilio</th>
		<th>Teléfono</th>
<!--	<th>Fecha nac.</th>			-->
		<th>Lugar nac.</th>
<!--		<th>D.N.I. padre</th>	-->
<!--		<th>D.N.I. madre</th>	-->
<!--		<th>Her. may.</th>		-->
<!--		<th>Her. men.</th>		-->
		<th>Iglesia</th>
<!--		<th>Escolaridad</th>	-->
		<th>Grupo flia.</th>
		<th>Sub.</th>
		<th>Estado</th>
		<th>Cert.</th>	
<!--		<th>&nbsp;</th>			-->
		<th>&nbsp;</th>
	</tr>
	<thead>
<% 			int i = 0;
			for (Alumno a : alumnos.getLista()) {
				EstadoAlumno ea = AccionesEstado.getOne(a.getDni());
				i++;
%>
	<tbody>
	<tr>
		<td><center><%=i%></center></td>
<!-- 		<td><%= a.getApellido() + ", " + a.getNombre() %></td>		 -->
		<td><a href="alumnoEdit?do=modificar&dni_alum=<%=a.getDni()%>&dni_tutor=<%=a.getDni_tutor()%>&dni_madre=<%=a.getDni_madre()%>"><%= a.getApellido() + ", " + a.getNombre() %></a></td>
		<td><%= a.getDni() %></td>
		<td><%= a.getDomicilio() %></td>
		<td><%= a.getTelefono() %></td>
<!--		<td><%= a.getFecha_nac() %></td>		-->
		<td><%= a.getLugar_nac() %></td>
<!--		<td><%= a.getDni_tutor() == 0 ? "" : a.getDni_tutor() %></td>	-->		<!-- En caso de que el dni sea 0 (no tiene padre) muestra un string vacio -->
<!--		<td><%= a.getDni_madre() == 0 ? "" : a.getDni_madre() %></td>	-->
<!--		<td><%= a.getCant_her_may() %></td>		-->
<!--		<td><%= a.getCant_her_men() %></td>		-->
		<td><%= a.getIglesia() %></td>
<!--		<td><%= a.getEsc() %></td>		-->
		<td><center><input type="checkbox" name="ind_grupo" disabled 
			<%= a.isInd_grupo() ? "checked" : "" %> /></center></td>
		<td><center><input type="checkbox" name="ind_sub" disabled 
			<%= a.isInd_subsidio() ? "checked" : "" %> /></center></td>
			<%
				if (ea.isActivo()) {
			%>
		<td>ACTIVO</td>	
			<%
				} else {
			%>
		<td><a href="alumnoInactivo?do=listar">INACTIVO</a></td>
			<%
				}
			%>	
		<td><a href="certificadoEdit?do=modificar&dni=<%= a.getDni() %>">Ver</a></td>	
<!-- 	<td><a href="alumnoEdit?do=modificar&dni_alum=<%=a.getDni()%>&dni_tutor=<%=a.getDni_tutor()%>&dni_madre=<%=a.getDni_madre()%>">Modificar</a></td>		 -->
		<%
				if (ea.isActivo()) {	
		%>	
		<td><a name="delete-link" href="alumnoEdit?do=baja&dni_alum=<%= a.getDni() %>" >DAR DE BAJA</a></td>
		<%
				} else {
 		%>
 		<td>&nbsp;</td>
 		<%
				}
 		%>
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
<a href="certificado_list.jsp"><%= "VER CERTIFICADOS DE " + titulo.toUpperCase() %></a>
<br>
<br>
<div class="form-group">
<form action="menu_listado_alum.jsp" method="post">
<button type="submit" class="btn btn-primary" value="Volver">Volver</button>
</form>
</div>
<%
		}
		
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</div>
</body>
</html>