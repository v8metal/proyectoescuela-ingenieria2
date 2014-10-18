<%@page import="conexion.AccionesMateria"%>
<%@page import="conexion.AccionesNota"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="datos.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<%
	if (session.getAttribute("usuario") != null) {
		String titulo = (String)session.getAttribute("titulo");
		
		int dni = Integer.parseInt((String)session.getAttribute("dni_alum"));
		String materia = (String)session.getAttribute("materia");
		String periodo = (String)session.getAttribute("periodo");
		
		int calific = (Integer)session.getAttribute("calific");
		
		Materia m = AccionesMateria.getOne(materia);
		
		// traigo el objeto alumno para usar su apellido y nombre
		Alumno a = AccionesAlumno.getOne(dni);
%>
<title><%=titulo%></title>
</head>
<body>	
<table border="2" bordercolor="666">
	<tr>
		<th><%=titulo%></th><th><%= periodo %></th><th>EDITAR NOTA</th>
	</tr>
</table>
<br>
<b>Alumno: </b><%=a.getApellido() + ", " + a.getNombre() %>
<br>
<br>
<form action="notaEdit" method="post">
<table border="2" bordercolor="666">
	<tr>
		<th>Materia</th>
		<th>Nota</th>
	</tr>
	<tr>
		<td><%= m.getMateria() %></td>
		<td>
			<select name="calific">
				<option value="0">S/C</option>
				<%
			 		for (int i = 1; i <= 10; i++) {
 				 %>
 				<option <%=calific==i && calific!=0? "selected" : ""%>><%=i%></option>
   			   <%
			 		}
			    %>
			</select>
		</td>
	</tr>	
</table>
<br>

<input type="submit" value="Guardar">
<input type="reset" value="Cancelar">
</form>
<br>
<br>
<form action="nota_lista_mat.jsp" method="post">
<input type="submit" value="Volver">
</form>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>