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
<%session.setAttribute("modulo", "cuotas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Men� de Cuotas</title>

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
	if (AccionesUsuario.validarAcceso(tipo, "menu_cuotas.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
	
	Integer a�oCuota = null;
	Grados grados = null;
			
	if (request.getAttribute("a�oCuota") != null){
		
		a�oCuota = (Integer) request.getAttribute("a�oCuota");
		session.setAttribute("a�oPlan", a�oCuota);		
				
		grados = (Grados) request.getAttribute("gradosCuota");
		session.setAttribute("gradosPlan", grados);
	
	}
	
	if(session.getAttribute("a�oMenuCuota")!= null){		
		
		a�oCuota = (Integer) session.getAttribute("a�oMenuCuota");
		grados = (Grados) session.getAttribute("gradosMenuCuota");
		
		session.removeAttribute("a�oMenuCuota");
		session.removeAttribute("gradosMenuCuota");
	}
	
	int min = AccionesAlumno.getA�oAlumnos("MIN");
	int max = AccionesAlumno.getA�oAlumnos("MAX");
%>
	<div class="page-header">  	  
		<h1>Men� Cobro de Cuotas</h1>		
    </div>
    
    <%if(max == 0) {     
    	
		Mensaje m = AccionesMensaje.getOne(60);%>
	<div class="alert <%=m.getTipo() %>" role="alert">
	  <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <%=m.getMensaje()%>
    </div>
        
    <%}else{ %>
    <div class="form-group">
	<form class="form-horizontal" action="CuotaList" method="get" role="form">		
	<%if(a�oCuota == null){ %>
		 <input type="hidden" name="accion" value="solicitarGrados">
		 
		 <label class="control-label" for="input">Seleccionar a�o:</label>		 	     
	     <br>
		 <br>
	      <div class="row">
         	   <div class="col-xs-3">
            	    <div class="input-group">
            	         <span class="input-group-btn">
                	        <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnAcept"><i class="glyphicon glyphicon-search"></i> Buscar</button>
               	    	 </span>
                 	   <select class="form-control" name="a�o_cuotas" autofocus>
  							 <%  			
								int a�o = (Integer)session.getAttribute("a�oc");
  							  
  								for(int i=max; i>=min;i--){
  							%> 							  	 
 							  <option <%if(i==a�o){%> selected <%}else{%><%}%>value="<%=i %>"><%=i %></option>		 	
   							<%
   								}							 		
							 %>   			 		
 					 	</select>					
               		</div>
           	 	</div>
      	 </div>	   	  
	     	
	     	<br>

	<%}else{ %>

		<label for="input">Seleccionar a�o:</label>    
			    <div class="row">
         	   <div class="col-xs-3">
            	    <div class="input-group">
            	         <span class="input-group-btn">
                	        <button type="button" disabled="disabled" class="btn btn-primary"  value="Aceptar" name="btnAcept"><i class="glyphicon glyphicon-search"></i> Buscar</button>
               	    	 </span>
 					 		<input class="form-control" type="text" size=4 readonly name="a�o_cuotas" value="<%=a�oCuota%>"> 			
               		</div>
           	 	</div>
      	 </div>	     	

	  <%if (grados.getLista().isEmpty()) { %>	
	  	
	  	<br>

    	 <div class="alert alert-info fade in" role="alert">
	     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	     	 <strong>Atenci�n!</strong> No hay grados para el a�o seleccionado. <a href="menu_cuotas.jsp" class="alert-link">Seleccionar otro a�o</a>
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
				<button type="submit" class="btn btn-primary"  value="Seleccionar otro a�o" name="btnAcept"><i class="glyphicon glyphicon-pushpin"></i> Seleccionar otro a�o</button>
			</div>
		 </form>	
		   <%}%>
	<%}%> 
  	
	</div>
	<br>
	<br>	
	<%if(a�oCuota != null){ %>

	<p><strong><a href="pagos_dia.jsp">Ver Total de Pagos por d�a</a></strong></p>
	
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