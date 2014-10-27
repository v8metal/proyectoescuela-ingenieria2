<%@page import="datos.Alumno"%>
<%@page import="datos.Citacion"%>
<%@page import="datos.Citaciones"%>
<%@page import="conexion.AccionesAlumno"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de Citaciones</title>

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
              <li class="active" class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Citaciones <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="citaciones_select.jsp?action=listar">Listado</a></li>                 
                  <li><a href="CitacionEdit?do=alta">Nueva citación</a></li>          
                </ul>
              </li>
              <li class="dropdown">
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
<%
	if (session.getAttribute("usuario") != null) {
	
		session.removeAttribute("citacion_edit");
		session.removeAttribute("alumnos_citacion");
		
		Citaciones citaciones  = (Citaciones)session.getAttribute("citaciones_list");	
		
		String volver = "citaciones_select.jsp?action=listar";		
		String method = "post";
		
		Boolean b = (session.getAttribute("exit_alta") != null);
		
		String exit = null;
		
		if (b){						
			volver = "CitacionEdit";			
			method = "get";
			exit= "salir";						
		}
%>
<%
if (citaciones.getLista().isEmpty()){	
%>
<div class="page-header"> 
<h1>Citaciones</h1>
</div>
<br>
<div class="alert alert-info" role="alert">
    <strong>Atención!</strong> No hay citaciones para el año seleccionado
</div>
<%	
}else{
%>
<div class="page-header"> 
<h1>Listado de Citaciones</h1>
</div>
<table class="table table-hover table-bordered">
	<tr>
		<th>Apellido y Nombres</th>
		<th>Grado</th>
		<th>Turno</th>				
		<th>Fecha</th>
		<th>Hora</th>
		<th>Descripción</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
<%	
	Alumno m = new Alumno();

	for (Citacion c : citaciones.getLista()) {
		
		m = AccionesAlumno.getOne(c.getDni());
		
		String fecha_entrevista = c.getFecha();		
		String[] fecha_ent = fecha_entrevista.split ("-");
		String dia = fecha_ent[fecha_ent.length - 1];
		String mes = fecha_ent[fecha_ent.length - 2];
		String año = fecha_ent[fecha_ent.length - 3];
%>
	<tr>
		<td><%= m.getApellido() + ", " + m.getNombre() %></td>
		<td><%= c.getGrado() %></td>
		<td><%= c.getTurno() %></td>		
		<td><%= dia +"/" + mes + "/" + año %></td>
		<td><%= c.getHora().substring(0,5) %></td>
		<td><%= c.getDescripcion() %></td>						
		<td><a href="CitacionEdit?do=modificar&dni_citacion=<%=c.getDni()%>&fecha_citacion=<%=c.getFecha()%>&hora_citacion=<%=c.getHora()%>&exit=<%=exit%>">Modificar</a></td>
		<td><a href="CitacionEdit?do=baja&dni_citacion=<%=c.getDni()%>&fecha_citacion=<%=c.getFecha()%>&hora_citacion=<%=c.getHora()%>&exit=<%=exit%>">Borrar</a></td>	</tr>
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
<button type="submit" class="btn btn-primary"  value="Volver">Volver</button>
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