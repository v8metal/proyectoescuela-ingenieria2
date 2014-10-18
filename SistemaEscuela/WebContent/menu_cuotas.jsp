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
<title>Menú de Cuotas</title>
<link rel="stylesheet" href="style/bootstrap.min.css">
</head>
<body>
<div class="container">
<% 
if (session.getAttribute("admin") != null) {
	
	Integer añoCuota = null;
	Grados grados = null;
			
	if (request.getAttribute("añoCuota") != null){
		
		//System.out.println((Integer) request.getAttribute("añoCuota"));
		añoCuota = (Integer) request.getAttribute("añoCuota");
		session.setAttribute("añoPlan", añoCuota);		
				
		grados = (Grados) request.getAttribute("gradosCuota");
		session.setAttribute("gradosPlan", grados);
	
	}
	
	if(session.getAttribute("añoMenuCuota")!= null){		
		
		añoCuota = (Integer) session.getAttribute("añoMenuCuota");
		grados = (Grados) session.getAttribute("gradosMenuCuota");
		
		session.removeAttribute("añoMenuCuota");
		session.removeAttribute("gradosMenuCuota");
	}
	 
	/*
	if (request.getAttribute("gradosCuota") != null){
		System.out.println((Grados) request.getAttribute("gradosCuota"));
		grados = (Grados) request.getAttribute("gradosCuota");
		session.setAttribute("gradosPlan", grados);
	}
	
	*/
	
	/*
	añoCuota = (Integer) session.getAttribute("añoCuota");
	session.setAttribute("añoPlan", añoCuota);	
				
	grados = (Grados) session.getAttribute("gradosCuota");
	*/
	
	
%>
	<center>
	
	<div class="page-header">  	  
		<h1>Menú Cobro de Cuotas</h1>		
    </div>
    
    <div class="form-group">
	<form action="CuotaList" method="get">
	
	<table class="table table-hover table-bordered">
	
	<%if(añoCuota == null){ %>
	  <tr>
	    <td><label for="input">Seleccionar año:</label></td>	    
	    <td><select class="form-control" name="año_cuotas">
	      		<%
	      		    int año = (Integer)session.getAttribute("añoc");
	      			for(int i=año; i>año-20;i--){
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
	    <td><label for="input">Seleccionar año:</label></td>	    
	     <td>
	     	<input class="form-control" type="text" size=4 readonly name="anio" value="<%=añoCuota%>">
	     </td> 
	  </tr>
	  <%if (grados.getLista().isEmpty()) { %>
	  <tr>	  	
	  	<td><label for="input">Seleccionar grado-turno:</label></td>
	  	<td><label for="input">No hay grados para el año seleccionado</label></td>	  	
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
	     	<input type="hidden" name="accion" value="listarGrado">
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
	<%if(añoCuota == null){ %>
		
	<div class="form-group">
	<form action="menu_admin.jsp">
	<button type="submit" class="btn btn-primary"  value="Volver al Menú Principal">Volver al Menú Principal</button>
	</form>
	</div>

	<%}else{ %>	
	
	<a href="pagos_dia.jsp">Ver Total de Pagos por día</a>
	<br>
	<br>
		
	<table>
		<tr>
		<td><div class="form-group"> <form action="menu_cuotas.jsp"> <input class="btn btn-primary" type="submit" value="Seleccionar otro año"> </form></div></td>
		<td><div class="form-group"> <form action="menu_admin.jsp"> <input class="btn btn-primary" type="submit" value="Volver al Menú Principal"> </form></div></td>
		</tr>
	</table>
	
	<%}%>
	<br>
	<br>
		
	<div class="form-group">
	<form action="CerrarSesion">
	<button type="submit" class="btn btn-primary"  value="Cerrar Sesión">Cerrar Sesión</button>
	</form>
	</div>
	
	</center>
	<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</div>
</body>
</html>