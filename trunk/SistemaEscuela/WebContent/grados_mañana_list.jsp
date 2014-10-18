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
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de Grados</title>
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<body>
<div class="container">
<%
	if (session.getAttribute("admin") != null) {	
		 
		Grados grados = (Grados)session.getAttribute("grados_alta");
		Grados gradosp = (Grados)session.getAttribute("grados_pendientes");
		session.removeAttribute("grado_edit");
%>
<div class="page-header">  
	<h1>Listado de Grados Turno Ma�ana</h1>
  </div>
<%   
if (grados.getListaTM().isEmpty()){
%>  
  <div class="page-header">  
	<h2>No hay grados para el turno Ma�ana</h2>
  </div>

<%}else{%>
<table class="table table-hover table-bordered">
	<tr>
		<th>Grado</th>				
		<th>Tipo de evaluaci�n</th>
		<th>Periodo evaluaci�n</th>
		<th>Sal�n</th>
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
			
			int dni1=1;			
			if(m1 != null) dni1=m1.getDni();
				
			String ciclo = "No hay alumnos cargados";
			int a�o = AccionesGrado.getCurrentYear(g);
			
			if (a�o != 0){		
				ciclo = Integer.toString(a�o);
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
		<td>Grado con �reas de trabajo</td>
		<%}else{
		 if (a�o == 0){%>		
		<td>Debe asignar alumnos primero</td>
		<%}else{ 
		if(dni1 == 1){%>
		<td>Debe asignar Maestro titular primero</td>
		<%}else{%>		
		<td><a href="MateriaGradoList?do=listar&grado_list=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>&grado_a�o=<%=a�o%>" >Ver Materias</a></td>
		<%}}}%>
		<% if ((g.getGrado().equals("7mo") || a�o == 0) || m1 == null){%>
		<td>No se puede promocionar</td>
		<%}else{ %>
		<td><a href="GradoEdit?do=promocion&grado_modif=<%=g.getGrado()%>&grado_turno=<%=g.getTurno()%>&a�o=<%=a�o%>" onclick="<%="return confirm('Esta seguro que desea promocionar "+  g.getGrado() + "-" + g.getTurno()  +"?');"%>">Promocionar Grado</a></td>		
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
<div class="form-group">
<form action="menu_admin.jsp" method="post">
<button type="submit" class="btn btn-primary"  value="Volver al men�">Volver al men�</button>
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