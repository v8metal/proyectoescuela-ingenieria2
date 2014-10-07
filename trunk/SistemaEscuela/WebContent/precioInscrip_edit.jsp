<%@page import="datos.PrecioInscrip"%>
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
if (session.getAttribute("login") != null) {
	
	int dia = 0;
	String mes = "";
	int año = 0;
	
	PrecioInscrip precio = (PrecioInscrip)session.getAttribute("precioInscrip");
	
    if (precio != null){
    	
    	String fecha = precio.getFecha_max();
		
		String[] fecha_ent = fecha.split ("-");		
		dia = Integer.parseInt(fecha_ent[fecha_ent.length - 1]);
		mes = fecha_ent[fecha_ent.length - 2];
		año = Integer.parseInt(fecha_ent[fecha_ent.length - 3]);
		
    }else{
    	
		dia = Integer.valueOf((String)session.getAttribute("dia_sys"));
    	mes = "0" + (String) session.getAttribute("mes_sys");
    	año = (Integer) session.getAttribute("añoPrecios");
    }
%>
	<center>
    <h1>Ingreso de Precios - Inscripción <%=año%></h1>    
    <form action="PrecioEdit" method="post" id="formPrecio" onsubmit="return validarPrecio()">
      <table>

			<tr>
				<td>Fecha </td>				
				<td>
					<select name="dia_inscrip">   
					<%  
					for (int i = 1; i <= 31; i++){			  	
		 			%>
					 	<option <%=dia==i ? "selected" : ""%>><%=i%></option>		 	
		   			<%
					}	
					%>
		 			 </select>
		  			 <select name="mes_inscrip">
		  			 <option value="01" <%=mes.equals("01") ? "selected" : ""%>>Enero</option>
					 <option value="02" <%=mes.equals("02") ? "selected" : ""%>>Febrero</option>
					 <option value="03" <%=mes.equals("03") ? "selected" : ""%>>Marzo</option>
					 <option value="04" <%=mes.equals("04") ? "selected" : ""%>>Abril</option>
					 <option value="05" <%=mes.equals("05") ? "selected" : ""%>>Mayo</option>
					 <option value="06" <%=mes.equals("06") ? "selected" : ""%>>Junio</option>
					 <option value="07" <%=mes.equals("07") ? "selected" : ""%>>Julio</option>
					 <option value="08" <%=mes.equals("08") ? "selected" : ""%>>Agosto</option>
					 <option value="09" <%=mes.equals("09") ? "selected" : ""%>>Septiembre</option>
					 <option value="10" <%=mes.equals("10") ? "selected" : ""%>>Octubre</option>
					 <option value="11" <%=mes.equals("11") ? "selected" : ""%>>Noviembre</option>
					 <option value="12" <%=mes.equals("12") ? "selected" : ""%>>Diciembre</option>	   			 		
		 			 </select>
		 		 </td>		 		 		 		 
				 <td><input readonly type="text" name="año_inscrip" value="<%=año%>"></td>
		<tr>
          <td>Precio:</td>
          <td><input type="text" name="regular" value="<%=precio!=null?precio.getPrecio():"" %>"></td>
        </tr>
        
        <tr>
          <td>Recargo</td>
          <td><input type="text" name="recargo" value="<%=precio!=null?precio.getRecargo():""%>"></td>
        </tr>
        <tr></tr>
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
    <br>
     <form action="PrecioList" method="get">
    <input type="submit" value="Volver al Menú de Precios">
  </form>  
  <br>
  <br>
  <form action="CerrarSesion" method="get">
  <input type="submit" value="Cerrar Sesión">
  </form>
  </center>
  
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
   <%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>