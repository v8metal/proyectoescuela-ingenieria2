<%@page import="datos.Materia"%>
<%@page import="datos.Materias"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Editar Materia</title>
</head>
<body>
<%
	if (session.getAttribute("login") != null) {
		
		Materia materia = (Materia)request.getAttribute("materia");
		
	if(materia != null){
%>
<h1>Editar Materia</h1>
<%}else{%>
<h1>Alta de Materia</h1>
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
	<form id="edit-form" action="materiaEdit" method="post">
		<table border="1">
			<tbody>
				<tr>		
					<td>Nombre:</td>	
					<td class="form-input-field"><input id="nombre" type="text" name="materia" value="<%=materia!=null ? materia.getMateria() : ""%>"></td>
					</tr><tr>
					<td colspan="2"><input type="submit" name="btnSave" value="Guardar"></td>
				</tr>
			</tbody>
		</table>		
		<input type="hidden" name="accion" value="alta">
	</form>
<%}%> 
<br>
<br> 
<form action="menu_admin.jsp" method="post">
<input type="submit" value="Volver al men�">
</form>
 <%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>