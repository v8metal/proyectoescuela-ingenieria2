<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Listado de Alumnos</title>
</head>
<body>
<%
	if (session.getAttribute("login") != null) {
		
		String error = "";
		if (session.getAttribute("error") != null) {
			error = (String)session.getAttribute("error");
			session.setAttribute("error", "");
		}
		
		// recupero de la sesion el año actual
		int año = Integer.parseInt((String)session.getAttribute("año_sys"));
%>
<center>
<h1>Listado de alumnos</h1>
<form action="alumnoList" method="post">
<table>	
	<tr>
		<td>Seleccione el grado: </td>
		<td><select name="grado">
			<option value="todos">TODOS</option>
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
		<td>Seleccione el turno:</td>
		<td><select name="turno">
			<option value="MAÑANA">Mañana</option>
			<option value="TARDE">Tarde</option>
			</select>
		</td>
	</tr>		
	<tr>
		<td>Seleccione el año:</td>
		<td>
			<select name="año">
			 <%
			 	for (int i = año; i >= 2000; i--){
 			 %>
			 <option <%=año==i ? "selected" : ""%>><%=i%></option>
			 <%
			 	}
			 %>
  			 </select>
		</td>
	</tr>
</table>
<br>
<input type="submit" value="Listar">
</form>
<% 
			if (!error.equals("")) {
%>
<br>
<br>
<%=error%>
<%
			}
%>
<br>
<br>
<br>
<br>
<form action="menu_alumnos.jsp" method="post">
<input type="submit" value="Volver a Alumnos">
</form>
<br>
<form action="cerrarSesion" method="post">
<input type="submit" value="Cerrar sesion">
</form>
</center>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>