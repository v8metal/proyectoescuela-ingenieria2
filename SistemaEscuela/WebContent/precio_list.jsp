<%@page import="datos.PrecioMes"%>
<%@page import="datos.PreciosMes"%>
<%@page import="datos.PrecioInscrip"%>
<%@page import="datos.PreciosInscrip"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0">
<link rel="stylesheet" href="style/bootstrap.min.css">

<%
if (session.getAttribute("login") != null) {
	
	PreciosMes preciosMes = (PreciosMes) session.getAttribute("preciosMes");
 	PreciosInscrip preciosInscrip = (PreciosInscrip) session.getAttribute("preciosInscrip"); 
 	int año = (Integer) session.getAttribute("añoPrecios");
 %>
<title>Listado de Precios - Año <%=año%></title>
</head>
<body>
<div class="container">
<center>
	<div class="page-header">  	  
		<h1>Precios de Cuotas - <%=año%></h1>		
    </div>    
<% if (preciosMes == null || (preciosMes.getPrecios().size() == 0)){ %>
<a href="PrecioEdit?accion=altaMes">No hay precios asignados, dar de alta</a>
<%}else{%>
  <table class="table table-hover">
          <tr>
            <td>AÑO</td>
            <td>MES</td>
            <td>PRECIO REGULAR</td>
            <td>PRECIO DE GRUPO</td>
            <td>PRECIO DE HIJOS</td>
            <td>RECARGO</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>     
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
            	  <td><a href="PrecioEdit?accion=bajaMes&&año=<%=precioM.getAño() %>&&mes=<%=precioM.getMes() %>" onclick="return confirm('Esta seguro que desea borrar?');">Borrar</a>
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
	<div class="page-header">  	  
		<h1>Precios de Inscripciones - <%=año%></h1>		
    </div>   	
<% if (preciosInscrip == null || (preciosInscrip.getPrecios().size() == 0)){ %>
	<a href="PrecioEdit?accion=altaInscrip">No hay precios asignados, dar de alta</a>
<%}else{%>  
  <table class="table table-hover">
          <tr>
            <td>AÑO</td>
            <td>FECHA MAXIMA</td>
            <td>PRECIO</td>
            <td>RECARGO</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>            
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
            	  <td><a href="PrecioEdit?accion=bajaInscrip&&año=<%=precioI.getAño() %>" onclick="return confirm('Esta seguro que desea borrar?');">Borrar</a>
            	</tr>
           <%}%>            	         
        </table>   
  <%}%>  
  <br>
  <br>  
  <div class="form-group">
	<form action="CuotaList" method="get">
	<input name="accion" type="hidden" value="listarGrado">
	<button type="submit" class="btn btn-primary"  value="Volver atrás">Volver atrás</button>
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
  
   <%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</div>
</body>
</html>