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
%>
	<div class="page-header">  	  
		<h1>Men� Cobro de Cuotas</h1>		
    </div>
    
    
	<form class="form-horizontal" action="CuotaList" method="get" role="form">
		<div class="form-group">
	<%if(a�oCuota == null){ %>
		
		 <label class="control-label col-sm-2" for="input">Seleccionar a�o:</label>
		  <div class="col-xs-2">          
	    	<select class="form-control" name="a�o_cuotas" autofocus>
	      		<%
	      		    int a�o = (Integer)session.getAttribute("a�oc");
	      			for(int i=a�o; i>a�o-20;i--){
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

		<label for="input">Seleccionar a�o:</label>    

	     	<input class="form-control" type="text" size=4 readonly name="anio" value="<%=a�oCuota%>">


	  <%if (grados.getLista().isEmpty()) { %>
	
		<label for="input">Seleccionar grado-turno:</label>
		<label for="input">No hay grados para el a�o seleccionado</label>

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
	
	<p><strong><a href="pagos_dia.jsp">Ver Total de Pagos por d�a</a></strong></p>
	
	<%if(a�oCuota == null){ %>

<!-- 		
	<div class="form-group">
	<form action="menu_admin.jsp">
	<button type="submit" class="btn btn-primary"  value="Volver al Men� Principal">Volver al Men� Principal</button>
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
			<input class="btn btn-primary" type="submit" value="Seleccionar otro a�o">
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

	<!-- men� superior -->
	<script src="js/menu_admin.js"></script> 
</body>
</html>