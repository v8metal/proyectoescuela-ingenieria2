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
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<%

	int tipo = (Integer) session.getAttribute("tipoUsuario");
	if (AccionesUsuario.validarAcceso(tipo, "nota_lista_inf.jsp") != 1){							
		response.sendRedirect("Login");						
	}
		
	Grado grado = (Grado) session.getAttribute("grado_notas");
	Alumnos alumnos = (Alumnos) session.getAttribute("alumnos_notas");	
	int año = (Integer) session.getAttribute("añoNotas");
%>
<title>Informes por grado</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<!--<link rel="stylesheet" href="style/jquery-ui.css">  con ese no se ven las flechitas-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">

</head>
<body>
<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>
  
<br>

<div class="page-header">
<h1><%=grado.getGrado() + " - " + grado.getTurno() + " - Año " + año%></h1>
</div>

<table class="table table-hover table-bordered">
	<tr>
		<th><center>Alumno</center></th>
		<th colspan="3"><center>Informes</center></th>			
	</tr>	
<% for (Alumno a : alumnos.getLista()){%>
	<tr>	
		<td><%=a.getApellido() + ", " + a.getNombre() %></td>
		<td><center><strong><a href="NotaEdit?accion=editarInforme&dni_inf=<%=a.getDni()%>&informe=<%=1%>"><i class="glyphicon glyphicon-pencil"></i>Marzo</a></strong></center></td>
		<td><center><strong><a href="NotaEdit?accion=editarInforme&dni_inf=<%=a.getDni()%>&informe=<%=2%>"><i class="glyphicon glyphicon-pencil"></i>Mitad de Año</a></strong></center></td>
		<td><center><strong><a href="NotaEdit?accion=editarInforme&dni_inf=<%=a.getDni()%>&informe=<%=3%>"><i class="glyphicon glyphicon-pencil"></i>Fin de Año</a></strong></center></td>
	</tr>
<%}%>	
</table>
<br>
<br>
<form action="menu_notas.jsp" method="post">
<input type="hidden" name="volver" value="volver">
<button type="submit" class="btn btn-primary"  value="Seleccionar otro grado"><i class="glyphicon glyphicon-pushpin"></i> Seleccionar otro grado</button>
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