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
<title>Menú de Asistencias</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<!--<link rel="stylesheet" href="style/jquery-ui.css">  con ese no se ven las flechitas-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="js/jquery-1.10.2.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/asistencias.js"></script> <!-- DatePic para entrevistas -->

</head>
<body>
<div class="container">
<% 

	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "menu_asistencias.jsp") != 1){							
		response.sendRedirect("Login");
	}
	
	Maestro maestro = (Maestro)session.getAttribute("maestro");
	String nombre = maestro.getNombre();
	String apellido = maestro.getApellido();
	
	Integer añoAsistencia = null;
	Grados grados = null;
			
	if (request.getAttribute("añoAsistencia") != null){
		
		añoAsistencia = (Integer) request.getAttribute("añoAsistencia");				
		grados = (Grados) request.getAttribute("gradosAsistencia");
		
		session.setAttribute("añoAsistencia", añoAsistencia);
		session.setAttribute("gradosAsistencia", grados);		
	}
	
	if (request.getParameter("volver") != null){
		
		añoAsistencia = (Integer) session.getAttribute("añoAsistencia");				
		grados = (Grados) session.getAttribute("gradosAsistencia");
		
		
	}
	
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

	<div class="page-header">  	  
		<h1>Menú de Asistencias</h1>		
    </div>
    
    <div class="form-group">
 
	<form action="AsistenciaList" method="get">

	<input name="año" id="año" type="hidden" value="<%=añoAsistencia%>">
		
	<%if(añoAsistencia == null){ %>
    	<input type="hidden" name="accion" value="solicitarGrados">
	<%}else{%>
	    <input name="fecha" id="fecha" type="hidden" value="0">
		<input type="hidden" name="accion" value="listarAsistencias">
	<%}%>

 <!-- 
 		SELECTOR VIEJO CON TABLAS
 		
	<table class="table table-hover table-bordered">
	
	<%if(añoAsistencia == null){ %>
	  <tr>
	    <td><label for="input">Seleccionar año</label></td>	    
	    <td>
	    <div class="col-xs-5">
	    	<select class="form-control" name="año_asistencia" autofocus>
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
	     </td>         	     
	     <td>
	     	<input type="hidden" name="accion" value="solicitarGrados">
	     </td> 	     
	  </tr>
	<%}else{ %>
	  <tr>
	    <td><label for="input">Año Seleccionado</label></td>	    
	     <td>
	     	<div class="col-xs-2">
	     	<input class="form-control" type="text" size=4 readonly name="anio" value="<%=añoAsistencia%>">
	     	</div>
	     </td> 
	  </tr>
	
	  <%if (grados.getLista().isEmpty()) { %>
	  <tr>	  	
	  	<td><label for="input">Seleccionar grado-turno</label></td>
	  	<td><label for="input">No hay grados para el año seleccionado</label></td>	  	
	  </tr>	  
	  <%}else{%>
	  <tr>
	      <td><label for="input">Seleccionar grado-turno</label></td>
	      <td>
	        <div class="col-xs-5">
	      	<select class="form-control" name="grado_anio" autofocus>
	      	<%for (Grado g : grados.getLista()) { %>	            
	            <option value="<%=g.getGrado() + " - " + g.getTurno()%>"><%=g.getGrado() + " - " + g.getTurno()%></option>            
	          
	      	<%}%>
	      	</select>
	      	</div>
	      </td>
	    </tr>
	    <tr>
			<th>
				<label for="input">Fecha:</label>
			</th>			
			<td>
				<div class="col-xs-2">
					<input class="form-control" type="text" id="datepicker" required name="fecha_asistencia">
				</div>
			</td>			
	    </tr>
	   <%}%>
	<%}%>   
	        
	  </table>  	
		<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave">Aceptar</button>
		<button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave">Cancelar</button>		
 </form>
 --> 
  

 	<%if(añoAsistencia == null){ %>

	    <label class="control-label" for="input">Seleccionar año:</label>  
	     
	    <br>
		<br>

	      <div class="row">
         	   <div class="col-xs-3">
            	    <div class="input-group">
            	         <span class="input-group-btn">
                	        <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnAcept">Buscar</button>
               	    	 </span>
                 	   <select class="form-control" name="año_asistencia" autofocus>
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
                	        <button type="button" disabled="disabled" class="btn btn-primary"  value="Aceptar" name="btnAcept">Buscar</button>
               	    	 </span>
 					 		<input class="form-control" type="text" size=4 readonly name="anio" value="<%=añoAsistencia%>"> 			
               		</div>
           	 	</div>
      	 </div>
		<br>
		<br>		
	
	  <%if (grados.getLista().isEmpty()) { %>	
	  	
	  	<br>

    	 <div class="alert alert-info fade in" role="alert">
	     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	     	 <strong>Atención!</strong> No hay grados para el año seleccionado. <a href="menu_asistencias.jsp" class="alert-link">Seleccionar otro año</a>
  	 	 </div>  	

	  <%}else{%>

	      <label class="control-label" for="input">Fecha:</label>
	         	
	   	  <br>
		  <br>
		  
		   <div class="row">
         	   <div class="col-xs-2">
            	    <div class="input-group">
 					 		 <input class="form-control" type="text" id="datepicker" required autofocus name="fecha_asistencia"> 			
               		</div>
           	 	</div>
      	  </div>
	      	
      	 <br>
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
                 	   <select class="form-control" name="grado_anio">
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
		 <br>
		 </form> 
		
		 <form action="menu_asistencias.jsp">
		 	<div class="form-group">
				<input class="btn btn-primary" type="submit" value="Seleccionar otro año">
			</div>
		 </form>	

	   <%}%>
	<%}%> 
  
 <br>
 <br>
 <%if(añoAsistencia != null){ %>		
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