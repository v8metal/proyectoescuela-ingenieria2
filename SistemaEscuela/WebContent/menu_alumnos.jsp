<%@page import="datos.Maestro"%>
<%@page import="datos.Tardanza"%>
<%@page import="datos.Tardanza"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="conexion.AccionesTardanza"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>			
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Menú de Alumnos</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<!--<link rel="stylesheet" href="style/jquery-ui.css">  con ese no se ven las flechitas-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="js/jquery-1.10.2.js"></script>
<script src="js/jquery-ui.js"></script>

</head>
<body>
<% 

	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "menu_alumnos.jsp") != 1){							
		response.sendRedirect("Login");
	}
	
	Integer añoAlumno = null;
	Grados grados = null;
			
	if (request.getAttribute("añoAlumno") != null){
		
		añoAlumno = (Integer) request.getAttribute("añoAlumno");				
		grados = (Grados) request.getAttribute("gradosAlumno");
		
		session.setAttribute("añoAlumno", añoAlumno);
		session.setAttribute("gradosAlumno", grados);		
	}
	
	if (request.getParameter("volver") != null){
		
		añoAlumno = (Integer) session.getAttribute("añoAlumno");				
		grados = (Grados) session.getAttribute("gradosAlumno");
		
		
	}
	
%>

<div class="container">  
  <div class="page-header"> 
	<h1>Administrador</h1>
  </div>
  
      <!-- Static navbar -->
      <div class="navbar navbar-default" role="navigation">
        <div class="container-fluid">
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
              <li class="active"><a href="menu_admin.jsp">Menú</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Alumnos <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="menu_alumnos.jsp">Listado</a></li>
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
              <li class="active"><a href="CerrarSesion">Salir</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </div>  
  
  	<div class="page-header">  	  
		<h1>Menú de Alumnos</h1>		
    </div>
    
    <div class="form-group">
 
	<form action="AlumnoList" method="get">

	<input name="año" id="año" type="hidden" value="<%=añoAlumno%>">
		
	<%if(añoAlumno == null){ %>
    	<input type="hidden" name="accion" value="solicitarGrados">
	<%}else{%>	    
		<input type="hidden" name="accion" value="listarAlumnos">
	<%}%>

	<%if(añoAlumno == null){ %>

	    <label class="control-label" for="input">Seleccionar año:</label>  
	     
	    <br>
		<br>

	      <div class="row">
         	   <div class="col-xs-3">
            	    <div class="input-group">
            	         <span class="input-group-btn">
                	        <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnAcept">Buscar</button>
               	    	 </span>
                 	   <select class="form-control" name="año_alumno" autofocus>
  							 <%  			
								int año = (Integer)session.getAttribute("añoc");
  							 %>
  							 	<option value="<%=año+1 %>"><%=año+1 %></option>
  								<option selected value="<%=año %>"><%=año %></option>
  							<% 
  								for(int i=año-11; i>año-20;i--){
  							%> 							  	 
 							  <option value="<%=i %>"><%=i %></option>		 	
   							<%
   								}							 		
							 %>   			 		
 					 	</select>					
               		</div>
           	 	</div>
      	 </div>	           	    
	     	<input type="hidden" name="accion" value="solicitarGrados">
	     	<br>
     	    <br>     
	 
	<%}else{ %>

	    <label class="control-label" for="input">Seleccionar año:</label>
 		<br>
		<br>	         
	 
	    <div class="row">
         	   <div class="col-xs-3">
            	    <div class="input-group">
            	         <span class="input-group-btn">
                	        <button type="button" disabled="disabled" class="btn btn-primary"  value="Aceptar" name="btnAcept">Buscar</button>
               	    	 </span>
 					 		<input class="form-control" type="text" size=4 readonly name="anio" value="<%=añoAlumno%>"> 			
               		</div>
           	 	</div>
      	 </div>
		<br>

	  <%if (grados.getLista().isEmpty()) { %>	
	  	
	  	<br>

    	 <div class="alert alert-info fade in" role="alert">
	     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	     	 <strong>Atención!</strong> No hay grados para el año seleccionado. <a href="menu_alumnos.jsp" class="alert-link">Seleccionar otro año</a>
  	 	 </div>  	

	  <%}else{%>
	      	
		 <br>
      	 <label class="control-label" for="input">Seleccionar grado-turno:</label>
 		 <br>
		 <br>
		 
		  	<div class="row">
         	   <div class="col-xs-3">
            	    <div class="input-group">
            	         <span class="input-group-btn">
                	        <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnAcept">Buscar</button>
               	         </span>
                 	   <select class="form-control" name="grado_turno">
  							 <%  			
  								for (Grado g : grados.getLista()) { 				 
 							 %>	
 							  <option value="<%=g.getGrado() + " - " + g.getTurno()%>"><%=g.getGrado() + " - " + g.getTurno()%></option>		 	
   							<%
								}			
							 %>   			 		
 					 	</select>					
               		</div>
           	 	</div>
      	 </div>
		
		 <br>
		 <br>
	
		 </form> 
		
		 <form action="menu_alumnos.jsp">
		 	<div class="form-group">
				<input class="btn btn-primary" type="submit" value="Seleccionar otro año">
			</div>
		 </form>	

	   <%}%>
	<%}%> 
  
 <br>
 <br>
 <%if(añoAlumno != null){ %>		
<!-- 
	<form action="menu_asistencias.jsp">
		<div class="form-group">
			<input class="btn btn-primary" type="submit" value="Seleccionar otro año">
		</div>
	</form>	
 -->		
<%}%>
</div>
</body>
</html>