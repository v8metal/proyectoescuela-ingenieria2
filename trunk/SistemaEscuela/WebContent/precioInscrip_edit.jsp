<%@page import="datos.PrecioInscrip"%>
<%@page import="conexion.AccionesUsuario"%>
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
          	<input type="text" class="form-control" placeholder="Precio Regular" name="regular" value="<%=precio!=null?precio.getPrecio():"" %>">
		   </div>          	
          </td>
          
        </tr>
        
        <tr>
          <th>Recargo:</th>
          <td>
          <div class="col-xs-3">
          <input type="text" class="form-control" placeholder="Recargo" name="recargo" value="<%=precio!=null?precio.getRecargo():""%>">
          </div>
          </td>
        </tr>        
      </table>      
      <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnSave" onclick="return confirm('Esta seguro que desea guardar?');">Aceptar</button>
      <button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave" onclick="return confirm('Esta seguro que desea cancelar?');">Cancelar</button>         
      <input type="hidden" name="error" value="ERROR!!!">
    </form>
    </div>    
    <br>
    <br>    
  	<div class="form-group">
		 <form action="PrecioList" method="get">
			<button type="submit" class="btn btn-primary"  value="Volver al Menú de Precios">Volver al Menú de Precios</button>
		</form>
	</div>	 
  <%String error = (String)session.getAttribute("error");
    if(error!=null){ %>
    	<center><h3><%=error %></h3></center>
    	 <% 
    	 session.setAttribute("error", null);
    }
    %>    
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
	
	<script type="text/javascript">
 		var form = document.getElementById("formPrecio");
 
 		function validarPrecio(){
			 var año = form.año_inscrip.value;
			 var mes = form.mes_inscrip.value;
			 var dia = form.dia_inscrip.value;
			 var regular = form.regular.value;	 
			 var recargo = form.recargo.value;
	 
			 if(año=='' || mes=='' || dia=='' || regular=='' || recargo==''){
				 alert("Debe completar todos los campos");
				 return false;
			 }
			 else if(isNaN(regular)){
				 alert('Debe ingresar sólo números');
				 return false;
	 		}
			 else if(isNaN(recargo)){
				 alert('Debe ingresar sólo números');
				 return false;	
			 }else{
				 return true;
			 }
		}
	</script>
</body>
</html>