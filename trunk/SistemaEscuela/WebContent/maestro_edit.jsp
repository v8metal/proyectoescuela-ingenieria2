<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Editar Maestro</title>
</head>
<body>
<%
	if (session.getAttribute("login") != null) {
%>
<h1>Editar Maestro</h1>
<%	String error = "";
	if (session.getAttribute("error") != null) {
		error = (String)session.getAttribute("error");
		session.setAttribute("error", "");
	}
 %>
  <%
  	//get the maestro object from the request
	Maestro maestro = (Maestro)request.getAttribute("maestro");
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
	<form id="edit-form" action="maestroEdit" method="post">
		<table border="1">
			<tbody>
				<tr>
					<td>Apellido:</td>
					<td class="form-input-field"><input id ="apellido" type="text" name="apellido" value="<%=maestro!=null? maestro.getApellido() : ""%>"></td>
					</tr><tr>		
					<td>Nombre:</td>	
					<td class="form-input-field"><input id="nombre" type="text" name="nombre" value="<%=maestro!=null ? maestro.getNombre() : ""%>"></td>
					</tr><tr>
					<td>D.N.I.:</td>	
					<td class="form-input-field"><input id="dni" type="text" name="dni" value="<%=maestro!=null ? maestro.getDni() : ""%>"></td>
					</tr><tr>
					<td>Domicilio:</td>	
					<td class="form-input-field"><input id="domicilio" type="text" name="domicilio" value="<%=maestro!=null ? maestro.getDomicilio() : ""%>"></td>
					</tr><tr>
					<td>Teléfono:</td>	
					<td class="form-input-field"><input id="telefono" type="text" name="telefono" value="<%=maestro!=null ? maestro.getTelefono() : ""%>"></td>
					</tr><tr>
					<td colspan="2"><input type="submit" name="btnSave" value="Guardar"></td>
				</tr>
			</tbody>
		</table>
		<input type="hidden" name="codigo" value="<%=maestro != null ? maestro.getCod_maest() : ""%>">
	</form> 
 <br>
<form action="menu_admin.jsp" method="post">
<input type="submit" value="Volver al menú">
</form>
 <%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>