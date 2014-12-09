<%@page import="datos.Sancion"%>
<%@page import="datos.Maestro"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.Alumnos"%>
<%@page import="datos.Mensaje"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMensaje"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "sanciones");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0">
<title>Editar Sanci�n</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">

<!--<link rel="stylesheet" href="style/jquery-ui.css">  con ese no se ven las flechitas-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">

</head>
<body>

<%
		//modulo de seguridad
		int tipo = (Integer) session.getAttribute("tipoUsuario");						
		if (AccionesUsuario.validarAcceso(tipo, "sancion_edit.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
		
		//Recupero el maestro para mostrar su nombre y apellido en el men� superior	
		Maestro maestro = (Maestro)session.getAttribute("maestro");
		String nombre = maestro.getNombre();
		String apellido = maestro.getApellido();
%>

<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el men� superior -->
  </div>
  
<%
		Sancion s = (Sancion) session.getAttribute("sancion_edit");
		
		Alumno alumno = null;
		Alumnos alumnos = new Alumnos();
		Boolean empty = false;
		
		if (s != null){				
			alumno = AccionesAlumno.getOne(s.getDni());		
		}else{			
			alumnos = (Alumnos) session.getAttribute("alumnos_sancion");			
		}		
		
%>
<%if (s != null){ %>
<div class="page-header">
<h1>Modificaci�n de Sanci�n</h1>
</div>
<h3><%="Sanci�n para " + alumno.getNombre() + " " + alumno.getApellido()%></h3>
<br>
<%}else if (alumnos.getLista().isEmpty()){
	empty = true;
%>
<div class="page-header">
<h1>Alta de Sanci�n</h1>
</div>
<br>
<% Mensaje m = AccionesMensaje.getOne(53); %>
	<div class="alert <%=m.getTipo()%>" role="alert">
		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	<%=m.getMensaje()%> <a href="sanciones_select.jsp" class="alert-link"><i class="glyphicon glyphicon-share-alt"></i> Volver a selecci�n de a�o</a>
    </div>
<%}else{%>
<div class="page-header">
<h1>Alta de Sanci�n</h1>
</div>
<%}%>
<div class="form-group">
<form action="SancionEdit" method="post">
<input name="fecha" id="fecha" type="hidden" value="<%=s!=null?s.getFecha():"0"%>">
<%if (s != null){ %>
<input type="hidden" name="action" value="update">
<%}else{%>
<input type="hidden" name="action" value="alta">
<%}
if (empty == false){
%>
<table class="table table-hover table-bordered">
<%if (s == null){%>
	<tr>
		<td><label for="input">Alumno</label></td>
		<td>
		<div class="col-xs-5">
		<select name="alumno_sancion" class="form-control" autofocus>		
		<%
		for (Alumno a  : alumnos.getLista()){		 		
 		%>  			  
   			<option value="<%= a.getDni() %>"><%=a.getApellido()+ ", " + a.getNombre()%> </option>   			  
   		 <%   			
		}		
		%>
		</select>
		</div>
		</td>
	</tr>
<%}%>
	<tr>
			<td><label for="input">Fecha</label></td>			
			<td>
			<div class="col-xs-2">
			<input class="form-control" type="text" id="datepicker" required autofocus name="fecha_sancion">
			</div>
			</td>			
	    </tr>
	    <tr>	    	
		<td><label for="input">Hora</label></td>
		<td>
		<div class="col-xs-2">
		<select name="hora_sancion" class="form-control">
			 	<option value="08:00:00" <%=s!=null && s.getHora().equals("08:00:00") ? "selected" : ""%>>08:00</option>
				<option value="08:15:00" <%=s!=null && s.getHora().equals("08:15:00") ? "selected" : ""%>>08:15</option>
		  		<option value="08:30:00" <%=s!=null && s.getHora().equals("08:30:00") ? "selected" : ""%>>08:30</option>
		  		<option value="08:45:00" <%=s!=null && s.getHora().equals("08:45:00") ? "selected" : ""%>>08:45</option>
		  		<option value="09:00:00" <%=s!=null && s.getHora().equals("09:00:00") ? "selected" : ""%>>09:00</option>
		  		<option value="09:15:00" <%=s!=null && s.getHora().equals("09:15:00") ? "selected" : ""%>>09:15</option>
		  		<option value="09:30:00" <%=s!=null && s.getHora().equals("09:30:00") ? "selected" : ""%>>09:30</option>
		  		<option value="09:45:00" <%=s!=null && s.getHora().equals("09:45:00") ? "selected" : ""%>>09:45</option>
		  		<option value="10:00:00" <%=s!=null && s.getHora().equals("10:00:00") ? "selected" : ""%>>10:00</option>
		  		<option value="10:15:00" <%=s!=null && s.getHora().equals("10:15:00") ? "selected" : ""%>>10:15</option>
		  		<option value="10:30:00" <%=s!=null && s.getHora().equals("10:30:00") ? "selected" : ""%>>10:30</option>
		  		<option value="10:45:00" <%=s!=null && s.getHora().equals("10:45:00") ? "selected" : ""%>>10:45</option>
		  		<option value="11:00:00" <%=s!=null && s.getHora().equals("11:00:00") ? "selected" : ""%>>11:00</option>
		  		<option value="11:15:00" <%=s!=null && s.getHora().equals("11:15:00") ? "selected" : ""%>>11:15</option>
		  		<option value="11:30:00" <%=s!=null && s.getHora().equals("11:30:00") ? "selected" : ""%>>11:30</option>
		  		<option value="11:45:00" <%=s!=null && s.getHora().equals("11:45:00") ? "selected" : ""%>>11:45</option>
		  		<option value="12:00:00" <%=s!=null && s.getHora().equals("12:00:00") ? "selected" : ""%>>12:00</option>
		  		<option value="12:15:00" <%=s!=null && s.getHora().equals("12:15:00") ? "selected" : ""%>>12:15</option>
		  		<option value="12:30:00" <%=s!=null && s.getHora().equals("12:30:00") ? "selected" : ""%>>12:30</option>
		  		<option value="12:45:00" <%=s!=null && s.getHora().equals("12:45:00") ? "selected" : ""%>>12:45</option>
		  		<option value="13:00:00" <%=s!=null && s.getHora().equals("13:00:00") ? "selected" : ""%>>13:00</option>
		  		<option value="13:15:00" <%=s!=null && s.getHora().equals("13:15:00") ? "selected" : ""%>>13:15</option>
		  		<option value="13:30:00" <%=s!=null && s.getHora().equals("13:30:00") ? "selected" : ""%>>13:30</option>
		  		<option value="13:45:00" <%=s!=null && s.getHora().equals("13:45:00") ? "selected" : ""%>>13:45</option>
		  		<option value="14:00:00" <%=s!=null && s.getHora().equals("14:00:00") ? "selected" : ""%>>14:00</option>
		  		<option value="14:15:00" <%=s!=null && s.getHora().equals("14:15:00") ? "selected" : ""%>>14:15</option>
		  		<option value="14:30:00" <%=s!=null && s.getHora().equals("14:30:00") ? "selected" : ""%>>14:30</option>
		  		<option value="14:45:00" <%=s!=null && s.getHora().equals("14:45:00") ? "selected" : ""%>>14:45</option>
		  		<option value="15:00:00" <%=s!=null && s.getHora().equals("15:00:00") ? "selected" : ""%>>15:00</option>
		  		<option value="15:15:00" <%=s!=null && s.getHora().equals("15:15:00") ? "selected" : ""%>>15:15</option>
		  		<option value="15:30:00" <%=s!=null && s.getHora().equals("15:30:00") ? "selected" : ""%>>15:30</option>
		  		<option value="15:45:00" <%=s!=null && s.getHora().equals("15:45:00") ? "selected" : ""%>>15:45</option>
		  		<option value="16:00:00" <%=s!=null && s.getHora().equals("16:00:00") ? "selected" : ""%>>16:00</option>
		  		<option value="16:15:00" <%=s!=null && s.getHora().equals("16:15:00") ? "selected" : ""%>>16:15</option>
		  		<option value="16:30:00" <%=s!=null && s.getHora().equals("16:30:00") ? "selected" : ""%>>16:30</option>
		  		<option value="16:45:00" <%=s!=null && s.getHora().equals("16:45:00") ? "selected" : ""%>>16:45</option>
		  		<option value="17:00:00" <%=s!=null && s.getHora().equals("17:00:00") ? "selected" : ""%>>17:00</option>
		  		<option value="17:15:00" <%=s!=null && s.getHora().equals("17:15:00") ? "selected" : ""%>>17:15</option>
		  		<option value="17:30:00" <%=s!=null && s.getHora().equals("17:30:00") ? "selected" : ""%>>17:30</option>
		  		<option value="17:45:00" <%=s!=null && s.getHora().equals("17:45:00") ? "selected" : ""%>>17:45</option>    			 
  		</select>  	
  		</div>		 
		</td>			
	</tr>
	<tr>
	<td><label for="input">Motivo</label></td>	
	<td>
	<div class="col-xs-10">
	<textarea rows="4" cols="50"  class="form-control" name="motivo_sancion"><%=s != null ? s.getMotivo() : ""%></textarea>
	</div>
	</td>	
	</tr>
</table>
<br>
<button type="submit" class="btn btn-primary" onclick=<%=AccionesMensaje.getOne(1).getMensaje()%>><i class="glyphicon glyphicon-floppy-disk"></i> Guardar</button>
<button type="reset" class="btn btn-primary"  onclick=<%=AccionesMensaje.getOne(3).getMensaje()%>><i class="glyphicon glyphicon-floppy-disk"></i> Cancelar</button>
<%}%>
</form>
</div>
<br>
<%	Mensaje mensaje = null;
	
	if (session.getAttribute("mensaje") != null) {
		mensaje = (Mensaje)session.getAttribute("mensaje");
		session.setAttribute("mensaje", null);	
%>
	<div class="bs-example">
    	 <div class="alert <%=mensaje.getTipo()%> fade in" role="alert">
     	 	<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 	<%=mensaje.getMensaje()%>
  	  	</div>
 	 </div>
<br>

<%
String volver =  "menu_user.jsp";
if (s != null){	
	volver = "sanciones_list.jsp";
}
%>
<div class="form-group">
<form action="<%=volver%>" method="post">
<button type="submit" class="btn btn-primary"  value="Volver">Volver</button>
</form>
</div>

<%}%>

</div>
	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

	<!-- men� superior -->
	<script src="js/menu_user.js"></script> 
	
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/entrevista.js"></script> <!-- DatePic para entrevistas -->
</body>
</html>