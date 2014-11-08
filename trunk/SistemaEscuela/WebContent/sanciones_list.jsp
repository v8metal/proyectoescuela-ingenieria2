<%@page import="datos.Alumno"%>
<%@page import="datos.Maestro"%>
<%@page import="datos.Sancion"%>
<%@page import="datos.Sanciones"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesUsuario"%>
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

<%
		//modulo de seguridad
		int tipo = (Integer) session.getAttribute("tipoUsuario");						
		if (AccionesUsuario.validarAcceso(tipo, "sanciones_list.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}

		//Recupero el maestro para mostrar su nombre y apellido en el menú superior	
		Maestro maestro = (Maestro)session.getAttribute("maestro");
		String nombre = maestro.getNombre();
		String apellido = maestro.getApellido();
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
              <li><a href="menu_user.jsp">Menú</a></li>
              <li> <a href="menu_asistencias.jsp">Asistencias</a></li>
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
        		  <p class="navbar-text navbar-right"><strong><%= nombre + " " + apellido %></strong></p>
        		</div>
			</li>
          </ul>
        </div>
      </div>
    </div>
  
  <br>
  <br>
<%
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
<!-- MENSAJE ATENCION -->
	<div class="alert alert-info" role="alert">
		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	<strong>Atención!</strong> No hay sanciones para el año seleccionado. <a href="SancionEdit?do=alta">Agregar nueva Sanción</a>
    </div>
<%	
}else{
%>
<div class="page-header">
<h1>Listado de Sanciones</h1>
</div>
<table  class="table table-hover table-bordered">
	<thead>
	<tr class="active">
		<th>Apellido y Nombres</th>
		<th>Grado</th>
		<th>Turno</th>
		<th>Fecha</th>
		<th>Hora</th>
		<th>Motivo</th>		
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
	</thead>
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
	<tbody>
	<tr>
		<td><%= m.getApellido() + ", " + m.getNombre() %></td>
		<td><%= s.getGrado()%></td>
		<td><%= s.getTurno() %></td>		
		<td><%= dia +"/" + mes + "/" + año %></td>
		<td><%= s.getHora().substring(0,5) %></td>
		<td><%= s.getMotivo() %></td>		
		<td><strong><a href="SancionEdit?do=modificar&dni_sancion=<%=s.getDni()%>&fecha_sancion=<%=s.getFecha()%>&hora_sancion=<%=s.getHora()%>&exit=<%=exit%>">Modificar</a></strong></td>
		<td><strong><a href="SancionEdit?do=baja&dni_sancion=<%=s.getDni()%>&fecha_sancion=<%=s.getFecha()%>&hora_sancion=<%=s.getHora()%>&exit=<%=exit%>" onclick="return confirm('Esta seguro que desea borrar?');">Borrar</a></strong></td>
	</tr>
	</tbody>
<%
	}
 %>
</table>
<br>
	<strong><a href="SancionEdit?do=alta">Nueva Sanción</a></strong>
<br>
<br>
<br>
<form action="<%=volver%>" method="<%=method%>">
<div class="form-group">
<%if (b){%> 
<input type="hidden" name="accion" value="alta">
<%}%>
<input type="submit" class="btn btn-primary" value="Volver a selección de año">
</div>
</form>

<%} %>

</div>
</body>
</html>