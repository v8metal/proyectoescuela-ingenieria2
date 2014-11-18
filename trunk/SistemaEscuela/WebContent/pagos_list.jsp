<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="datos.Alumno"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesCuota"%>
<%@page import="conexion.AccionesAlumno"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<% 
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "pagos_list.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}

   Cuotas cuotas = (Cuotas) session.getAttribute("pagosMes");//lo dejamos como session para poder utilizarlo
   int a�o = (Integer) session.getAttribute("a�o");
   int dni = (Integer) session.getAttribute("dni");
   int mes = (Integer) session.getAttribute("mes");   
%>			
<head>
<%session.setAttribute("modulo", "cuotas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de pagos</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

</head>
<body>
<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el men� superior -->
  </div>
  
  	<div class="page-header">  	  
		<h1>Listado de pagos</h1>		
    </div>

	<% Alumno a = AccionesAlumno.getOne(dni); %>
	<h3><%= a.getNombre() + " " + a.getApellido() + " - " + a�o + "- Mes " + mes%> </h3>
	<br>
	<% if (cuotas.getLista().isEmpty()) { %>
	
 	<br>
  	<br>
  	
	<div class="bs-example">
    	<div class="alert alert-danger" role="alert">
    	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <strong>Ups!</strong> No hay pagos cargados para este mes. <a href="pago_edit.jsp" class="alert-link">Agregar pagos</a>
    	</div>
    </div>	
	
	<%}else{%>	
	  <table class="table table-hover table-bordered">
	  <thead>
	  <tr class="active">	  	    
	    <th>FECHA</th>
	    <th>PAGO</th>
	    <th>OBSERVACIONES</th>
	    <th>&nbsp;</th>	    
	    <th>&nbsp;</th>	    	    
	  </tr>	
	  </thead>  
	  <% for (Cuota c : cuotas.getLista()) {
		  
	  	String fecha_pago = c.getFecha();		
		String[] fecha_ent = fecha_pago.split ("-");
				
		String dia_pago = fecha_ent[fecha_ent.length - 1];
		String mes_pago = fecha_ent[fecha_ent.length - 2];
		int a�o_pago = Integer.parseInt(fecha_ent[fecha_ent.length - 3]);
		%>
	  <tbody>
	  <tr>    
	  
	    <td><%= dia_pago + "/" + mes_pago + "/" + a�o_pago %></td>
	    <td><%="$" + c.getPago()%></td>
	    <td><%= c.getObservaciones() %></td>
	    <td><strong><a href="CuotaEdit?accion=modificarPago&&cod_pago=<%=c.getCod_pago()%>" > Modificar pago </a></strong></td>	  
	    <td><strong><a href="CuotaEdit?accion=borrarPago&&cod_pago=<%=c.getCod_pago()%>" onclick="return confirm('Esta seguro que desea borrar el pago?');"> Borrar pago </a></strong></td>	    
	  </tr>  
	  </tbody>
	  <%}%>
	  </table>
	  <br>
	  <strong><a href="pago_edit.jsp"> Agregar pago </a></strong>
	  <br>
	 <%}%>
	<br>
	<br>	
	<div class="form-group">
		<form action="CuotaList">
		<input name="accion" type="hidden" value="listarGrado">
		<button type="submit" class="btn btn-primary"  value="Volver al listado de Pagos">Volver al listado de Pagos</button>
		</form>
	</div>
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