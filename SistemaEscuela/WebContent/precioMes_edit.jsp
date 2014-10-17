<%@page import="datos.PrecioMes"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Precios Mensuales</title>
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<body>
<div class="container">
<%
if (session.getAttribute("login") != null) {


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
	<center>
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
            <input type="text" readonly value="<%=precio!=null?meses[precio.getMes()]:meses[2]%>" name="mes">
          <%}else{ %>
            <input type="text" readonly value="<%=precio!=null?meses[precio.getMes()-1]:meses[2]%>" name="mes">
          <%} %>
          </td>        
        <tr>
          <th>Precio Regular:</th>
          <td><input type="text" class="form-control" placeholder="Precio Regular" name="regular" value="<%=precio!=null?precio.getRegular():"" %>"></td>
        </tr>
        <tr>
          <th>Precio de Grupo:</th>
          <td><input type="text" class="form-control" placeholder="Precio Grupo" name="grupo" value="<%=precio!=null?precio.getGrupo():""%>"></td>
        </tr>
        <tr>
          <th>Precios de Hijos:</th>
          <td><input type="text" class="form-control" placeholder="Precio Hijos" name="hijos" value="<%=precio!=null?precio.getHijos():""%>"></td>
        </tr>
        <tr>
          <th>Recargo:</th>
          <td><input type="text" class="form-control" placeholder="Recargo Mensual" name="recargo" value="<%=precio!=null?precio.getRecargo():""%>"></td>
        </tr>
        <tr>
         <td></td>
         <td>
             <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnSave" onclick="return confirm('Esta seguro que desea guardar?');">Aceptar</button>         	 
             <button type="reset" class="btn btn-primary"   value="Cancelar" name="btnSave" onclick="return confirm('Esta seguro que desea cancelar?');">Cancelar</button>
             <input type="hidden" name="error" value="ERROR!!!">
         </td>
       </tr>
      </table>
    </form>
    </div>
    <br>
    <div class="form-group">
		<form action="PrecioList" method="get">
		<button type="submit" class="btn btn-primary"  value="Volver al Menú de precios">Volver al Menú de precios</button>
		</form>
	</div>
	</center>
  <br>
  <br>  
  <div class="form-group">
		<form action="CerrarSesion" method="get">
		<button type="submit" class="btn btn-primary"  value="Cerrar Sesión">Cerrar Sesión</button>
		</form>
  </div>
  
  <%String error = (String)session.getAttribute("error");
    if(error!=null){
    	 %>
    	<center><h3><%=error %></h3></center>
    	 <% 
    	 session.setAttribute("error", null);
    }
    %>    
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
   <%
	} else {
		response.sendRedirect("login.jsp");
	}
%>	
</div>
</body>
</html>