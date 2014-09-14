<%@page import="datos.Precio"%>
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
	Precio precio = (Precio)request.getAttribute("precio");
%>
	<center>
    <h1>Ingreso de Precios</h1>
    <form action="PrecioEdit" method="post" id="formPrecio" onsubmit="return validarPrecio()">
      <table>
      <%
      	if(precio==null){
      %>
        <tr>
          <th>Año</th>
          <td><select name="año">
                <%
                  if(precio!=null){
                	  for(int i=2501; i>=precio.getAño();i--){
                		  if(i==precio.getAño()){
                		  %>
                          <option value="<%=i %>" selected><%=i %></option>
                          <%
                		  }else{
                			  %>
                			  <option value="<%=i %>" selected><%=i %></option>
                			  <%
                		  }
                            		
                	  }
                  }else{
                	      int año = (Integer)session.getAttribute("año");
                		  for(int i=2501; i>=año;i--){
                    		  if(i==año){
                    			  %>
                    			  <option value="<%=i %>" selected><%=i %></option>
                    			  <%
                    		  }else{
                    			  %>
                    			  <option value="<%=i %>"><%=i %></option>
                    			  <% 
                    		  }
                            }	
                	  }
                %>
              </select>
        </tr>
        <%
      	}
          if(precio!=null){
        	  int mes = (Integer)session.getAttribute("mes");
        	  String meses [] = new String[12];
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
          <th>Mes:</th>
          <td>
            <input type="text" readonly value="<%=meses[mes]%>" name="mes">
          </td>
        	  <%
          }
        %>
        <tr>
          <th>Precio Regular:</th>
          <td><input type="text" name="prec_reg" value="<%=precio!=null?precio.getPrec_reg():"" %>"></td>
        </tr>
        <tr>
          <th>Precio de Grupo:</th>
          <td><input type="text" name="prec_grupo" value="<%=precio!=null?precio.getPrec_grupo():""%>"></td>
        </tr>
        <tr>
          <th>Reinscripción Anticipada:</th>
          <td><input type="text" name="reinsc_ant" value="<%=precio!=null?precio.getReinsc_ant():""%>"></td>
        </tr>
        <tr>
          <th>Reinscripción:</th>
          <td><input type="text" name="reinsc" value="<%=precio!=null?precio.getReinsc():""%>"></td>
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
     <form action="menu_precios.jsp" method="get">
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
	 var año = form.año.value;
	 var mes = form.mes.value;
	 var prec_reg = form.prec_reg.value;
	 var prec_grupo = form.prec_grupo.value;
	 var reinsc_ant=form.reinsc_ant.value;
	 var reinsc = form.reinsc.value;
	 
	 if(año=='' || mes=='' || prec_reg=='' || prec_grupo=='' || reinsc_ant=='' || reinsc==''){
		 alert("Debe completar todos los campos");
		 return false;
	 }
	 
	 else if(isNaN(prec_reg)){
		 alert('Debe ingresar sólo números');
		 return false;
	 }
	 else if(isNaN(prec_grupo)){
		 alert('Debe ingresar sólo números');
		 return false;
		 }
	 else if(isNaN(reinsc_ant)){
		 alert('Debe ingresar sólo números');
		 return false;
	 }
	 else if(isNaN(reinsc)){
		 alert('Debe ingresar sólo números');
		 return false;
	 }else{
		 return true;
	 }
	 }
 
	</script> 
	
</body>
</html>