<%@page import="conexion.AccionesNota"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="datos.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%session.setAttribute("modulo", "notas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<%

	int tipo = (Integer) session.getAttribute("tipoUsuario");
	if (AccionesUsuario.validarAcceso(tipo, "nota_lista_mat.jsp") != 1){							
		response.sendRedirect("Login");						
	}
		
	Grado grado = (Grado) session.getAttribute("grado_notas");
	Alumno alumno = (Alumno) session.getAttribute("alumno_notas");
	MateriasGrado materias = (MateriasGrado) session.getAttribute("materias_notas");
	int año = (Integer) session.getAttribute("añoNotas");
%>
<title>Materias para evaluar</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

</head>
<body>
<div class="container">
  
  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>
  
<br>
<div class="page-header">
<h1><%= alumno.getApellido() + ", " + alumno.getNombre() + " - " + grado.getGrado() + " - " + grado.getTurno() + " - Año " + año%></h1>
</div>

<!-- table class="table table-hover table-bordered"> -->
<table class="table table-striped">
	<tr>
		<th>Materia</th>		
		<%if(grado.getBimestre()){%>
		<th><center>1º Bimestre</center></th>
		<th><center>2º Bimestre</center></th>
		<th><center>3º Bimestre</center></th>
		<th><center>4º Bimestre</center></th>
		<%} else {%>		
		<th><center>1º Trimestre</center></th>
		<th><center>2º Trimestre</center></th>
		<th><center>3º Trimestre</center></th>
		<%}%>
	</tr>
<% for (Materia m : materias.getLista()) {%>	
	<tr>		
		<td><%=m.getMateria()%></td>
		<%if (grado.getBimestre()){
		
			Nota bimestre1 = AccionesNota.getNota(año,alumno.getDni(),m.getMateria(),"1° Bimestre");
			Nota bimestre2 = AccionesNota.getNota(año,alumno.getDni(),m.getMateria(),"2° Bimestre");
			Nota bimestre3 = AccionesNota.getNota(año,alumno.getDni(),m.getMateria(),"3° Bimestre");
			Nota bimestre4 = AccionesNota.getNota(año,alumno.getDni(),m.getMateria(),"4° Bimestre");
						
		%>
	
		
		<td><center><a href="NotaEdit?accion=editarNota&dni_nota=<%=alumno.getDni()%>&materia=<%=m.getMateria()%>&periodo=1° Bimestre"><%=bimestre1!=null?bimestre1.getCalific():"S/C"%></a></center></td>
		<td><center><a href="NotaEdit?accion=editarNota&dni_nota=<%=alumno.getDni()%>&materia=<%=m.getMateria()%>&periodo=2° Bimestre"><%=bimestre2!=null?bimestre2.getCalific():"S/C"%></a></center></td>
		<td><center><a href="NotaEdit?accion=editarNota&dni_nota=<%=alumno.getDni()%>&materia=<%=m.getMateria()%>&periodo=3° Bimestre"><%=bimestre3!=null?bimestre3.getCalific():"S/C"%></a></center></td>
		<td><center><a href="NotaEdit?accion=editarNota&dni_nota=<%=alumno.getDni()%>&materia=<%=m.getMateria()%>&periodo=4° Bimestre"><%=bimestre4!=null?bimestre4.getCalific():"S/C"%></a></center></td>
		
		<%}else{
		
			Nota trimestre1 = AccionesNota.getNota(año,alumno.getDni(),m.getMateria(),"1° Trimestre");
			Nota trimestre2 = AccionesNota.getNota(año,alumno.getDni(),m.getMateria(),"2° Trimestre");
			Nota trimestre3 = AccionesNota.getNota(año,alumno.getDni(),m.getMateria(),"3° Trimestre");					
		%>
		
		<td><center><a href="NotaEdit?accion=editarNota&dni_nota=<%=alumno.getDni()%>&materia=<%=m.getMateria()%>&periodo=1° Trimestre"><%=trimestre1!=null?trimestre1.getCalific():"S/C"%></a></center></td>
		<td><center><a href="NotaEdit?accion=editarNota&dni_nota=<%=alumno.getDni()%>&materia=<%=m.getMateria()%>&periodo=2° Trimestre"><%=trimestre2!=null?trimestre2.getCalific():"S/C"%></a></center></td>
		<td><center><a href="NotaEdit?accion=editarNota&dni_nota=<%=alumno.getDni()%>&materia=<%=m.getMateria()%>&periodo=3° Trimestre"><%=trimestre3!=null?trimestre3.getCalific():"S/C"%></a></center></td>
	
		<%}%>
	
	</tr>
<%}%>
</table>
<br>
<br>
<form action="nota_lista_alum.jsp" method="post">
<input type="hidden" name="volver" value="volver">
<button type="submit" class="btn btn-primary"  value="Volver al listado"><i class="glyphicon glyphicon-pushpin"></i>Volver al listado</button>
</form>
</div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

	<!-- menú superior -->
	<script src="js/menu_user.js"></script> 
</body>
</html>