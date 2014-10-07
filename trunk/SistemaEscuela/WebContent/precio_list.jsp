<%@page import="datos.PrecioMes"%>
<%@page import="datos.PreciosMes"%>
<%@page import="datos.PrecioInscrip"%>
<%@page import="datos.PreciosInscrip"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<%
	PreciosMes preciosMes = (PreciosMes) session.getAttribute("preciosMes");
 	PreciosInscrip preciosInscrip = (PreciosInscrip) session.getAttribute("preciosInscrip"); 
 	int año = (Integer) session.getAttribute("añoPrecios");
 %>
<title>Listado de Precios - Año <%=año%></title>
</head>
<body>
<center>
  <h1>Precios de Cuotas - <%=año%></h1>  
<% if (preciosMes == null || (preciosMes.getPrecios().size() == 0)){ %>
<a href="PrecioEdit?accion=altaMes">No hay precios asignados, dar de alta</a>
<%}else{%>
  <table border="2">
          <tr>
            <th>AÑO</th>
            <th>MES</th>
            <th>PRECIO REGULAR</th>
            <th>PRECIO DE GRUPO</th>
            <th>PRECIO DE HIJOS</th>
            <th>RECARGO</th>

          </tr>
          <%
          	for(PrecioMes precioM: preciosMes.getPrecios()){
          %>
            	<tr>
            	  <td><%=precioM.getAño() %></td>
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
            	    	  if(precioM.getMes()==i){
            	    		  %>
            	    		  <%=meses[i-1]%>
            	    		  <%
            	    	  }
            	      }
            	      %>
            	  </td>
            	  <td><%=precioM.getRegular() %></td>
            	  <td><%=precioM.getGrupo()%></td>
            	  <td><%=precioM.getHijos() %></td>
            	  <td><%=precioM.getRecargo() %></td>
            	  <td><a href="PrecioEdit?accion=modificarMes&&año=<%=precioM.getAño()%>&&mes=<%=precioM.getMes()%>">Modificar</a></td>
            	  <td><a href="PrecioEdit?accion=bajaMes&&año=<%=precioM.getAño() %>&&mes=<%=precioM.getMes() %>">Borrar</a>
            	</tr>
            	<% 
            }
            %>         
        </table>
	<br>	
   <%if (preciosMes.getPrecios().size() < 10){%>
	<br>
 	<a href="PrecioEdit?accion=altaMes">Alta de Cuota</a>
 	<%}%> 	
 
<%}%> 

	<h1>Precios de Inscripciones - <%=año%></h1>
<% if (preciosInscrip == null || (preciosInscrip.getPrecios().size() == 0)){ %>
	<a href="PrecioEdit?accion=altaInscrip">No hay precios asignados, dar de alta</a>
<%}else{%>  
  <table border="2">
          <tr>
            <th>AÑO</th>
            <th>FECHA MAXIMA</th>
            <th>PRECIO</th>
            <th>RECARGO</th>            
          </tr>
          <%
          	for(PrecioInscrip precioI: preciosInscrip.getPrecios()){
          %>
            	<tr>
            	  <td><%=precioI.getAño() %></td>            	
            	  <td><%=precioI.getFecha_max() %></td>
            	  <td><%=precioI.getPrecio() %></td>
            	  <td><%=precioI.getRecargo() %></td>            	  
            	  <td><a href="PrecioEdit?accion=modificarInscrip&&año=<%=precioI.getAño()%>">Modificar</a></td>
            	  <td><a href="PrecioEdit?accion=bajaInscrip&&año=<%=precioI.getAño() %>">Borrar</a>
            	</tr>
           <%}%>            	         
        </table>   
  <%}%>  
  <br>
  <br>
  <form action="CuotaList" method="get">
    <input name="accion" type="hidden" value="listarGrado">
    <input type="submit" value="Volver atrás">    
  </form>
  <br>
  <br>
  <form action="CerrarSesion" method="get">
    <input type="submit" value="Cerrar Sesión">
  </form>
  </center>
</body>
</html>