<%@page import="datos.Grado"%>
<%@page import="datos.Materia"%>
<%@page import="datos.Materias"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%
	if (session.getAttribute("login") != null) {
		
		String error = "";
		if (session.getAttribute("error") != null) {
			error = (String)session.getAttribute("error");
			session.setAttribute("error", "");
		}
		
		Materias mat_grado = new Materias();
		
		if(session.getAttribute("materias_grado") != null) {			
			mat_grado = (Materias)session.getAttribute("materias_grado");
		}
		
		Materias materias  = (Materias) session.getAttribute("materias");		
		
		Grado grado  = (Grado) session.getAttribute("grado_materias");
%>
<title>Listado de Materias</title>
</head>
<body>
<h1><%= grado.getGrado() + " - Turno " + grado.getTurno() + " - AÑO " + grado.getAño() %></h1>
<%
if(mat_grado.getLista().isEmpty()){
%>
<h2>No hay materias asignadas</h2>	
<%}else{%>
<h2>Listado de Materias</h2>
<% 
			if (!error.equals("")) {
%>
<%=error%>
<br>
<br>
<%
			}
%>
<table border="2" bordercolor="666">
	<tr>
		<th>Materia</th>		
		<th>&nbsp;</th>
	</tr>
<%	
	for (Materia m : mat_grado.getLista()) {	
%>
	<tr>
		<td><%= m.getNombre() %></td>	
		<td><a href="MateriaGradoList?do=desasignar&cod_materia=<%=m.getCod_materia()%>"> Desasignar</a></td>
	</tr>
	
<%
	}
 %>
</table>
<%}%>
<br>
<%
if ((materias.getLista().size() - mat_grado.getLista().size()) == 0){
}else{
%>
<form action="MateriaGradoList" method="post">
<table>
	<tr>		
		<td>Asignar Materia</td>
		<td>
		<select name="materia_asignar">
			<%
			for (Materia m : materias.getLista()){
				
				if(!mat_grado.getLista().contains(m)){ //evita que se muestren las materias ya asignadas
					
			%>	 			  
		   		<option value="<%= m.getCod_materia() %>"><%= m.getNombre() %> </option>   			  
		   	<%				
				}
			 				    			
			}			
			%>
		 </select>
		</td>					
	</tr>
</table>
<br>
<input type="submit" value="Asignar Materia">
</form>
<%}%>
<br>
<form action="grado_list.jsp" method="post">
<input type="submit" value="Volver al menú">
</form>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>
