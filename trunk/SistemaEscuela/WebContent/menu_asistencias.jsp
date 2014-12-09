<%@page import="datos.Maestro"%>
<%@page import="datos.Tardanza"%>
<%@page import="datos.Tardanza"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="datos.Mensaje"%>
<%@page import="conexion.AccionesTardanza"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMaestro"%>
<%@page import="conexion.AccionesMensaje"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>			
<head>
<%session.setAttribute("modulo", "asistencias");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Men� de Asistencias</title>

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
	
	Integer a�oAsistencia = null;
	Grados grados = null;
			
	if (request.getAttribute("a�oAsistencia") != null){
		
		a�oAsistencia = (Integer) request.getAttribute("a�oAsistencia");				
		grados = (Grados) request.getAttribute("gradosAsistencia");
		
		session.setAttribute("a�oAsistencia", a�oAsistencia);
		session.setAttribute("gradosAsistencia", grados);		
	}
	
	if (request.getParameter("volver") != null){
		
		a�oAsistencia = (Integer) session.getAttribute("a�oAsistencia");				
		grados = (Grados) session.getAttribute("gradosAsistencia");
		
		
	}

	int dni = (Integer) session.getAttribute("dni_maestro");
	int min = AccionesMaestro.getA�oMaestro("MIN", dni);
	int max = AccionesMaestro.getA�oMaestro("MAX", dni);
	
%>

  <div id="divmenu">
  	<!-- sirve para visualizar el men� superior -->
  </div>

	<div class="page-header">  	  
		<h1>Men� de Asistencias</h1>		
    </div>
    
    <%if(max == 0) {     
    	
		Mensaje m = AccionesMensaje.getOne(60);%>
	<div class="alert <%=m.getTipo() %>" role="alert">
	  <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <%=m.getMensaje()%>
    </div>
        
    <%}else{ %>
    
    <div class="form-group"> 
	<form action="AsistenciaList" method="get">

	<input name="a�o" id="a�o" type="hidden" value="<%=a�oAsistencia%>">
		
	<%if(a�oAsistencia == null){ %>
    	<input type="hidden" name="accion" value="solicitarGrados">
	<%}else{%>
	    <input name="fecha" id="fecha" type="hidden" value="0">
		<input type="hidden" name="accion" value="listarAsistencias">
	<%}%>

 	<%if(a�oAsistencia == null){ %>

	    <label class="control-label" for="input">Seleccionar a�o:</label>  
	     
	    <br>
		<br>

	      <div class="row">
         	   <div class="col-xs-3">
            	    <div class="input-group">
            	         <span class="input-group-btn">
                	        <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnAcept"><i class="glyphicon glyphicon-search"></i> Buscar</button>
               	    	 </span>
                 	   <select class="form-control" name="a�o_asistencia" autofocus>
  							 <%for(int i=max; i >= min;i--){%> 							 	
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

	    <label class="control-label" for="input">Seleccionar a�o:</label>
 		<br>
		<br>	         
	 
	    <div class="row">
         	   <div class="col-xs-3">
            	    <div class="input-group">
            	         <span class="input-group-btn">
                	        <button type="button" disabled="disabled" class="btn btn-primary"  value="Aceptar" name="btnAcept"><i class="glyphicon glyphicon-search"></i> Buscar</button>
               	    	 </span>
 					 		<input class="form-control" type="text" size=4 readonly name="anio" value="<%=a�oAsistencia%>"> 			
               		</div>
           	 	</div>
      	 </div>
		<br>
		<br>		
	
	  <%if (grados.getLista().isEmpty()) { %>	
	  	
	  	<br>

    	 <div class="alert alert-info fade in" role="alert">
	     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	     	 <strong><i class="glyphicon glyphicon-exclamation-sign"></i> Atenci�n!</strong> No hay grados para el a�o seleccionado. <a href="menu_asistencias.jsp" class="alert-link"> Seleccionar otro a�o <i class="glyphicon glyphicon-pushpin"></i></a>
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
				<button type="submit" class="btn btn-primary"  value="Seleccionar otro a�o"><i class="glyphicon glyphicon-pushpin"></i> Seleccionar otro a�o</button>
			</div>
		 </form>	

	   <%}%>
	<%}%> 
  
 <br>
 <br>
 <%if(a�oAsistencia != null){ %>		
<!-- 
	<form action="menu_asistencias.jsp">
		<div class="form-group">
			<input class="btn btn-primary" type="submit" value="Seleccionar otro a�o">
		</div>
	</form>	
 -->		
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
	<script src="js/menu_user.js"></script> 
	
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/asistencias.js"></script> <!-- DatePic para asistencias -->
</body>
</html>