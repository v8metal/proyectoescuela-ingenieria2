<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="datos.Mensaje"%>
<%@page import="conexion.AccionesCuota"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesMensaje"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>			
<head>
<%session.setAttribute("modulo", "tardanzas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Men� de Tardanzas</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

</head>
<body>
<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el men� superior -->
  </div>

<% 
	int tipo = (Integer) session.getAttribute("tipoUsuario");
	if (AccionesUsuario.validarAcceso(tipo, "menu_tardanzas.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
	
	Integer a�oTardanza = null;
	Grados grados = null;
			
	if (request.getAttribute("a�oTardanza") != null){
		
		a�oTardanza = (Integer) request.getAttribute("a�oTardanza");				
		grados = (Grados) request.getAttribute("gradosTardanza");
		
		session.setAttribute("a�oTardanza", a�oTardanza);
		session.setAttribute("gradosTardanza", grados);		
	}
	
	if (request.getParameter("volver") != null){
		
		a�oTardanza = (Integer) session.getAttribute("a�oTardanza");				
		grados = (Grados) session.getAttribute("gradosTardanza");
		
		
	}
	
	int min = AccionesAlumno.getA�oAlumnos("MIN");
	int max = AccionesAlumno.getA�oAlumnos("MAX");
%>
	<div class="page-header">  	  
		<h1>Men� de Tardanzas</h1>		
    </div>
 
     <%if(max == 0) {     
    	
		Mensaje m = AccionesMensaje.getOne(60);%>
	<div class="alert <%=m.getTipo() %>" role="alert">
	  <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <%=m.getMensaje()%> <a href="alumno_edit.jsp?do=nuevo" class="alert-link"> Nuevo Alumno <i class="glyphicon glyphicon-edit"></i></a>
    </div>
        
    <%}else{ %>
    
 	<form action="TardanzaList" method="get">
 
 	<%if(a�oTardanza == null){ %>

	    <label class="control-label" for="input">Seleccionar a�o:</label> 
	    
 		<br>
		<br>
	        
	     <div class="row">
         	   <div class="col-xs-3">
            	    <div class="input-group">
            	         <span class="input-group-btn">
                	        <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnAcept"><i class="glyphicon glyphicon-search"></i> Buscar</button>
               	    	 </span>
                 	   <select class="form-control" name="a�o_tardanza" autofocus>
  							 <%
  							int a�o = (Integer)session.getAttribute("a�oc");
  							 for(int i=max; i>=min;i--){%>	
 							   <option <%if(i==a�o){%> selected <%}else{%><%}%>value="<%=i %>"><%=i %></option>		 	
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

	    <label class="control-label" for="input">Seleccionar a�o:</label> 
		<br>
		<br>
		    	
	    <div class="row">
         	   <div class="col-xs-3">
            	    <div class="input-group">
            	         <span class="input-group-btn">
                	        <button type="button" disabled="disabled" class="btn btn-primary" value="Aceptar" name="btnAcept"><i class="glyphicon glyphicon-search"></i> Buscar</button>
               	     	 </span>
 					 		<input class="form-control" type="text" readonly name="anio" value="<%=a�oTardanza%>">			
               		</div>
           	 	</div>
      	 </div>
		<br> 	

	  <%if (grados.getLista().isEmpty()) { %>  	
	  
		<br>
		<!-- MENSAJE INFORMATIVO -->
    	 <div class="alert alert-info fade in" role="alert">
	     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	     	 <strong>Atenci�n!</strong> No hay grados para el a�o seleccionado <a href="menu_tardanzas.jsp" class="alert-link">Seleccionar otro a�o</a>
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
		  		<button type="submit" class="btn btn-primary"  value="Seleccionar otro a�o"><i class="glyphicon glyphicon-pushpin"></i> Seleccionar otro a�o</button> 
		  	</div> 
	</form>
		  
		  
	   <%}%>
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

	<!-- men� superior -->
	<script src="js/menu_admin.js"></script> 
</body>
</html>