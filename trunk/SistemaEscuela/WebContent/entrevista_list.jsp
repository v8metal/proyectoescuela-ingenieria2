<%@page import="datos.Entrevista"%>
<%@page import="datos.Entrevistas"%>
<%@page import="datos.Maestro"%>
<%@page import="conexion.AccionesMaestro"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de Entevistas</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</head>
<body>

<%

if(session.getAttribute("admin")!=null || session.getAttribute("usuario")!=null){
	
session.removeAttribute("entrevista_edit");
session.removeAttribute("maestros_ent_alta");
Entrevistas entrevistas = (Entrevistas)session.getAttribute("entrevistas");
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
              <li class="active" class="dropdown">
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
if (entrevistas.getLista().isEmpty()){
%>
<div class="page-header">
<h1>Entrevistas</h1>
</div>
<br>
<div class="alert alert-info" role="alert">
    <strong>Atención!</strong> No hay entrevistas cargadas
</div>

<%}else{%> 
<h1>Listado de Entrevistas</h1>
</div>
<table class="table table-hover table-bordered">
	<thead>
	<tr class="active">
		<th>Fecha</th>
		<th>Hora</th>
		<th>Maestro</th>
		<th>Nombre Alumno</th>		
		<th>Descripción</th>		
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
		<td><%= e.getDescripcion() %></td>		
		<td><strong><a href="EntrevistaEdit?do=modificar&fecha=<%=e.getFecha()%>&nombre=<%=e.getNombre()%>&hora=<%=e.getHora()%>">Modificar</a></strong></td>		
		<td><strong><a href="EntrevistaEdit?do=borrar&fecha=<%=e.getFecha()%>&nombre=<%=e.getNombre()%>&hora=<%=e.getHora()%>"  onclick="return confirm('Esta seguro que desea borrar la entrevista?');">Borrar</a></strong></td>				
	</tr>
	</tbody>
<%
	}
 %>
</table>
<%}
if(session.getAttribute("admin") != null){
	%>
	<br>
	<p><strong><a href="EntrevistaEdit?do=alta">Agregar Entrevista</a></strong></p>
	<br>
	<br>
	<div class="form-group">
	<form action="menu_admin.jsp" method="post">
	<button type="submit" class="btn btn-primary"  value="Volver al Menú Principal">Volver al menú</button>
	</form>
	</div>
	<%
}else{
	%>
	<br>
	<br>
	<div class="form-group">
	<form action="menu_user.jsp" method="post">
	<button type="submit" class="btn btn-primary"  value="Volver al Menú Principal">Volver al menú</button>
	</form>	
	<%
}
%>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</div>
</body>
</html>