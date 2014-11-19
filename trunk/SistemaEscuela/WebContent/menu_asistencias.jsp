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
<%session.setAttribute("modulo", "asistencias");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Menú de Asistencias</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<!--<link rel="stylesheet" href="style/jquery-ui.css">  con ese no se ven las flechitas-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">

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

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>

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
                	        <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnAcept"><i class="glyphicon glyphicon-search"></i> Buscar</button>
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
                	        <button type="button" disabled="disabled" class="btn btn-primary"  value="Aceptar" name="btnAcept"><i class="glyphicon glyphicon-search"></i> Buscar</button>
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
	     	 <strong><i class="glyphicon glyphicon-exclamation-sign"></i> Atención!</strong> No hay grados para el año seleccionado. <a href="menu_asistencias.jsp" class="alert-link"> Seleccionar otro año <i class="glyphicon glyphicon-pushpin"></i></a>
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
                	        <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnAcept"><i class="glyphicon glyphicon-search"></i> Buscar</button>
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
		 </div>
		
		 <form action="menu_asistencias.jsp">
		 	<div class="form-group">
				<button type="submit" class="btn btn-primary"  value="Seleccionar otro año"><i class="glyphicon glyphicon-pushpin"></i> Seleccionar otro año</button>
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
	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

	<!-- menú superior -->
	<script src="js/menu_user.js"></script> 
	
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/asistencias.js"></script> <!-- DatePic para asistencias -->
</body>
</html>