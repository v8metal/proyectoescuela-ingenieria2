<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="conexion.AccionesCuota"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesAlumno"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>			
<head>
<%session.setAttribute("modulo", "cuotas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Menú de Cuotas</title>

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
	if (AccionesUsuario.validarAcceso(tipo, "menu_cuotas.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
	
	Integer añoCuota = null;
	Grados grados = null;
			
	if (request.getAttribute("añoCuota") != null){
		
		añoCuota = (Integer) request.getAttribute("añoCuota");
		session.setAttribute("añoPlan", añoCuota);		
				
		grados = (Grados) request.getAttribute("gradosCuota");
		session.setAttribute("gradosPlan", grados);
	
	}
	
	if(session.getAttribute("añoMenuCuota")!= null){		
		
		añoCuota = (Integer) session.getAttribute("añoMenuCuota");
		grados = (Grados) session.getAttribute("gradosMenuCuota");
		
		session.removeAttribute("añoMenuCuota");
		session.removeAttribute("gradosMenuCuota");
	}
	
	int min = AccionesAlumno.getAñoAlumnos("MIN");
	int max = AccionesAlumno.getAñoAlumnos("MAX");
%>
	<div class="page-header">  	  
		<h1>Menú Cobro de Cuotas</h1>		
    </div>
    
    <div class="form-group">
	<form class="form-horizontal" action="CuotaList" method="get" role="form">		
	<%if(añoCuota == null){ %>
		 <input type="hidden" name="accion" value="solicitarGrados">
		 
		 <label class="control-label" for="input">Seleccionar año:</label>		 	     
	     <br>
		 <br>
	      <div class="row">
         	   <div class="col-xs-3">
            	    <div class="input-group">
            	         <span class="input-group-btn">
                	        <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnAcept"><i class="glyphicon glyphicon-search"></i> Buscar</button>
               	    	 </span>
                 	   <select class="form-control" name="año_cuotas" autofocus>
  							 <%  			
								int año = (Integer)session.getAttribute("añoc");
  							  
  								for(int i=max; i>=min;i--){
  							%> 							  	 
 							  <option <%if(i==año){%> selected <%}else{%><%}%>value="<%=i %>"><%=i %></option>		 	
   							<%
   								}							 		
							 %>   			 		
 					 	</select>					
               		</div>
           	 	</div>
      	 </div>	   	  
	     	
	     	<br>

	<%}else{ %>

		<label for="input">Seleccionar año:</label>    
			    <div class="row">
         	   <div class="col-xs-3">
            	    <div class="input-group">
            	         <span class="input-group-btn">
                	        <button type="button" disabled="disabled" class="btn btn-primary"  value="Aceptar" name="btnAcept"><i class="glyphicon glyphicon-search"></i> Buscar</button>
               	    	 </span>
 					 		<input class="form-control" type="text" size=4 readonly name="año_cuotas" value="<%=añoCuota%>"> 			
               		</div>
           	 	</div>
      	 </div>	     	

	  <%if (grados.getLista().isEmpty()) { %>	
	  	
	  	<br>

    	 <div class="alert alert-info fade in" role="alert">
	     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	     	 <strong>Atención!</strong> No hay grados para el año seleccionado. <a href="menu_cuotas.jsp" class="alert-link">Seleccionar otro año</a>
  	 	 </div>  	

	  <%}else{%>
	     
		 <br>
		 <input type="hidden" name="accion" value="listarGrado">		 
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
	  	</form>
	  	 
		<br>
		 <form action="menu_cuotas.jsp">
		 	<div class="form-group">
				<button type="submit" class="btn btn-primary"  value="Seleccionar otro año" name="btnAcept"><i class="glyphicon glyphicon-pushpin"></i> Seleccionar otro año</button>
			</div>
		 </form>	
		   <%}%>
	<%}%> 
  	
	</div>
	<br>
	<br>	
	<%if(añoCuota != null){ %>

	<p><strong><a href="pagos_dia.jsp">Ver Total de Pagos por día</a></strong></p>
	
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