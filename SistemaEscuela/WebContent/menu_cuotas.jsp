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
	
	Integer a�oCuota = null;
	Grados grados = null;
			
	if (request.getAttribute("a�oCuota") != null){
		
		//System.out.println((Integer) request.getAttribute("a�oCuota"));
		a�oCuota = (Integer) request.getAttribute("a�oCuota");
		session.setAttribute("a�oPlan", a�oCuota);		
				
		grados = (Grados) request.getAttribute("gradosCuota");
		session.setAttribute("gradosPlan", grados);
	
	}
	
	if(session.getAttribute("a�oMenuCuota")!= null){		
		
		a�oCuota = (Integer) session.getAttribute("a�oMenuCuota");
		grados = (Grados) session.getAttribute("gradosMenuCuota");
		
		session.removeAttribute("a�oMenuCuota");
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
	a�oCuota = (Integer) session.getAttribute("a�oCuota");
	session.setAttribute("a�oPlan", a�oCuota);	
				
	grados = (Grados) session.getAttribute("gradosCuota");
	*/
	
	
%>
<title>Men� Cobro de Cuotas</title>
</head>
<body>
	<center>
	<h1>Men� Cobro de Cuotas</h1>	
	<form action="CuotaList" method="get">
	<table>
	<%if(a�oCuota == null){ %>
	  <tr>
	    <th>Seleccionar a�o:</th>	    
	    <td><select name="a�o_cuotas">
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
	    <th>Seleccionar a�o:</th>	    
	     <td>
	     	<input type="text" size=4 readonly name="anio" value="<%=a�oCuota%>">
	     </td> 
	  </tr>
	  <%if (grados.getLista().isEmpty()) { %>
	  <tr>
	  	<th>Seleccionar grado-a�o:</th>
	  	<td>No hay grados para el a�o seleccionado</td>
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
	<%if(a�oCuota == null){ %>
	<form action="menu_admin.jsp">
	  <input type="submit" value="Volver al Men� Principal">
	</form>
	<%}else{ %>	
	<a href="pagos_dia.jsp">Ver Total de Pagos por d�a</a>
	<br>
	<br>	
	<table>
		<tr>
		<td><form action="menu_cuotas.jsp"> <input type="submit" value="Seleccionar otro a�o"> </form></td>
		<td><form action="menu_admin.jsp"> <input type="submit" value="Volver al Men� Principal"> </form></td>
		</tr>
	</table>
	<%}%>
	<br>
	<br>
	<form action="CerrarSesion">
	  <input type="submit" value="Cerrar Sesi�n">
	</form>
	</center>
	<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>