<%@page import="datos.Grado"%>
<%@page import="datos.Materia"%>
<%@page import="datos.Materias"%>
<%@page import="datos.MateriasGrado"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de Materias</title>
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<body>
<div class="container">
<%
	if (session.getAttribute("admin") != null) {
		
		String error = "";
		if (session.getAttribute("error") != null) {
			error = (String)session.getAttribute("error");
			session.setAttribute("error", "");
		}
		
		MateriasGrado mat_grado = new MateriasGrado();
		
		if(session.getAttribute("materias_grado") != null) {			
			mat_grado = (MateriasGrado) session.getAttribute("materias_grado");
		}
		
		Materias materias  = (Materias) session.getAttribute("materias");		
		
		Grado grado  = (Grado) session.getAttribute("grado_materias");
%>
<div class="page-header">  
	<h1><%= grado.getGrado() + " - Turno " + grado.getTurno() + " - AÑO " + grado.getAño() %></h1>
</div> 
<%		
if(mat_grado.getLista().isEmpty()){
%>
<div class="page-header">  
	<h2>No hay materias asignadas</h2>
</div>	
<%}else{%>
<div class="page-header">
	<h2>Listado de Materias</h2>
</div>
<% 
			if (!error.equals("")) {
%>
<%=error%>
<br>
<br>
<%
			}
%>
<table class="table table-hover table-bordered">
	<tr>
		<th>Materia</th>		
		<th>&nbsp;</th>
	</tr>
<%	
	for (Materia m : mat_grado.getLista()) {	
%>
	<tr>
		<td><%= m.getMateria() %></td>	
		<td><a href="MateriaGradoList?do=desasignar&materia=<%=m.getMateria()%>" onclick="return confirm('Esta seguro que desea desasignar?');"> Desasignar</a></td>
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
<div class="form-group">
<form action="MateriaGradoList" method="post">
<table class="table table-hover table-bordered">
	<tr>		
		<td>Asignar Materia</td>
		<td>
		<select name="materia_asignar" class="form-control">
			<%
			for (Materia m : materias.getLista()){
				
				if (!mat_grado.contains(m)){ //evita que se muestren las materias ya asignadas				
					
			%>	 			  
		   		<option value="<%= m.getMateria()%>"><%= m.getMateria() %> </option>   			  
		   	<%				
				}
			 				    			
			}			
			%>
		 </select>
		</td>					
	</tr>
</table>
<br>
<center>
<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="return confirm('Esta seguro que desea Asignar?');" >Asignar Materia</button>
</center>
</form>
</div>
<%}%>
<br>
<div class="form-group">
<form action="GradoList" method="get">
<button type="submit" class="btn btn-primary"  value="Volver al Listado">Volver al Listado</button>
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
