<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@page import="datos.Grado"%>
<%@page import="conexion.AccionesGrado"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Grado</title>
</head>
<body>
<%
	if (session.getAttribute("login") != null) { 
  
  	Grado grado = (Grado)session.getAttribute("grado_edit");
    Maestros maestros = (Maestros) request.getAttribute("maestros_list");
  	Maestro titular = (Maestro)request.getAttribute("maestro_tit");
  	Maestro paralelo = (Maestro)request.getAttribute("maestro_par");
  	
  	int año; 
  	
  	if (grado != null){
  	 	año = AccionesGrado.getCurrentYear(grado.getGrado(), grado.getTurno());
  	}else{
  		//año = -1;
  		año = 0;
  	}

if (grado != null){
%>
<center><h1>MODIFICACION DE GRADO</h1></center>
<h2><%= grado.getGrado() + " - Turno " + grado.getTurno() %></h2>
<%}else{%>
<center><h1>ALTA DE GRADO</h1></center>
<%}%>
 <form action="GradoEdit" method="post">
<%if (grado != null){
   	if (maestros != null){%>
	<input type="hidden" name="action" value="update">
	<%}else{%>
	<input type="hidden" name="action" value="update">
	<%
	}
}else{%>
<input type="hidden" name="action" value="insert">
<%}%>
<table>
<% 
	if (grado == null){
%>
	<tr>
		<td>Grado: </td>
		<td>
			<select name="anio_grado">
			 <option value="Sala 4">Sala 4</option>
    		 <option value="Sala 5">Sala 5</option> 
  			 <option value="1ro">1º Grado</option>
    		 <option value="2do">2º Grado</option>
   			 <option value="3ro">3º Grado</option>
    		 <option value="4to">4º Grado</option>
    		 <option value="5to">5º Grado</option>
  			 <option value="6to">6º Grado</option>
    		 <option value="7mo">7º Grado</option>    		 	   		 
 			 </select> 
 		</td>
	</tr>
	<tr>
		<td>Turno: </td>
		<td>
			<select name="turno_grado">
			 <option value="MAÑANA">Mañana</option> 
     		 <option value="TARDE">Tarde</option>
 			</select> 
 		</td>
	</tr>
<%}%>	
	<tr>
		<td>Tipo de Calificación: </td>
		<td>
			<% 
			   String ck_bim = "";
			   String ck_tri = "";			   
			   
			   if (grado != null && grado.getBimestre()) {
				   ck_bim = "checked";
			   } else {
				   ck_tri = "checked";
			   }			           
			 	
			 %>
			<input type="radio" name="bimestral" value="si" <%=ck_bim%> /> Bimestral
			<input type="radio" name="bimestral" value="no" <%=ck_tri%>/> Trimestral
		</td>
	</tr>
	<tr>
		<td>Salón: </td>
		<td><input type="text" size=1 name="salon_grado" value="<%=grado!=null? grado.getSalon() : ""%>"></td>
	</tr>
	<tr>
		<td>Maestro Titular: </td>
<% if (año > 0){%>
		<td><select name="maestro_tit_grado">
		<% if (grado != null && titular != null){ %>
			<option value="<%= titular.getCod_maest()%>"><%=titular.getNombre()+ " " + titular.getApellido()%> </option>
			<%
			for (Maestro m : maestros.getLista()){
				
				if (m.getCod_maest() != titular.getCod_maest()){ //elimina el maestro titular duplicado de la lista
			 		
 			 %>   
 			  
   			   <option value="<%=m.getCod_maest()%>"><%=m.getNombre()+ " " + m.getApellido()%> </option>   			  
   			  <%   			
			 	}
			}
			
		}else{
			
			for (Maestro m : maestros.getLista()){			 		
 			%>   
 			  
   			   <option value="<%=m.getCod_maest()%>"><%=m.getNombre()+ " " + m.getApellido()%> </option>   			  
   			 <%
			}
		}	
			 %>
			 </select>
<%}else{%>
		<td>Asignar alumnos antes</td>
<%}%>	
	</tr>
	<tr>
		<td>Maestro Paralelo: </td>
<% if (año > 0){%>
		<td><select name="maestro_par_grado">
		<% if (grado != null && paralelo != null){ %>
			<option value="<%= paralelo.getCod_maest()%>"><%=paralelo.getNombre()+ " " + paralelo.getApellido()%> </option>						
			<%
			for (Maestro m : maestros.getLista()){			 	
				if (m.getCod_maest() != paralelo.getCod_maest()){	//elimina el maestro titular suplente de la lista
 			 %>
   			   <option value="<%=m.getCod_maest()%>"><%=m.getNombre()+ " " + m.getApellido() %></option>
   			 <%
			 	}
			}
		}else{			
			for (Maestro m : maestros.getLista()){		
 			 %>
   			   <option value="<%=m.getCod_maest()%>"><%=m.getNombre()+ " " + m.getApellido() %></option>
   			 <%			 
			}
		}
		%>
		</select>
<%}else{%>
		<td>Asignar alumnos antes</td>
<%}%>		 
	</tr>
</table>
<br>
<input type="submit" value="Guardar">
<input type="reset" value="Cancelar">
</form>
<br>
<%if (año == 0 && grado != null){%>
<a>No hay alumnos asignados, el grado se puede </a><a href="GradoEdit?do=baja">borrar</a>
<br>
<br>
<%}%>
<form action="grado_list.jsp" method="post">
<input type="submit" value="Volver al listado">
</form>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>