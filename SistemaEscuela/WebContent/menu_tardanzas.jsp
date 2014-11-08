<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="conexion.AccionesCuota"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>			
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Menú de Tardanzas</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

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
  
<% 
	int tipo = (Integer) session.getAttribute("tipoUsuario");
	if (AccionesUsuario.validarAcceso(tipo, "menu_tardanzas.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
	
	Integer añoTardanza = null;
	Grados grados = null;
			
	if (request.getAttribute("añoTardanza") != null){
		
		añoTardanza = (Integer) request.getAttribute("añoTardanza");				
		grados = (Grados) request.getAttribute("gradosTardanza");
		
		session.setAttribute("añoTardanza", añoTardanza);
		session.setAttribute("gradosTardanza", grados);		
	}
	
	if (request.getParameter("volver") != null){
		
		añoTardanza = (Integer) session.getAttribute("añoTardanza");				
		grados = (Grados) session.getAttribute("gradosTardanza");
		
		
	}
%>
	<div class="page-header">  	  
		<h1>Menú de Tardanzas</h1>		
    </div>
 
 	<form action="TardanzaList" method="get">
 
 	<%if(añoTardanza == null){ %>

	    <label class="control-label" for="input">Seleccionar año:</label> 
	    
 		<br>
		<br>
	        
	     <div class="row">
         	   <div class="col-xs-3">
            	    <div class="input-group">
            	         <span class="input-group-btn">
                	        <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnAcept">Buscar</button>
               	    	 </span>
                 	   <select class="form-control" name="año_tardanza" autofocus>
  							 <%  			
								int año = (Integer)session.getAttribute("añoc");
  								for(int i=año; i>año-20;i--){					 
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
                	        <button type="button" disabled="disabled" class="btn btn-primary" value="Aceptar" name="btnAcept">Buscar</button>
               	     	 </span>
 					 		<input class="form-control" type="text" readonly name="anio" value="<%=añoTardanza%>">			
               		</div>
           	 	</div>
      	 </div>
		<br> 	

	  <%if (grados.getLista().isEmpty()) { %>  	
	  
		<br>
		<!-- MENSAJE INFORMATIVO -->
    	 <div class="alert alert-info fade in" role="alert">
	     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	     	 <strong>Atención!</strong> No hay grados para el año seleccionado <a href="menu_tardanzas.jsp" class="alert-link">Seleccionar otro año</a>
  	 	 </div>
  	 	 
	  <%}else{%>

	      <label class="control-label" for="input">Seleccionar grado-turno:</label>
	      	
	       <br>
	       <br>
	      	
	      <div class="row">
         	   <div class="col-xs-3">
            	    <div class="input-group">
            	         <span class="input-group-btn">
                	        <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnAcept">Buscar</button>
               	     </span>
                 	   <select class="form-control" name="grado_anio" autofocus>
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
      	  	   <input type="hidden" name="accion" value="listarTardanzas">	
 
 	</form>
 	
 	<form action="menu_tardanzas.jsp">
		  	<div class="form-group">
		  		<input class="btn btn-primary" type="submit" value="Seleccionar otro año"> 
		  	</div> 
	</form>
		  
		  
	   <%}%>
	<%}%>	 
 	
</div>
</body>
</html>