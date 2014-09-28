<%@page import="datos.PrecioMes"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Sistema Alumnado</title>
</head>
<body>
<%
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
    <h1>Ingreso de Precios Mensuales - <%=año%></h1>
    <form action="PrecioEdit" method="post" id="formPrecio" onsubmit="return validarPrecio()">
      <table>

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
          <td><input type="text" name="regular" value="<%=precio!=null?precio.getRegular():"" %>"></td>
        </tr>
        <tr>
          <th>Precio de Grupo:</th>
          <td><input type="text" name="grupo" value="<%=precio!=null?precio.getGrupo():""%>"></td>
        </tr>
        <tr>
          <th>Precios de Hijos:</th>
          <td><input type="text" name="hijos" value="<%=precio!=null?precio.getHijos():""%>"></td>
        </tr>
        <tr>
          <th>Recargo:</th>
          <td><input type="text" name="recargo" value="<%=precio!=null?precio.getRecargo():""%>"></td>
        </tr>
        <tr>
         <td></td>
         <td><input type="submit" value="Aceptar">
             <input type="reset" value="Cancelar">
             <input type="hidden" name="error" value="ERROR!!!">
         </td>
       </tr>
      </table>
    </form>
    <br>
     <form action="PrecioList" method="get">
    <input type="submit" value="Volver al Menú de Precios">
  </form>
  <br>
  <br>
  <form action="CerrarSesion" method="get">
  <input type="submit" value="Cerrar Sesión">
  </form>
  
  <%String error = (String)session.getAttribute("error");
    if(error!=null){
    	 %>
    	<center><h3><%=error %></h3></center>
    	 <% 
    	 session.setAttribute("error", null);
    }
    %>
  </center>
  
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