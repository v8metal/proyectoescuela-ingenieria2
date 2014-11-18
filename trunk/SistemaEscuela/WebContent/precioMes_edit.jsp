<%@page import="datos.PrecioMes"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "cuotas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Precios Mensuales</title>

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
	if (AccionesUsuario.validarAcceso(tipo, "precioMes_edit.jsp") != 1){							
	response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}

	PrecioMes precio = null;
	int ind = 0;
	int año =  (Integer) session.getAttribute("añoPrecios");
	
	if ((PrecioMes)session.getAttribute("ultimoMes") != null){
		precio = (PrecioMes)session.getAttribute("ultimoMes");
    }else{
    	ind = 1;
    	precio = (PrecioMes)session.getAttribute("mesModific");
    }
    
 %>
	<div class="page-header"> 		
	
<%if (ind == 0){%>

	<h1>Ingreso de Precios Mensuales - <%=año%></h1>
	
<%}else{%>
	  
	<h1>Modificación de Precios Mensuales - <%=año%></h1>
			
<%}%> 
	</div>
    
    <div class="form-group">
    <form action="PrecioEdit" method="post" id="formPrecio" onsubmit="return validarPrecio()">
      
      <table class="table table-hover table-bordered">

		<% 
	      String [] meses = new String[12];
	      meses[0]="Enero";
	      meses[1]="Febrero";
	      meses[2]="Marzo";
	      meses[3]="Abril";
	      meses[4]="Mayo";
	      meses[5]="Junio";
	      meses[6]="Julio";
	      meses[7]="Agosto";
	      meses[8]="Septiembre";
	      meses[9]="Octubre";
	      meses[10]="Noviembre";
	      meses[11]="Diciembre";
        	  %>
        	  
        <tr>
          <th>Mes Desde:</th>
          <td>
          <%if (ind == 0){ //controla si es un mes nuevo o no%>
          	<div class="col-xs-3">
            	<input type="text" class="form-control" readonly value="<%=precio!=null?meses[precio.getMes()]:meses[2]%>" name="mes">
            </div>	
          <%}else{ %>
          	<div class="col-xs-2">
            	<input type="text" class="form-control" readonly value="<%=precio!=null?meses[precio.getMes()-1]:meses[2]%>" name="mes">
            </div>	
          <%} %>
          </td>        
        <tr>
          <th>Precio Regular:</th>
          <td>
          	<div class="col-xs-2">
          		<input type="text" class="form-control" placeholder="Precio Regular" name="regular" value="<%=precio!=null?precio.getRegular():"" %>">
         	</div>
          </td>
        </tr>
        <tr>
          <th>Precio de Grupo:</th>
          <td>
          	<div class="col-xs-2">
          		<input type="text" class="form-control" placeholder="Precio Grupo" name="grupo" value="<%=precio!=null?precio.getGrupo():""%>">
          	</div>
          </td>
        </tr>
        <tr>
          <th>Precios de Hijos:</th>
          <td>
          	<div class="col-xs-2">
          		<input type="text" class="form-control" placeholder="Precio Hijos" name="hijos" value="<%=precio!=null?precio.getHijos():""%>">
         	</div>
          </td>
        </tr>
        <tr>
          <th>Recargo:</th>
          <td>
          	<div class="col-xs-2">
          		<input type="text" class="form-control" placeholder="Recargo Mensual" name="recargo" value="<%=precio!=null?precio.getRecargo():""%>">
       		</div>
       	  </td>	
        </tr>        
      </table>
      	<button type="submit" class="btn btn-primary"  value="Aceptar" name="btnSave" onclick="return confirm('Esta seguro que desea guardar?');">Aceptar</button>         	 
        <button type="reset" class="btn btn-primary"   value="Cancelar" name="btnSave" onclick="return confirm('Esta seguro que desea cancelar?');">Cancelar</button>
        <input type="hidden" name="error" value="ERROR!!!">
    </form>
    </div>
    <br>
    <div class="form-group">
		<form action="PrecioList" method="get">
		<button type="submit" class="btn btn-primary"  value="Volver al Menú de precios">Volver al Menú de precios</button>
		</form>
	</div>
  <%String error = (String)session.getAttribute("error");
    if(error!=null){
    	 %>
    	<h3><%=error %></h3>
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
	
	<script type="text/javascript">
	 var form = document.getElementById("formPrecio");
 	 function validarPrecio(){
	// var año = form.año.value;
	 var mes = form.mes.value;
	 var regular = form.regular.value;
	 var grupo = form.grupo.value;
	 var hijos=form.hijos.value;
	 var recargo = form.recargo.value;
	 
	 if(año=='' || mes=='' || regular=='' || grupo=='' || hijos=='' || recargo==''){
		 alert("Debe completar todos los campos");
		 return false;
	 }
	 
	 else if(isNaN(regular)){
		 alert('Debe ingresar sólo números');
		 return false;
	 }
	 else if(isNaN(grupo)){
		 alert('Debe ingresar sólo números');
		 return false;
		 }
	 else if(isNaN(hijos)){
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