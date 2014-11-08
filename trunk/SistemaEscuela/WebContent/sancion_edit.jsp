<%@page import="datos.Sancion"%>
<%@page import="datos.Maestro"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.Alumnos"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0">
<title>Editar Sanción</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<!--<link rel="stylesheet" href="style/jquery-ui.css">  con ese no se ven las flechitas-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="js/jquery-1.10.2.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/entrevista.js"></script> <!-- DatePic para entrevistas -->


</head>
<body>

<%
		//modulo de seguridad
		int tipo = (Integer) session.getAttribute("tipoUsuario");						
		if (AccionesUsuario.validarAcceso(tipo, "sancion_edit.jsp") != 1){							
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
		Sancion s = (Sancion) session.getAttribute("sancion_edit");
		
		String error = "";
		
		if (session.getAttribute("error") != null) {
			error = (String)session.getAttribute("error");
			System.out.println(error);
			session.setAttribute("error", "");
		}
	
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
<h1>Modificación de Sanción</h1>
</div>
<h3><%="Sanción para " + alumno.getNombre() + " " + alumno.getApellido()%></h3>
<br>
<%}else if (alumnos.getLista().isEmpty() & error.equals("")){
	empty = true;
%>
<div class="page-header">
<h1>Alta de Sanción</h1>
</div>
<br>
<div class="alert alert-info" role="alert">
    <strong>Atención!</strong> No hay alumnos cargados para el año
</div>
<%}else{%>
<div class="page-header">
<h1>Alta de Sanción</h1>
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
			<td><label for="input">Fecha:</label></td>			
			<td>
			<div class="col-xs-5">
			<input class="form-control" type="text" id="datepicker" required autofocus name="fecha_sancion">
			</div>
			</td>			
	    </tr>
	    <tr>	    	
		<td><label for="input">Hora</label></td>
		<td>
		<div class="col-xs-2">
		<select name="hora_sancion" class="form-control">
			 <option value="08:00:00" <%=s != null && s.getHora().equals("08:00:00") ? "selected" : ""%>>08:00</option>
  			 <option value="08:30:00" <%=s != null && s.getHora().equals("08:30:00") ? "selected" : ""%>>08:30</option>
  			 <option value="09:00:00" <%=s != null && s.getHora().equals("09:00:00") ? "selected" : ""%>>09:00</option>
  			 <option value="09:30:00" <%=s != null && s.getHora().equals("09:30:00") ? "selected" : ""%>>09:30</option>
  			 <option value="10:00:00" <%=s != null && s.getHora().equals("10:00:00") ? "selected" : ""%>>10:00</option>
  			 <option value="10:30:00" <%=s != null && s.getHora().equals("10:30:00") ? "selected" : ""%>>10:30</option>
  			 <option value="11:00:00" <%=s != null && s.getHora().equals("11:00:00") ? "selected" : ""%>>11:00</option>
  			 <option value="11:30:00" <%=s != null && s.getHora().equals("11:30:00") ? "selected" : ""%>>11:30</option>
  			 <option value="12:00:00" <%=s != null && s.getHora().equals("12:00:00") ? "selected" : ""%>>12:00</option>
  			 <option value="12:30:00" <%=s != null && s.getHora().equals("12:30:00") ? "selected" : ""%>>12:30</option>
  			 <option value="13:00:00" <%=s != null && s.getHora().equals("13:00:00") ? "selected" : ""%>>13:00</option>
  			 <option value="13:30:00" <%=s != null && s.getHora().equals("13:30:00") ? "selected" : ""%>>13:30</option>
  			 <option value="14:00:00" <%=s != null && s.getHora().equals("14:00:00") ? "selected" : ""%>>14:00</option>
  			 <option value="14:30:00" <%=s != null && s.getHora().equals("14:30:00") ? "selected" : ""%>>14:30</option>
  			 <option value="15:00:00" <%=s != null && s.getHora().equals("15:00:00") ? "selected" : ""%>>15:00</option>
  			 <option value="15:30:00" <%=s != null && s.getHora().equals("15:30:00") ? "selected" : ""%>>15:30</option>
  			 <option value="16:00:00" <%=s != null && s.getHora().equals("16:00:00") ? "selected" : ""%>>16:00</option>
  			 <option value="16:30:00" <%=s != null && s.getHora().equals("16:30:00") ? "selected" : ""%>>16:30</option>
  			 <option value="17:00:00" <%=s != null && s.getHora().equals("17:00:00") ? "selected" : ""%>>17:00</option>
  			 <option value="17:30:00" <%=s != null && s.getHora().equals("17:30:00") ? "selected" : ""%>>17:30</option>  			 
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
	<!-- MENSAJE DE CONFIRMACION -->
	<%
		String mensaje= "return confirm('Esta seguro que desea realizar el alta?');"; 
		  
//		if (sancion != null){			//ARREGLAR
			
			mensaje = "return confirm('Esta seguro que desea modificar?');"; 
//		}
		 
		%>
<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="<%=mensaje%>">Guardar</button>
<button type="reset" class="btn btn-primary"  value="Cancelar">Cancelar</button>
<%}%>
</form>
</div>
<br>
<%if (!error.equals("")) {%>
	 <div class="bs-example">
    	 <div class="alert alert-warning fade in" role="alert">
     	 	<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 	<strong>Cuidado!</strong> <%=error%>
  	  	</div>
 	 </div><!-- /example -->
<br>
<br>
<%}%>
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
</div>
</body>
</html>