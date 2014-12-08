<%@page import="datos.*"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMensaje"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "alumnos");%>

<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Editar Observaciones</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">

</head>
<body>

<div class="container"> 

  <div id="divmenu">
  	<!-- sirve para visualizar el men� superior -->
  </div>
  
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
		
		Mensaje m = AccionesMensaje.getOne(57);
%>
 		<div class="alert <%=m.getTipo()%> fade in" role="alert">
     	 	<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 	<%=m.getMensaje()%>
  	  	</div>
<%
	} else {
%>
<table class="table table-hover table-bordered">
	<thead>
	<tr class="active">
		<th>N�</th>
		<th>Observaciones</th>
		<th>&nbsp;</th>
	</tr>
	<thead>
<%	int i = 0;
	for (Observacion ob : o.getLista()){
		i++;
%>	
	<tbody>
	<tr>
		<td><%=i%></td>
		<td><%= ob.getObservaciones() %></td>
		<td><strong><a href="certificadoEdit?from=obs&do=eliminar&obs=<%= ob.getObservaciones() %>" ><i class="glyphicon glyphicon-trash"></i> Eliminar</a></strong></td>
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
<label for="input">Ingrese nueva observaci�n:</label>
<br>
<br>
<form action="certificadoEdit?from=obs" method="post">
<textarea name="obs_nueva" rows="4" cols="50" class="form-control"></textarea>
<br>
<br>
<button type="submit" class="btn btn-primary"  onclick=<%=AccionesMensaje.getOne(1).getMensaje()%>><i class="glyphicon glyphicon-floppy-disk"></i> Guardar</button>
<button type="reset" class="btn btn-primary"   onclick=<%=AccionesMensaje.getOne(3).getMensaje()%>><i class="glyphicon glyphicon-remove"></i> Cancelar</button>
</form>
<br>
<br>
<br>
<br>
<form action="certificado_list.jsp" method="post">
<button type="submit" class="btn btn-primary"  value="Volver" name="btnBack"><i class="glyphicon glyphicon-share-alt"></i> Volver</button>
</form>
</div>
	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

	<!-- men� superior -->
	<script src="js/menu_admin.js"></script>
</body>
</html>