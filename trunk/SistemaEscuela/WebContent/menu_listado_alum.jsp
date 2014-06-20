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
		
		// recupero de la sesion el a�o actual
		int a�o = Integer.parseInt((String)session.getAttribute("a�o_sys"));
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
			<option value="1ro">1� Grado</option>
			<option value="2do">2� Grado</option>
			<option value="3ro">3� Grado</option>
			<option value="4to">4� Grado</option>
			<option value="5to">5� Grado</option>
			<option value="6to">6� Grado</option>
			<option value="7mo">7� Grado</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>Seleccione el turno:</td>
		<td><select name="turno">
			<option value="MA�ANA">Ma�ana</option>
			<option value="TARDE">Tarde</option>
			</select>
		</td>
	</tr>		
	<tr>
		<td>Seleccione el a�o:</td>
		<td>
			<select name="a�o">
			 <%
			 	for (int i = a�o; i >= 2000; i--){
 			 %>
			 <option <%=a�o==i ? "selected" : ""%>><%=i%></option>
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