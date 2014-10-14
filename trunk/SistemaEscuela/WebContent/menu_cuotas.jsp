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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<% 
if (session.getAttribute("login") != null) {
	
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
<title>Menú Cobro de Cuotas</title>
</head>
<body>
	<center>
	<h1>Menú Cobro de Cuotas</h1>	
	<form action="CuotaList" method="get">
	<table>
	<%if(añoCuota == null){ %>
	  <tr>
	    <th>Seleccionar año:</th>	    
	    <td><select name="año_cuotas">
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
	    <th>Seleccionar año:</th>	    
	     <td>
	     	<input type="text" size=4 readonly name="anio" value="<%=añoCuota%>">
	     </td> 
	  </tr>
	  <%if (grados.getLista().isEmpty()) { %>
	  <tr>
	  	<th>Seleccionar grado-año:</th>
	  	<td>No hay grados para el año seleccionado</td>
	  </tr>	  
	  <%}else{%>
	  <tr>
	      <th>Seleccionar grado-turno:</th>
	      <td>
	      	<select name="grado_anio">
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
	      <td><input type="submit" value="Aceptar">
	          <input type="reset" value="Cancelar">
	      </td>
	    </tr>	    
	  </table>
	</form>	
	<br>
	<br>
	<%if(añoCuota == null){ %>
	<form action="menu_admin.jsp">
	  <input type="submit" value="Volver al Menú Principal">
	</form>
	<%}else{ %>	
	<a href="pagos_dia.jsp">Ver Total de Pagos por día</a>
	<br>
	<br>	
	<table>
		<tr>
		<td><form action="menu_cuotas.jsp"> <input type="submit" value="Seleccionar otro año"> </form></td>
		<td><form action="menu_admin.jsp"> <input type="submit" value="Volver al Menú Principal"> </form></td>
		</tr>
	</table>
	<%}%>
	<br>
	<br>
	<form action="CerrarSesion">
	  <input type="submit" value="Cerrar Sesión">
	</form>
	</center>
	<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>