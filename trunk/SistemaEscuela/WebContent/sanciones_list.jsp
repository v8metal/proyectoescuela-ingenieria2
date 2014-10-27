<%@page import="datos.Alumno"%>
<%@page import="datos.Sancion"%>
<%@page import="datos.Sanciones"%>
<%@page import="conexion.AccionesAlumno"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0">
<title>Listado de Sanciones</title>

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
              <li><a href="menu_user.jsp">Menú</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Asistencias <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="AsistenciaList">Listado</a></li>
                  <li><a href="AsistenciaListEdit">Nueva asistencia</a></li>          
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Citaciones <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="citaciones_select.jsp?action=listar">Listado</a></li>                 
                  <li><a href="CitacionEdit?do=alta">Nueva citación</a></li>          
                </ul>
              </li>
              <li class="active" class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Sanciones <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="sanciones_select.jsp?action=listar">Listado</a></li>
                  <li><a href="SancionEdit?do=alta">Nueva sanción</a></li>          
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Entrevistas <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="EntrevistaList">Listado</a></li>
                </ul>
              </li>
              <li><a href="nota_menu.jsp">Notas</a></li>
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
  <br>
<%
	if (session.getAttribute("usuario") != null) {
	
		session.removeAttribute("sancion_edit");
		session.removeAttribute("alumnos_sancion");
		
		Sanciones sanciones  = (Sanciones)session.getAttribute("sanciones_list");	
		
		String volver = "sanciones_select.jsp?action=listar";		
		String method = "post";
		
		Boolean b = (session.getAttribute("exit_alta") != null);
		
		String exit = null;
		
		if (b){						
			volver = "SancionEdit";			
			method = "get";
			exit= "salir";						
		}
%>

<%
if (sanciones.getLista().isEmpty()){	
%>
<div class="page-header">
<h1>Sanciones</h1>
</div>
<br>
<div class="alert alert-info" role="alert">
    <strong>Atención!</strong> No hay sanciones para el año seleccionado
</div>
<%	
}else{
%>
<h1>Listado de Sanciones</h1>

<table  class="table table-hover table-bordered">
	<tr>
		<th>Apellido y Nombres</th>
		<th>Grado</th>
		<th>Turno</th>
		<th>Fecha</th>
		<th>Hora</th>
		<th>Motivo</th>		
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
<%	
	Alumno m = new Alumno();
	
	for (Sancion s : sanciones.getLista()) {
		
		m = AccionesAlumno.getOne(s.getDni());
		
		String fecha_entrevista = s.getFecha();		
		String[] fecha_ent = fecha_entrevista.split ("-");
		String dia = fecha_ent[fecha_ent.length - 1];
		String mes = fecha_ent[fecha_ent.length - 2];
		String año = fecha_ent[fecha_ent.length - 3];
%>
	<tr>
		<td><%= m.getApellido() + ", " + m.getNombre() %></td>
		<td><%= s.getGrado()%></td>
		<td><%= s.getTurno() %></td>		
		<td><%= dia +"/" + mes + "/" + año %></td>
		<td><%= s.getHora().substring(0,5) %></td>
		<td><%= s.getMotivo() %></td>		
		<td><a href="SancionEdit?do=modificar&dni_sancion=<%=s.getDni()%>&fecha_sancion=<%=s.getFecha()%>&hora_sancion=<%=s.getHora()%>&exit=<%=exit%>">Modificar</a></td>
		<td><a href="SancionEdit?do=baja&dni_sancion=<%=s.getDni()%>&fecha_sancion=<%=s.getFecha()%>&hora_sancion=<%=s.getHora()%>&exit=<%=exit%>">Borrar</a></td>	</tr>
<%
	}
 %>
</table>
<%} %>
<br>
<div class="form-group">
<form action="<%=volver%>" method="<%=method%>">
<%if (b){%> 
<input type="hidden" name="accion" value="alta">
<%}%>
<input type="submit" class="btn btn-primary" value="Volver">
</form>
</div>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</div>
</body>
</html>