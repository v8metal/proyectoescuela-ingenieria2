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
<title>Men� de Alumnos</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<!--<link rel="stylesheet" href="style/jquery-ui.css">  con ese no se ven las flechitas-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="js/jquery-1.10.2.js"></script>
<script src="js/jquery-ui.js"></script>

<!-- men� superior -->
<script src="js/menu_admin.js"></script> 

</head>
<body>
<% 

	int tipo = (Integer) session.getAttribute("tipoUsuario");

	if (AccionesUsuario.validarAcceso(tipo, "menu_alumnos.jsp") != 1){							
		response.sendRedirect("Login");
	}
	
	Integer a�oAlumno = null;
	Grados grados = null;
	
	//session.removeAttribute("a�oAlumno"); //para que funcione volver de "alumno_edit"
			
	if (request.getAttribute("a�oAlumno") != null){
		
		a�oAlumno = (Integer) request.getAttribute("a�oAlumno");				
		grados = (Grados) request.getAttribute("gradosAlumno");
		
		session.setAttribute("a�oAlumno", a�oAlumno);
		session.setAttribute("gradosAlumno", grados);		
	}
	
	if (request.getParameter("volver") != null){
		
		a�oAlumno = (Integer) session.getAttribute("a�oAlumno");				
		grados = (Grados) session.getAttribute("gradosAlumno");
		
		
	}
	
%>

<div class="container">  
 
  <div id="divmenu">
  	<!-- sirve para visualizar el men� superior -->
  </div>
  
  	<div class="page-header">  	  
		<h1>Men� de Alumnos</h1>		
    </div>
    
    <div class="form-group">
 
	<form action="AlumnoList" method="get">

	<input name="a�o" id="a�o" type="hidden" value="<%=a�oAlumno%>">
		
	<%if(a�oAlumno == null){ %>
    	<input type="hidden" name="accion" value="solicitarGrados">
	<%}else{%>	    
		<input type="hidden" name="accion" value="listarAlumnos">
	<%}%>

	<%if(a�oAlumno == null){ %>

	    <label class="control-label" for="input">Seleccionar a�o:</label>  
	     
	    <br>
		<br>

	      <div class="row">
         	   <div class="col-xs-3">
            	    <div class="input-group">
            	         <span class="input-group-btn">
                	        <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnAcept">Buscar</button>
               	    	 </span>
                 	   <select class="form-control" name="a�o_alumno" autofocus>
  							 <%  			
								int a�o = (Integer)session.getAttribute("a�oc");
  							  
  								for(int i= AccionesAlumno.getA�oAlumnos("MAX"); i>=AccionesAlumno.getA�oAlumnos("MIN");i--){
  							%> 							  	 
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
                	        <button type="button" disabled="disabled" class="btn btn-primary"  value="Aceptar" name="btnAcept">Buscar</button>
               	    	 </span>
 					 		<input class="form-control" type="text" size=4 readonly name="anio" value="<%=a�oAlumno%>"> 			
               		</div>
           	 	</div>
      	 </div>
		<br>

	  <%if (grados.getLista().isEmpty()) { %>	
	  	
	  	<br>

    	 <div class="alert alert-info fade in" role="alert">
	     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	     	 <strong>Atenci�n!</strong> No hay grados para el a�o seleccionado. <a href="menu_alumnos.jsp" class="alert-link">Seleccionar otro a�o</a>
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
				<input class="btn btn-primary" type="submit" value="Seleccionar otro a�o">
			</div>
		 </form>	
	</div>
	   <%}%>
	<%}%> 
  
 <br>
 <br>
 <%if(a�oAlumno != null){ %>		
<!-- 
	<form action="menu_asistencias.jsp">
		<div class="form-group">
			<input class="btn btn-primary" type="submit" value="Seleccionar otro a�o">
		</div>
	</form>	
 -->		
<%}%>
</div>
</body>
</html>