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
%>
	<div class="page-header">  	  
		<h1>Menú Cobro de Cuotas</h1>		
    </div>
    
    
	<form class="form-horizontal" action="CuotaList" method="get" role="form">
		<div class="form-group">
	<%if(añoCuota == null){ %>
		
		 <label class="control-label col-sm-2" for="input">Seleccionar año:</label>
		  <div class="col-xs-2">          
	    	<select class="form-control" name="año_cuotas" autofocus>
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
	     	<input type="hidden" name="accion" value="solicitarGrados">
	     	<br>

	<%}else{ %>

		<label for="input">Seleccionar año:</label>    

	     	<input class="form-control" type="text" size=4 readonly name="anio" value="<%=añoCuota%>">


	  <%if (grados.getLista().isEmpty()) { %>
	
		<label for="input">Seleccionar grado-turno:</label>
		<label for="input">No hay grados para el año seleccionado</label>

	  <%}else{%>

	     <label for="input">Seleccionar grado-turno:</label>
	    
	      	<select class="form-control" name="grado_anio" autofocus>
	      	<%for (Grado g : grados.getLista()) { %>	            
	            <option value="<%=g.getGrado() + " - " + g.getTurno()%>"><%=g.getGrado() + " - " + g.getTurno()%></option>            
	          
	      	<%}%>
	      	</select>
	   <%}%>
	<%}%>	    	      
	<br>
	     	<input type="hidden" name="accion" value="listarGrado">
	  
			<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave">Aceptar</button>
			<button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave">Cancelar</button>
			
	</form>
	
	<br>
	<br>
	
	<p><strong><a href="pagos_dia.jsp">Ver Total de Pagos por día</a></strong></p>
	
	<%if(añoCuota == null){ %>

<!-- 		
	<div class="form-group">
	<form action="menu_admin.jsp">
	<button type="submit" class="btn btn-primary"  value="Volver al Menú Principal">Volver al Menú Principal</button>
	</form>
	</div>
 -->
 
	<%}else{ %>	
	
	<br>
	<br>
	<br>
	<br>
		
				
	<form action="menu_cuotas.jsp">
		<div class="form-group">
			<input class="btn btn-primary" type="submit" value="Seleccionar otro año">
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
	<script src="js/menu_admin.js"></script> 
</body>
</html>