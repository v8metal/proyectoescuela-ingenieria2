<%@page import="datos.Precio"%>
<%@page import="datos.Precios"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Insert title here</title>
</head>
<body>
<center>
  <h1>Precios de Cuotas/Reinscripciones</h1>
    <form action="PrecioList" method="post">
      <table>
        <tr>
          <th>Seleccionar año:</th>
          <td>
            <select name="año"><%
          		int año = (Integer)session.getAttribute("año");
                for(int i=año;i>año-20;i--){
                	%>
              <option value="<%=i %>"><%=i %></option>
                <% 
                }
          %>
            </select>
          </td>
        </tr>  
        <tr>
          <td></td>
          <td>
            <input type="submit" value="Aceptar">
            <input type="reset" value="Cancelar">
          </td>
        </tr>   
      </table>
    </form>
    <br>
    <br>
    <%
      if(session.getAttribute("list")!=null){
    	  %>
    	  <table border="2">
          <tr>
            <th>AÑO</th>
            <th>MES</th>
            <th>PRECIO REGULAR</th>
            <th>PRECIO DE GRUPO</th>
            <th>REINSCRIPCIÓN ANTICIPADA</th>
            <th>REINSCRIPCIÓN</th>
          </tr>
          <%
          	Precios precios= (Precios)session.getAttribute("precios");
            for(Precio precio: precios.getPrecios()){
            	
            	%>
            	<tr>
            	  <td><%=precio.getAño() %></td>
            	  <td><%
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
            	      for(int i=1;i<13;i++){
            	    	  if(precio.getMes()==i){
            	    		  %>
            	    		  <%=meses[i-1]%>
            	    		  <%
            	    	  }
            	      }
            	      %>
            	  </td>
            	  <td><%=precio.getPrec_reg() %></td>
            	  <td><%=precio.getPrec_grupo() %></td>
            	  <td><%=precio.getReinsc_ant() %></td>
            	  <td><%=precio.getReinsc() %></td>
            	  <td><a href="PrecioEdit?do=modificar&&modificar=modificar&&año=<%=precio.getAño()%>&&mes=<%=precio.getMes()%>">Modificar</a></td>
            	  <td><a href="PrecioEdit?do=baja&&año=<%=precio.getAño() %>&&mes=<%=precio.getMes() %>">Borrar</a>
            	</tr>
            	<% 
            }
            %>
         
        </table>
        <%
      }
    %>
   
  <br>
  <br>
  <form action="menu_precios.jsp" method="get">
    <input type="submit" value="Volver al Menú de Precios">
  </form>
  <br>
  <br>
  <form action="CerrarSesion" method="get">
    <input type="submit" value="Cerrar Sesión">
  </form>
  </center>
</body>
</html>