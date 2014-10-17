<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMaestro"%>
<%@page import="datos.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Registro de nuevo usuario</title>
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<body>
<div class="container">
<%
	if (session.getAttribute("login") != null) {
		
		Maestros maestros = (Maestros) session.getAttribute("activos");
		
		String error = "";
		if (session.getAttribute("error") != null) {
			error = (String)session.getAttribute("error");
			session.setAttribute("error", "");
		}
%>
<div class="page-header">  
	<h1>Alta de Usuario</h1>
</div>

<div class="form-group">

<form action="registroUser" method="post">

<table class="table table-hover table-bordered">

	<tr>
		<td><label for="input">Maestro</label></td>
		<td><select name="maestro" class="form-control">
			<%
			for (Maestro m : maestros.getLista()){
				if (!AccionesUsuario.validarCuentaMaestro(m.getDni())) {
			%>	 			  
		   		<option value="<%=m.getDni()%>"><%= m.getApellido() + ", "  + m.getNombre() %> </option>   			  
		   	<%
				}
			}			
			%>
		 </select>
		</td>
		<td><%=error%></td>
	</tr>
	
	<tr>
		<td><label for="input">Usuario</label></td>
        <td><input type="text" class="form-control" name="usuario" placeholder="Nombre"></td>
    </tr>
    
    <tr>
		<td><label for="input">Contraseña</label></td>
        <td><input type="password" class="form-control" name="contraseña" placeholder="Contraseña"></td>
    </tr>
    
    
    <tr>
		<td><label for="input">Confirmar contraseña</label></td>
        <td><input type="password" class="form-control" name="contraseña_conf" placeholder="Repetir Contraseña"></td>
    </tr>	
</table>
<br>
<center>
<button type="submit" class="btn btn-primary"  value="Registrar" name="btnSave" onclick="return confirm('Esta seguro que desea realizar el alta?');">Registrar</button>
<button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave" onclick="return confirm('Esta seguro que desea borrar los campos?');">Cancelar</button>
</center>
</form>
</div>
<br>
<br>
<div class="form-group">
<form action="gest_user_menu.jsp" method="post">
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