<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="conexion.AccionesCuota"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMaestro"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>			
<head>
<%session.setAttribute("modulo", "notas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Menú de Notas</title>

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
	
	int dni = (Integer) session.getAttribute("dni_maestro");

	int min = AccionesMaestro.getAñoMaestro("MIN", dni);
	int max = AccionesMaestro.getAñoMaestro("MAX", dni);
	
	int tipo = (Integer) session.getAttribute("tipoUsuario");
	if (AccionesUsuario.validarAcceso(tipo, "menu_notas.jsp") != 1){							
		response.sendRedirect("Login");						
	}
	
	Integer añoNotas = null;
	Grados grados = null;
			
	if (request.getAttribute("añoNotas") != null){
		
		añoNotas = (Integer) request.getAttribute("añoNotas");				
		grados = (Grados) request.getAttribute("gradosNotas");
		
		session.setAttribute("añoNotas", añoNotas);
		session.setAttribute("gradosNotas", grados);		
	}
	
	if (request.getParameter("volver") != null){
		
		añoNotas = (Integer) session.getAttribute("añoNotas");				
		grados = (Grados) session.getAttribute("gradosNotas");
		
		
	}
%>
	<div class="page-header">  	  
		<h1>Menú de Notas</h1>		
    </div>
 
 	<form action="NotaEdit" method="get">
    <input type="hidden" name="accion" value="<%=añoNotas!=null?"listarGrado":"solicitarGrados"%>">
    	
 	<%if(añoNotas == null){ %>

	    <label class="control-label" for="input">Seleccionar año:</label> 
	    
 		<br>
		<br>
	        
	     <div class="row">
         	   <div class="col-xs-3">
            	    <div class="input-group">
            	         <span class="input-group-btn">
                	        <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnAcept"><i class="glyphicon glyphicon-search"></i> Buscar</button>
               	    	 </span>
                 	   <select class="form-control" name="año_notas" autofocus>
  							 
  							 <%for(int i=max; i >= min;i--){%>  							 	
 							  <option value="<%=i %>"><%=i %></option>		 	
   							<%}%>   			 		
 					 	</select>					
               		</div>
           	 	</div>
      	 </div>	  
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
 					 		<input class="form-control" type="text" readonly name="anio" value="<%=añoNotas%>">			
               		</div>
           	 	</div>
      	 </div>
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
                 	   <select class="form-control" name="grado_turno" autofocus>
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
 	</form> 	
    <br>
    <br> 	
 	<form action="menu_notas.jsp">
		  	<div class="form-group">
		  		<button type="submit" class="btn btn-primary"  value="Seleccionar otro año"><i class="glyphicon glyphicon-pushpin"></i> Seleccionar otro año</button> 
		  	</div> 
	</form>	   
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
</body>
</html>