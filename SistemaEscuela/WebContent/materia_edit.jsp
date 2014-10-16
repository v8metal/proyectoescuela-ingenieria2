<%@page import="datos.Materia"%>
<%@page import="datos.Materias"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Materias</title>
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<body>
<div class="container">
<%
	if (session.getAttribute("login") != null) {
		
		Materia materia = (Materia)request.getAttribute("materia");
		
	if(materia != null){
%>

  <div class="page-header">  
	<h1>Editar Materia</h1>
  </div>
<%}else{%>
<div class="page-header">  
	<h1>Alta de Materia</h1>
</div>

<%	
	String error = "";
	if (session.getAttribute("error") != null) {
		error = (String)session.getAttribute("error");
		session.setAttribute("error", "");
	}
 %> 
  <body>
    <% 
			if (!error.equals("")) {
%>
<%=error%>
<br>
<br>
<%
			}
%>
<div class="form-group"> 
	<form action="materiaEdit" method="post">
		<table class="table table-hover table-bordered">
			<tbody>							
				<tr>
				    <td><label for="input">Nombre:</label></td>
         			<td><input type="text" class="form-control" name="materia" placeholder="Nombre" value="<%=materia!=null ? materia.getMateria() : ""%>"></td>
         		</tr>			
			</tbody>
		</table>		
				<%
		String mensaje= "return confirm('Esta seguro que desea realizar el alta?');"; 
		  
		if (materia != null){
			
			mensaje = "return confirm('Esta seguro que desea modificar?');"; 
		}
		 
		%>
		<center>
		<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="<%=mensaje%>">Guardar</button>
		<button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave">Cancelar</button>
		</center>
		<input type="hidden" name="accion" value="alta">
		
	</form>
</div>
<%}%> 
<br>
<br> 
<div class="form-group">
<form action="materiaList?from=menu_admin" method="post">
<button type="submit" class="btn btn-primary"  value="Volver a Materias">Volver a Materias</button>
</form>
</div>
 <%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>