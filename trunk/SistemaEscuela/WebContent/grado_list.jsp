<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="datos.Maestro"%>
<%@page import="conexion.AccionesMaestro"%>
<%@page import="conexion.AccionesGrado"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding ="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Listado de Grados</title>
</head>
<body>
<%
	if (session.getAttribute("login") != null) {	
		 
		Grados grados = (Grados)session.getAttribute("grados");	
		session.removeAttribute("grado_edit");
%>
<h1>Listado de Grados Turno Ma�ana</h1>
<%   
if (grados.getListaTM().isEmpty()){
%>
<h2>No hay grados para el turno tarde</h2>
<%}else{%>
<table border="2" bordercolor="666">
	<tr>
		<th>Grado</th>		
		<th>Evaluaci�n</th>		
		<th>Sal�n</th>
		<th>Maestro Titular</th>
		<th>Maestro Paralelo</th>
		<th>Ciclo Lectivo</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
<% 
		for (Grado g : grados.getListaTM()) {
			
			Maestro m1 = AccionesMaestro.getOne(g.getMaestrotit());
			Maestro m2 = AccionesMaestro.getOne(g.getMaestropar());		
			String ciclo = "No hay alumnos cargados";
			int a�o = AccionesGrado.getCurrentYear(g);
			
			if (a�o != 0){		
				ciclo = Integer.toString(a�o);
			}			
%>
	<tr>
		<td><%= g.getGrado() %></td>		
		<td><%= g.getEvaluacion() %></td>		
		<td><%= g.getSalon() %></td>
		<%if (m1 != null){ %> 
		<td><%= m1.getNombre() + " " + m1.getApellido() %></td>
		<%}else{%>
		<td>No hay maestro titular asignado</td>
		<%}%>
		<%if (m2 != null){ %> 
		<td><%= m2.getNombre() + " " + m2.getApellido() %></td>
		<%}else{%>
		<td>No hay maestro paralelo asignado</td>
		<%}%>
		<td><%= ciclo %></td>		
		<td><a href="GradoEdit?do=modificar&grado_modif=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>">Modificar</a></td>
		<%if (a�o == 0 || m1 == null){%>
		<td>No se pueden asignar materias</td>
		<%}else{%>
		<td><a href="MateriaGradoList?do=listar&grado_list=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>&grado_a�o=<%=a�o%>" >Ver Materias</a></td>
		<%}%>
		<% if ((g.getGrado().equals("7mo") || a�o == 0) || m1 == null){%>
		<td>No se puede promocionar</td>
		<%}else{ %>
		<td><a href="GradoEdit?do=promocion&grado_modif=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>&a�o=<%=a�o%>" >Promocionar Grado</a></td>		
		<% } %>				
	</tr>
<%	 
		}
	}		
%>
</table>
<br>
<h1>Listado de Grados Turno Tarde</h1>
<%   
if (grados.getListaTT().isEmpty()){
%>
<h2>No hay grados para el turno tarde</h2>
<%}else{%>
<table border="2" bordercolor="666">
	<tr>
		<th>Grado</th>		
		<th>Evaluaci�n</th>		
		<th>Sal�n</th>
		<th>Maestro Titular</th>
		<th>Maestro Paralelo</th>
		<th>Ciclo Lectivo</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
<% 
		for (Grado g : grados.getListaTT()) {
			
			Maestro m1 = AccionesMaestro.getOne(g.getMaestrotit());
			Maestro m2 = AccionesMaestro.getOne(g.getMaestropar());		
			String ciclo = "No hay alumnos cargados";
			int a�o = AccionesGrado.getCurrentYear(g);
			
			if (a�o != 0){
				ciclo = Integer.toString(a�o);
			}			
%>
	<tr>
		<td><%= g.getGrado() %></td>		
		<td><%= g.getEvaluacion() %></td>		
		<td><%= g.getSalon() %></td>
		<%if (m1 != null){ %> 
		<td><%= m1.getNombre() + " " + m1.getApellido() %></td>
		<%}else{%>
		<td>No hay maestro titular asignado</td>
		<%}%>
		<%if (m2 != null){ %> 
		<td><%= m2.getNombre() + " " + m2.getApellido() %></td>
		<%}else{%>
		<td>No hay maestro paralelo asignado</td>
		<%}%>		
		<td><%= ciclo %></td>		
		<td><a href="GradoEdit?do=modificar&grado_modif=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>">Modificar</a></td>
		<%if (a�o == 0 || m1 == null){%>
		<td>No se pueden asignar materias</td>
		<%}else{%>
		<td><a href="MateriaGradoList?do=listar&grado_list=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>&grado_a�o=<%=a�o%>" >Ver Materias</a></td>
		<%}%>
		<% if (g.getGrado().equals("7mo") || a�o == 0){
		%>
		<td>No se puede promocionar</td>
		<%}else{ %>
		<td><a href="GradoEdit?do=promocion&grado_modif=<%=g.getGrado()%>&a�o=<%=a�o%>&grado_turno=<%=g.getTurno()%>" >Promocionar Grado</a></td>		
		<%}%>				
	</tr>
<%	 
	}
}		
%>
</table>
<br>
<a href="GradoEdit?do=alta">Ingresar nuevo Grado</a>
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