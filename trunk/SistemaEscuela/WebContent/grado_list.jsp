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
		 
		Grados grados = (Grados)session.getAttribute("grados_alta");
		Grados gradosp = (Grados)session.getAttribute("grados_pendientes");
		session.removeAttribute("grado_edit");
%>
<h1>Listado de Grados Turno Mañana</h1>
<%   
if (grados.getListaTM().isEmpty()){
%>
<h2>No hay grados para el turno Mañana</h2>
<%}else{%>
<table border="2" bordercolor="666">
	<tr>
		<th>Grado</th>				
		<th>Tipo de evaluación</th>
		<th>Periodo evaluación</th>
		<th>Salón</th>
		<th>Maestro Titular</th>
		<th>Maestro Paralelo</th>
		<th>Ciclo Lectivo</th>
		<th>Modificar</th>
		<th>Materias</th>
		<th>Promocion</th>
	</tr>
<% 
		for (Grado g : grados.getListaTM()) {
			
			Maestro m1 = AccionesMaestro.getOne(g.getMaestrotit());
			Maestro m2 = AccionesMaestro.getOne(g.getMaestropar());		
			String ciclo = "No hay alumnos cargados";
			int año = AccionesGrado.getCurrentYear(g);
			
			if (año != 0){		
				ciclo = Integer.toString(año);
			}			
%>
	<tr>
		<td><%= g.getGrado() %></td>		
		<td><%= g.getEvaluacionNombre() %></td>
		<td><%= g.getPeriodo() %></td>
		<td><%= g.getSalon() %></td>
		<%if (m1 != null){ %> 
		<td><%= m1.getNombre() + " " + m1.getApellido() %></td>
		<%}else{%>
		<td>No hay maestro asignado</td>
		<%}%>
		<%if (m2 != null){ %> 
		<td><%= m2.getNombre() + " " + m2.getApellido() %></td>
		<%}else{%>
		<td>No hay maestro asignado</td>
		<%}%>
		<td><%= ciclo %></td>		
		<td><a href="GradoEdit?do=modificar&grado_modif=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>">Modificar</a></td>
		<%if(g.getGrado().equals("Sala 4") || g.getGrado().equals("Sala 5")){%>
		<td>Grado con áreas de trabajo</td>
		<%}else{
		 if (año == 0 || m1 == null){%>		
		<td>No se pueden asignar materias</td>
		<%}else{%>
		<td><a href="MateriaGradoList?do=listar&grado_list=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>&grado_año=<%=año%>" >Ver Materias</a></td>
		<%}}%>
		<% if ((g.getGrado().equals("7mo") || año == 0) || m1 == null){%>
		<td>No se puede promocionar</td>
		<%}else{ %>
		<td><a href="GradoEdit?do=promocion&grado_modif=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>&año=<%=año%>" >Promocionar Grado</a></td>		
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
		<th>Tipo de evaluación</th>
		<th>Periodo evaluación</th>
		<th>Salón</th>
		<th>Maestro Titular</th>
		<th>Maestro Paralelo</th>
		<th>Ciclo Lectivo</th>
		<th>Modificar</th>
		<th>Materias</th>
		<th>Promocion</th>
	</tr>
<% 
		for (Grado g : grados.getListaTT()) {
			
			Maestro m1 = AccionesMaestro.getOne(g.getMaestrotit());
			Maestro m2 = AccionesMaestro.getOne(g.getMaestropar());		
			String ciclo = "No hay alumnos cargados";
			int año = AccionesGrado.getCurrentYear(g);
			
			if (año != 0){		
				ciclo = Integer.toString(año);
			}			
%>
	<tr>
		<td><%= g.getGrado() %></td>		
		<td><%= g.getEvaluacionNombre() %></td>
		<td><%= g.getPeriodo() %></td>
		<td><%= g.getSalon() %></td>
		<%if (m1 != null){ %> 
		<td><%= m1.getNombre() + " " + m1.getApellido() %></td>
		<%}else{%>
		<td>No hay maestro asignado</td>
		<%}%>
		<%if (m2 != null){ %> 
		<td><%= m2.getNombre() + " " + m2.getApellido() %></td>
		<%}else{%>
		<td>No hay maestro asignado</td>
		<%}%>
		<td><%= ciclo %></td>		
		<td><a href="GradoEdit?do=modificar&grado_modif=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>">Modificar</a></td>
		<%if(g.getGrado().equals("Sala 4") || g.getGrado().equals("Sala 5")){%>
		<td>Grado con áreas de trabajo</td>
		<%}else{
		 if (año == 0 || m1 == null){%>		
		<td>No se pueden asignar materias</td>
		<%}else{%>
		<td><a href="MateriaGradoList?do=listar&grado_list=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>&grado_año=<%=año%>" >Ver Materias</a></td>
		<%}}%>
		<% if ((g.getGrado().equals("7mo") || año == 0) || m1 == null){%>
		<td>No se puede promocionar</td>
		<%}else{ %>
		<td><a href="GradoEdit?do=promocion&grado_modif=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>&año=<%=año%>" >Promocionar Grado</a></td>		
		<% } %>				
	</tr>
<%	 
		}
	}		
%>
</table>
<br>
<% if (!gradosp.getLista().isEmpty()){ %>
<a href="GradoEdit?do=alta">Ingresar nuevo Grado</a>
<%}else{%>
<a> No quedan grados para dar de alta</a>
<%}%>
<br>
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