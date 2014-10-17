<%@page import="datos.PrecioInscrip"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Precios Inscripciones</title>
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<body>
<div class="container">
<%
if (session.getAttribute("login") != null) {
	
	int dia = 0;
	String mes = "";
	int a�o = 0;
	
	PrecioInscrip precio = (PrecioInscrip)session.getAttribute("precioInscrip");
	
    if (precio != null){
    	
    	String fecha = precio.getFecha_max();
		
		String[] fecha_ent = fecha.split ("-");		
		dia = Integer.parseInt(fecha_ent[fecha_ent.length - 1]);
		mes = fecha_ent[fecha_ent.length - 2];
		a�o = Integer.parseInt(fecha_ent[fecha_ent.length - 3]);
		
    }else{
    	
		dia = Integer.valueOf((String)session.getAttribute("dia_sys"));
		
		int mes_sys = Integer.valueOf((String) session.getAttribute("mes_sys"));
				
		if (mes_sys < 10){
			mes = "0" + mes_sys;	
		}else{
			mes = "" + mes_sys;
		}
    	
    	a�o = (Integer) session.getAttribute("a�oPrecios");
    }%>
    
   <div class="page-header">
   <%if (precio == null){%>
		
	<h1>Ingreso de Precios - Inscripci�n <%=a�o%></h1>
	
<%}else{%>
	  
	<h1>Modificaci�n de Precios - Inscripci�n <%=a�o%></h1>
			
<%}%> 
	</div>
	
	<div class="form-group">
	    
    <form action="PrecioEdit" method="post" id="formPrecio" onsubmit="return validarPrecio()">
    
      <table class="table table-hover table-bordered">
			<tr>
				<td>Fecha Maxima</td>				
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
				 <input readonly type="text" name="a�o_inscrip" value="<%=a�o%>"></td>
			</tr>
		<tr>
          <td>Precio:</td>
          <td><input type="text" class="form-control" placeholder="Precio Regular" name="regular" value="<%=precio!=null?precio.getPrecio():"" %>"></td>
        </tr>
        
        <tr>
          <td>Recargo</td>
          <td><input type="text" class="form-control" placeholder="Recargo" name="recargo" value="<%=precio!=null?precio.getRecargo():""%>"></td>
        </tr>
        <tr></tr>
        <tr>        
        <td></td>       
         <td>
         	 <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnSave" onclick="return confirm('Esta seguro que desea guardar?');">Aceptar</button>
         	 <button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave" onclick="return confirm('Esta seguro que desea cancelar?');">Cancelar</button>         
             <input type="hidden" name="error" value="ERROR!!!">
         </td>
       </tr>
      </table>
    </form>
    </div>    
    <br>
    <br>
    <center>
  	<div class="form-group">
		 <form action="PrecioList" method="get">
			<button type="submit" class="btn btn-primary"  value="Volver al Men� de Precios">Volver al Men� de Precios</button>
		</form>
	</div>
	</center>  
  <br>
  <br>
   <div class="form-group">
		<form action="CerrarSesion" method="get">
			<button type="submit" class="btn btn-primary"  value="Cerrar Sesi�n">Cerrar Sesi�n</button>
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
	 var a�o = form.a�o_inscrip.value;
	 var mes = form.mes_inscrip.value;
	 var dia = form.dia_inscrip.value;
	 var regular = form.regular.value;	 
	 var recargo = form.recargo.value;
	 
	 if(a�o=='' || mes=='' || dia=='' || regular=='' || recargo==''){
		 alert("Debe completar todos los campos");
		 return false;
	 }
	 
	 else if(isNaN(regular)){
		 alert('Debe ingresar s�lo n�meros');
		 return false;
	 }
	 else if(isNaN(recargo)){
		 alert('Debe ingresar s�lo n�meros');
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