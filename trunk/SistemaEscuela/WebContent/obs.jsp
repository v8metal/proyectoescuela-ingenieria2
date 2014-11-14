<%@page import="datos.*"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("pagina", "alumnos");%>

<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Editar Observaciones</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/menu_admin.js"></script>

</head>
<body>

<div class="container"> 

<div id="divmenu"></div>
 
<br>
<br>
  
<div class="page-header">
<h1>Observaciones</h1>
</div>

<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "obs.jsp") != 1){							
		response.sendRedirect("Login");						
	}
		
	//	Alumno a = (Alumno)session.getAttribute("alumno");
		Observaciones o = (Observaciones)session.getAttribute("observaciones");
%>
<br>
<%
	if (o.getLista().isEmpty()) {
%>
<div class="alert alert-info" role="alert">
   <strong>Atención!</strong> No hay observaciones cargadas
</div>
<%
	} else {
%>
<table class="table table-hover table-bordered">
	<thead>
	<tr>
		<th>Nº</th>
		<th>OBSERVACIONES</th>
		<th>&nbsp;</th>
	</tr>
	<thead>
<%	int i = 0;
	for (Observacion ob : o.getLista()){
		i++;
%>	
	<tbody>
	<tr>
		<td><center><%=i%></center></td>
		<td><%= ob.getObservaciones() %></td>
		<td><a href="certificadoEdit?from=obs&do=eliminar&obs=<%= ob.getObservaciones() %>" >Eliminar</a></td>
	</tr>
	</tbody>
<%	
	}
%>
</table>
<%
	}	
%>
<br>
Ingrese nueva observación:
<br>
<br>
<form action="certificadoEdit?from=obs" method="post">
<textarea name="obs_nueva" rows="4" cols="50"></textarea>
<br>
<br>
<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave">Guardar</button>
</form>
<br>
<br>
<br>
<br>
<form action="certificado_list.jsp" method="post">
<button type="submit" class="btn btn-primary"  value="Volver" name="btnBack">Volver</button>
</form>
</div>
</body>
</html>