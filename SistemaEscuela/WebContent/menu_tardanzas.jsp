<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="conexion.AccionesCuota"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>			
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Men� de Tardanzas</title>
<link rel="stylesheet" href="style/bootstrap.min.css">
</head>
<body>
<div class="container">
<% 
if (session.getAttribute("admin") != null) {
	
	Integer a�oTardanza = null;
	Grados grados = null;
			
	if (request.getAttribute("a�oTardanza") != null){
		
		a�oTardanza = (Integer) request.getAttribute("a�oTardanza");				
		grados = (Grados) request.getAttribute("gradosTardanza");
		
		session.setAttribute("a�oTardanza", a�oTardanza);
		session.setAttribute("gradosTardanza", grados);		
	}
	
	if (request.getParameter("volver") != null){
		
		a�oTardanza = (Integer) session.getAttribute("a�oTardanza");				
		grados = (Grados) session.getAttribute("gradosTardanza");
		
		
	}
%>
	<center>
	
	<div class="page-header">  	  
		<h1>Men� de Tardanzas<h1>		
    </div>
    
    <div class="form-group">
	<form action="TardanzaList" method="get">
	
	<table class="table table-hover table-bordered">
	
	<%if(a�oTardanza == null){ %>
	  <tr>
	    <td><label for="input">Seleccionar a�o:</label></td>	    
	    <td><select class="form-control" name="a�o_tardanza">
	      		<%
	      		    int a�o = (Integer)session.getAttribute("a�oc");
	      			for(int i=a�o; i>a�o-20;i--){
	      		%>	
	      	  <option value="<%=i %>"><%=i %></option>
	      		<%
	      			}
	      		%>
	        </select>
	     </td>         	     
	     <td>
	     	<input type="hidden" name="accion" value="solicitarGrados">
	     </td> 	     
	  </tr>
	<%}else{ %>
	  <tr>
	    <td><label for="input">Seleccionar a�o:</label></td>	    
	     <td>
	     	<input class="form-control" type="text" size=4 readonly name="anio" value="<%=a�oTardanza%>">
	     </td> 
	  </tr>
	  <%if (grados.getLista().isEmpty()) { %>
	  <tr>	  	
	  	<td><label for="input">Seleccionar grado-turno:</label></td>
	  	<td><label for="input">No hay grados para el a�o seleccionado</label></td>	  	
	  </tr>	  
	  <%}else{%>
	  <tr>
	      <td><label for="input">Seleccionar grado-turno:</label></td>
	      <td>
	      	<select class="form-control" name="grado_anio">
	      	<%for (Grado g : grados.getLista()) { %>	            
	            <option value="<%=g.getGrado() + " - " + g.getTurno()%>"><%=g.getGrado() + " - " + g.getTurno()%></option>            
	          
	      	<%}%>
	      	</select>
	      </td>
	    </tr>
	   <%}%>
	<%}%>	    	      
	     <tr>
	      <td>
	     	<input type="hidden" name="accion" value="listarTardanzas">
	      </td>      
	    </tr>	        
	  </table>
	  
	  <center>
			<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave">Aceptar</button>
			<button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave">Cancelar</button>
		</center>
		
	</form>
	</div>	
	<br>
	<br>
	<%if(a�oTardanza == null){ %>
		
	<div class="form-group">
	<form action="menu_admin.jsp">
	<button type="submit" class="btn btn-primary"  value="Volver al Men� Principal">Volver al Men� Principal</button>
	</form>
	</div>

	<%}else{ %>	
	
		
	<table>
		<tr>
		<td><div class="form-group"> <form action="menu_tardanzas.jsp"> <input class="btn btn-primary" type="submit" value="Seleccionar otro a�o"> </form></div></td>
		<td><div class="form-group"> <form action="menu_admin.jsp"> <input class="btn btn-primary" type="submit" value="Volver al Men� Principal"> </form></div></td>
		</tr>
	</table>
	
	<%}%>
	<br>
	<br>
		
	</center>
	<div class="form-group">
	<form action="CerrarSesion">
	<button type="submit" class="btn btn-primary"  value="Cerrar Sesi�n">Cerrar Sesi�n</button>
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