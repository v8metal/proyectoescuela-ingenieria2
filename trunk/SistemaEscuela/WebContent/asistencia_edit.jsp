<%@page import="datos.Maestro"%>
<%@page import="datos.Maestro_Grado"%>
<%@page import="datos.Maestros_Grados"%>
<%@page import="datos.Tardanza"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.Alumnos"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Asistencias</title>
<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</head>
<body>
<div class="container">

<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "asistencia_edit.jsp") != 1){							
		response.sendRedirect("Login");
	}
	Maestro maestro = (Maestro)session.getAttribute("maestro");
	String nombre = maestro.getNombre();
	String apellido = maestro.getApellido();
	
	Tardanza asistencia = (Tardanza) request.getAttribute("asistencia");	
	Alumno alumno = (Alumno) session.getAttribute("alumnoAltaAsistencia");
	String fecha = (String) session.getAttribute("fechaDisplayAsistencia");
		
	String error = "";
	
	if (session.getAttribute("error") != null) error = (String) session.getAttribute("error");
	%>
	
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
              <li class="active"> <a href="menu_asistencias.jsp">Asistencias</a></li>
              <li class="dropdown">
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
	String accion = "Alta";

	Alumno a = null;
	
	if(asistencia != null){
		
		a = AccionesAlumno.getOne(asistencia.getDni());
		accion = "Modificar";
%>
<div class="page-header">
<h1>Edición de asistencia</h1>
</div>

<h3><%=a.getNombre() + " " + a.getApellido() + " - " + fecha %></h3>
<br>

<%}else{%>
<div class="page-header">
<h1>Alta de asistencia</h1>
</div>

<h3><%=alumno.getNombre() + " " + alumno.getApellido() + " - " + fecha %></h3>
<br>
 
<%}%>

	<div class="form-group">	
	<form action="AsistenciaEdit" method="post">
	<input type="hidden" name=do value="<%=accion%>">
	<input type="hidden" class="form-control" name="alumno_asistencia" value=<%=asistencia!=null?asistencia.getDni():alumno.getDni()%>>	
		<table class="table table-hover table-bordered">
		    <tr> <%= error %></tr>
		    <tr>
		      <th>CONDICION</th>		      
		      <td>
		      <div class="col-xs-3">		     
		     	 <select class="form-control" name="condicion" autofocus>
		     	 <%if(asistencia!=null){%>
		     	 <option value="Ausente" <%=asistencia.getIndicador().equals("Ausente") ? "selected" : ""%>>Ausente</option>
		     	 <option value="Presente" <%=asistencia.getIndicador().equals("Presente") ? "selected" : ""%>>Presente</option>
		      	<%}else{ %>
		     	 <option value="Ausente" selected >Ausente</option>
		     	 <option value="Presente" >Presente</option>
		     	 <%}%>		      	      
		      	</select>	
		      </div>	      	      
		      	</td>
		    </tr>
		    <tr>
		      
		      <th>OBSERVACIONES</th>
		      <td>
		      	<div class="col-xs-8">
		      		<textarea name="observaciones" cols="40" rows="4" class="form-control" placeholder="Observaciones"><%=asistencia!=null?asistencia.getObservaciones():"" %></textarea>
		      	</div>
		      </td>
		    </tr> 
		  </table>
		  
		  		  <button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="return confirm('Esta seguro que desea guardar?');">Guardar</button>
		          <button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave" onclick="return confirm('Esta seguro que desea cancelar?');">Cancelar</button> 
		          
		  </form>
		  </div>
		  <br>
		  <br>		  	
		 	<div class="form-group">
			<form action="AsistenciaList" method="get">
			<input type="hidden" name="accion" value="listarAsistencias">
			<button type="submit" class="btn btn-primary"  value="Volver al Listado de asistencias">Volver al Listado de asistencias</button>
			</form>
			</div> 
</div>
</body>
</html>