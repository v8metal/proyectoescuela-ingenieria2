<%@page import="datos.Maestro_Grado"%>
<%@page import="datos.Maestros_Grados"%>
<%@page import="datos.Tardanza"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.Alumnos"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de Tardanzas</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>		

<!--<link rel="stylesheet" href="style/jquery-ui.css">  con ese no se ven las flechitas-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="js/jquery-1.10.2.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/tardanzas.js"></script> <!-- DatePic para entrevistas -->

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
              <li class="active"><a href="menu_tardanzas.jsp">Tardanzas</a></li>
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

<div class="page-header">
<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "tardanza_edit.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
%>
<%
	Tardanza tardanza = (Tardanza) request.getAttribute("tardanza");
	Alumnos alumnos = (Alumnos) session.getAttribute("alumnosAltaTardanza");
	
	int dia_tardanza = 0;
	String mes_tardanza = "";
	int año_tardanza = 0;
	
	String accion = "alta";
	
	if (tardanza != null) {
		
		accion = "modificar";
		
	}	

	if(tardanza != null){
		Alumno a = AccionesAlumno.getOne(tardanza.getDni());
%>
<h1>Edición de Tardanza - <%=a.getNombre() + " " + a.getApellido() %></h1>
<%}else{%>
<h1>Alta de Tardanza </h1>
<%}%>
</div>
	<div class="form-group">	
	<form action="TardanzaEdit" method="post">	
	<input type="hidden" name=do value="<%=accion%>">
	<input name="fecha" id="fecha" type="hidden" value="<%=tardanza!=null? tardanza.getFecha() : "0"%>">
	<%if(tardanza != null){%>					 		
		<input type="hidden" class="form-control" name="alumno_tardanza"value=<%=tardanza.getDni()%>>
	<%}%>	
		 <table class="table table-hover table-bordered">
		    <tr>
				<th><label for="input">Fecha:</label></th>			
				<td>
				<div class="col-xs-2">
					<input class="form-control" type="text" id="datepicker" required autofocus name="fecha_tardanza">
				</div>
				</td>			
		  	</tr>
		  	<tr>
		  		<%if(tardanza == null){%>
		  		<th><label for="input">Alumno:</label></th>
		  		<td>
		  		<div class="col-xs-5">
		  			<select name="alumno_tardanza" class="form-control" required>   
		  			<%
					for (Alumno a : alumnos.getLista()){		 		
		 			%>
		 			<option class="form-control" value=<%=a.getDni() %>><%= a.getNombre() + " " + a.getApellido() %></option>
		 			<%} %>		 		
		 			</select>
		 		</div>
		 		</td>	
		 		<%}%>	 		
		 	</tr>
		 	<tr>
		        <th><label for="input">Observaciones:</label></th>
         		<td>
         			<div class="col-xs-10">
         			<textarea class="form-control" cols="40" rows="4" name="observaciones" placeholder="Descripción"><%=tardanza!=null?tardanza.getObservaciones():"" %></textarea>
         			</div>
         		</td>
         	</tr>
		  </table>
		  
		 		<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="return confirm('Esta seguro que desea guardar?');">Guardar</button>
		  		<button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave" onclick="return confirm('Esta seguro que desea cancelar?');">Cancelar</button> 
		  </form>
		  </div>
		  <br>
		  
		  <!-- MENSAJE DE ERROR -->
		   <%	String error = "";
	
			if (session.getAttribute("error") != null) {
				error = (String)session.getAttribute("error");
				session.setAttribute("error", null);		
	
 			%>
		  <div class="bs-example">
    	 	<div class="alert alert-danger fade in" role="alert">
     	 		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     			<strong>Ups!</strong> <%= error %>
  	 		 </div>
  		  </div><!-- /example -->
  		  
  		   <% } %>   
  		  
		  <br>
		 	<div class="form-group">
			<form action="TardanzaList" method="get">
			<input type="hidden" name="accion" value="listarTardanzas">
			<button type="submit" class="btn btn-primary"  value="Volver al Listado de Tardanzas">Volver al Listado de Tardanzas</button>
			</form>
			</div>
</div>
</body>
</html>