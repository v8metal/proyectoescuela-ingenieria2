<%@page import="datos.Grado"%>
<%@page import="datos.Materia"%>
<%@page import="datos.Materias"%>
<%@page import="datos.MateriasGrado"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "grados");%>

<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de Materias</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

</head>
<body>

<%
	// modulo de seguridad
	int tipo = (Integer) session.getAttribute("tipoUsuario");
	if (AccionesUsuario.validarAcceso(tipo, "materias_list.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
%>

<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>

<%
		
	String error = "";
	if (session.getAttribute("error") != null) {
		error = (String)session.getAttribute("error");
		session.setAttribute("error", "");
	}
		
	MateriasGrado mat_grado = new MateriasGrado();
		
	if(session.getAttribute("materias_grado") != null) {			
		mat_grado = (MateriasGrado) session.getAttribute("materias_grado");
	}
		
	Materias materias  = (Materias) session.getAttribute("materias");		
		
	Grado grado  = (Grado) session.getAttribute("grado_materias");
%>
<div class="page-header">  
	<h1><%= grado.getGrado() + " - Turno " + grado.getTurno() + " - AÑO " + grado.getAño() %></h1>
</div> 
<%		
if(mat_grado.getLista().isEmpty()){
%>
<!-- MENSAJE DE INFORMATIVO -->
	<div class="alert alert-info" role="alert">
	  <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <strong> Atención!</strong> No hay materias asignadas
    </div>	
	
<%}else{%>
<div class="page-header">
	<h2>Listado de Materias</h2>
</div>
<% 
			if (!error.equals("")) {
%>
<%=error%>
<br>
<br>
<%
			}
%>
<table class="table table-hover table-bordered">
	<thead>
	<tr class="active">
		<th>
			<label for="input">Materia</label>
		</th>		
		<th>&nbsp;</th>
	</tr>
	</thead>
<%	
	for (Materia m : mat_grado.getLista()) {	
%>
	<tbody>
	<tr>
		<td><%= m.getMateria() %></td>	
		<td><strong><a href="MateriaGradoList?do=desasignar&materia=<%=m.getMateria()%>" onclick="return confirm('Esta seguro que desea desasignar?');"> Desasignar</a></strong></td>
	</tr>
	</tbody>
	
<%
	}
 %>
</table>
<%}%>
<br>
<%
if ((materias.getLista().size() - mat_grado.getLista().size()) == 0){
}else{
	
%>
<div class="form-group">
<form action="MateriaGradoList" method="post">
<table class="table table-hover table-bordered">
	<tr>		
		<td>
			<label for="input">Asignar Materia</label>
		</td>
		<td>
			<div class="col-xs-6">
				<select name="materia_asignar" class="form-control">
					<%
					for (Materia m : materias.getLista()){
						
						if (!mat_grado.contains(m)){ //evita que se muestren las materias ya asignadas				
					
					%>	 			  
		   				<option value="<%= m.getMateria()%>"><%= m.getMateria() %> </option>   			  
		   			<%				
						}
			 				    			
					}			
					%>
		 		</select>
		 	</div>	
		</td>					
	</tr>
</table>
<br>
<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="return confirm('Esta seguro que desea Asignar?');" >Asignar Materia</button>
</form>
</div>
<%}%>
<br>
<div class="form-group">
<form action="GradoList" method="get">
<button type="submit" class="btn btn-primary"  value="Volver al Listado"><i class="glyphicon glyphicon-share-alt"></i> Volver al Listado</button>
</form>
</div>
</div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

	<!-- menú superior -->
	<script src="js/menu_admin.js"></script> 
</body>
</html>