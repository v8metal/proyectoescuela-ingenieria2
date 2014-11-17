<%@page import="datos.Maestro"%>
<%@page import="datos.Tardanza"%>
<%@page import="datos.Tardanza"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="conexion.AccionesTardanza"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesAlumno"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>			
<head>
<%session.setAttribute("modulo", "alumnos");%>
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

<!-- menú superior -->
<script src="js/menu_admin.js"></script> 

</head>
<body>
<% 

	int tipo = (Integer) session.getAttribute("tipoUsuario");

	if (AccionesUsuario.validarAcceso(tipo, "menu_alumnos.jsp") != 1){							
		response.sendRedirect("Login");
	}
	
	Integer añoAlumno = null;
	Grados grados = null;
	
	//session.removeAttribute("añoAlumno"); //para que funcione volver de "alumno_edit"
			
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
 
  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
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
  							  
  								for(int i= AccionesAlumno.getAñoAlumnos("MAX"); i>=AccionesAlumno.getAñoAlumnos("MIN");i--){
  							%> 							  	 
 							  <option <%if(i==año){%> selected <%}else{%><%}%>value="<%=i %>"><%=i %></option>		 	
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
		
		 <br>
		 <br>
	
		 </form> 
		
		 <form action="menu_alumnos.jsp">
		 	<div class="form-group">
				<input class="btn btn-primary" type="submit" value="Seleccionar otro año">
			</div>
		 </form>	
	</div>
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