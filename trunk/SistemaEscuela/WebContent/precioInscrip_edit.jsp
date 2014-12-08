<%@page import="datos.PrecioInscrip"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMensaje"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "cuotas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Precios Inscripciones</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<!--<link rel="stylesheet" href="style/jquery-ui.css">  con ese no se ven las flechitas-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">

</head>
<body>
<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>
  
<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "precioInscrip_edit.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
	
	
	int año = 0;
	
	PrecioInscrip precio = (PrecioInscrip)session.getAttribute("precioInscrip");
	año = (Integer) session.getAttribute("añoPrecios");
	
    %>
    
   <div class="page-header">
   <%if (precio == null){%>
		
	<h1>Ingreso de Precios - Inscripción <%=año%></h1>
	
<%}else{%>
	  
	<h1>Modificación de Precios - Inscripción <%=año%></h1>
			
<%}%> 
	</div>
	
	<div class="form-group">
	    
    <form action="PrecioEdit" method="post" id="formPrecio" onsubmit="return validarPrecio()">
    <input name="fecha" id="fecha" type="hidden" value="<%=precio!=null?precio.getFecha_max() :"0"%>">
    
      <table class="table table-hover table-bordered">
		<tr>
			<th><label for="input">Fecha:</label></th>			
			<td>
			<div class="col-xs-2">
			<input class="form-control" type="text" id="datepicker" required autofocus name="fecha_inscrip">
			</div>
			</td>			
	    </tr>
		<tr>
          <th>Precio:</th>          
          <td>
          <div class="col-xs-3">
          	<input type="text" class="form-control" required placeholder="Precio Regular" name="regular" value="<%=precio!=null?precio.getPrecio():"" %>">
		   </div>          	
          </td>
          
        </tr>
        
        <tr>
          <th>Recargo:</th>
          <td>
          <div class="col-xs-3">
          <input type="text" class="form-control" required placeholder="Recargo" name="recargo" value="<%=precio!=null?precio.getRecargo():""%>">
          </div>
          </td>
        </tr>        
      </table>      
      <button type="submit" class="btn btn-primary" onclick=<%=AccionesMensaje.getOne(1).getMensaje()%>><i class="glyphicon glyphicon-floppy-disk"></i> Guardar</button>
	  <button type="reset" class="btn btn-primary"  onclick=<%=AccionesMensaje.getOne(3).getMensaje()%>><i class="glyphicon glyphicon-floppy-disk"></i> Cancelar</button>
    </form>
    </div>    
    <br>
    <br>    
  	<div class="form-group">
		 <form action="PrecioList" method="get">
			<button type="submit" class="btn btn-primary"  value="Volver al Menú de Precios">Volver al Menú de Precios</button>
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

	<!-- menú superior -->
	<script src="js/menu_admin.js"></script>	
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/entrevista.js"></script> <!-- DatePic para entrevistas -->
</body>
</html>