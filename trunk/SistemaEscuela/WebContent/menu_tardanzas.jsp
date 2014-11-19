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
<%session.setAttribute("modulo", "tardanzas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Menú de Tardanzas</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

</head>
<body>
<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>

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
                	        <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnAcept"><i class="glyphicon glyphicon-search"></i> Buscar</button>
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
                	        <button type="button" disabled="disabled" class="btn btn-primary" value="Aceptar" name="btnAcept"><i class="glyphicon glyphicon-search"></i> Buscar</button>
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
                	        <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnAcept"><i class="glyphicon glyphicon-search"></i> Buscar</button>
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
		  		<button type="submit" class="btn btn-primary"  value="Seleccionar otro año"><i class="glyphicon glyphicon-pushpin"></i> Seleccionar otro año</button> 
		  	</div> 
	</form>
		  
		  
	   <%}%>
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
	<script src="js/menu_admin.js"></script> 
</body>
</html>