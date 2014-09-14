<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMaestro"%>
<%@page import="datos.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Registro de nuevo usuario</title>
</head>
<body>
<%
	if (session.getAttribute("login") != null) {
		
		String error = "";
		if (session.getAttribute("error") != null) {
			error = (String)session.getAttribute("error");
			session.setAttribute("error", "");
		}
%>
<h1>Registro de nuevo usuario</h1>
<%
	Maestros maestros = AccionesMaestro.getAll();
	if ((maestros.getLista().size() - AccionesUsuario.maestrosConCuenta()) == 0) {
%>
<p>Todos los maestros están registrados</p>
<%	
	} else {	
%>
<form action="registroUser" method="post">
<table>
	<tr>
		<td>Maestro: </td>
		<td><select name="maestro">
			<%
			for (Maestro m : maestros.getLista()){
				if (!AccionesUsuario.validarCuentaMaestro(m.getCod_maest())) {
			%>	 			  
		   		<option value="<%=m.getCod_maest()%>"><%= m.getApellido() + ", "  + m.getNombre() %> </option>   			  
		   	<%
				}
			}			
			%>
		 </select>
		</td>
		<td><%=error%></td>
	</tr>
	<tr>
		<td>Usuario: </td>
		<td><input type="text" size="22" name="usuario"></td><td></td>
	</tr>
	<tr>
		<td>Contraseña: </td>
		<td><input type="password" size="22" name="contraseña"></td>
	</tr>
	<tr>
		<td>Confirmar contraseña: </td>
		<td><input type="password" size="22" name="contraseña_conf"></td>
	</tr>
</table>
<br>
<input type="submit" value="Registrarme">
</form>
<br>
<%
	}
%>
<br>
<form action="gest_user_menu.jsp" method="post">
<input type="submit" value="Volver">
</form>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>