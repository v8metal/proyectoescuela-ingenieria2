<%@page import="datos.*"%>
<%@page import="conexion.AccionesMateria"%>
<%@page import="conexion.AccionesNota"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMensaje"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "notas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");
	if (AccionesUsuario.validarAcceso(tipo, "nota_edit.jsp") != 1){							
		response.sendRedirect("Login");						
	}
	
	Nota nota = (Nota) session.getAttribute("nota_edit");	
	Grado grado = (Grado) session.getAttribute("grado_notas");
	Alumno a = (Alumno) session.getAttribute("alumno_notas");
%>
<title>Edición de nota</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</head>
<body>
<div class="container">
  
  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>
  
<br>
<div class="page-header">
<h1><%= grado.getGrado() + " - " + grado.getTurno() + " - Año " + nota.getAño() +  " - " + a.getApellido() + ", " + a.getNombre() %></h1>
</div>
<br>
<div class="form-group">
<form action="NotaEdit?do=editarNota" method="post">

<table class="table table-striped">
	<tr>
		<th>
			<div class="col-xs-7">
			<label for="input"><%=nota.getMateria() %></label>			
			</div>
		</th>
		<th>
			<div class="col-xs-7">
			<label for="input"><%=nota.getPeriodo()%></label>			
			</div>
		</th>
		<td>
			<div class="col-xs-4">			
			<select required autofocus class="form-control" name="calificacion">
						
			<%if(grado.getEvaluacion() == 1){%>					
 				<option <%=nota.getCalific().equals("S/C")?"selected" : ""%>>S/C</option>
 				<option <%=nota.getCalific().equals("NS")?"selected" : ""%>>NS</option>
 				<option <%=nota.getCalific().equals("S")?"selected" : ""%>>S</option>
 				<option <%=nota.getCalific().equals("B")?"selected" : ""%>>B</option>
 				<option <%=nota.getCalific().equals("MB")?"selected" : ""%>>MB</option>
 				<option <%=nota.getCalific().equals("E")?"selected" : ""%>>E</option>
   			<%}%>
   			
   			<%if(grado.getEvaluacion() == 2){%>   					
 				<option <%=nota.getCalific().equals("S/C")?"selected" : ""%>>S/C</option>
 				<option <%=nota.getCalific().equals("1")?"selected" : ""%>>1</option>
 				<option <%=nota.getCalific().equals("2")?"selected" : ""%>>2</option>
 				<option <%=nota.getCalific().equals("3")?"selected" : ""%>>3</option>
 				<option <%=nota.getCalific().equals("4")?"selected" : ""%>>4</option>
 				<option <%=nota.getCalific().equals("5")?"selected" : ""%>>5</option>
 				<option <%=nota.getCalific().equals("6")?"selected" : ""%>>6</option>
 				<option <%=nota.getCalific().equals("7")?"selected" : ""%>>7</option>
 				<option <%=nota.getCalific().equals("8")?"selected" : ""%>>8</option>
 				<option <%=nota.getCalific().equals("9")?"selected" : ""%>>9</option>
 				<option <%=nota.getCalific().equals("10")?"selected" : ""%>>10</option> 				
   			<%}%>		
			</select>
			</div>	
		</td>		
	</tr>	
</table>
<br>
<button type="submit" class="btn btn-primary" onclick=<%=AccionesMensaje.getOne(1).getMensaje()%>><i class="glyphicon glyphicon-floppy-disk"></i> Guardar</button>
<button type="reset" class="btn btn-primary"  onclick=<%=AccionesMensaje.getOne(3).getMensaje()%>><i class="glyphicon glyphicon-remove"></i> Cancelar</button>
</form>
</div>
<br>
<br>
<div class="form-group">
	<form action="nota_lista_mat.jsp" method="post">
	<button type="submit" class="btn btn-primary"  value="Volver al Listado"><i class="glyphicon glyphicon-share-alt"></i> Volver al Listado</button>
	</form>
</div>
</div>
</body>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

	<!-- menú superior -->
	<script src="js/menu_user.js"></script> 
</html>