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
<%session.setAttribute("modulo", "asistencias");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Asistencias</title>
<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

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
	
  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>
  
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
	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

	<!-- menú superior -->
	<script src="js/menu_user.js"></script> 
</body>
</html>