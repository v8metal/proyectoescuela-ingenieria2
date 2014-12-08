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

<title>Informe de Alumno</title>

<link rel="icon" href="icono/favicon.ico">
<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
<!-- <link rel="stylesheet" href="style/jquery-ui.css"> --> 
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css"> 

</head>
<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "informe_edit.jsp") != 1){							
		response.sendRedirect("Login");						
	}
	
	String informe = (String) request.getAttribute("informe"); //informe escrito
	int numero = (Integer) session.getAttribute("numero_inf"); //n�mero de informe (1,2,3)
	Alumno alumno = (Alumno) session.getAttribute("alumno_inf");
	int a�o = (Integer) session.getAttribute("a�oNotas"); //a�o seleccionado en el men�
	
	String titulo = "Alta ";
	String inf = ""; 
	
	if (informe != null && !informe.equals("")){titulo="Edici�n "; }
	
	switch(numero){
	
	case 1:
		inf = "Marzo";
		break;
	case 2:
		inf = "Mitad de A�o";
		break;	
	case 3:
		inf = "Fin de A�o";
		break;
	}
	
	titulo = titulo + " Informe - A�o " + a�o;
	
	String accion = "altaInforme";
	
	if(informe != null){ accion = "modificarInforme";}
%>
<body>
<div class="container">

 <div id="divmenu">
 	<!-- sirve para visualizar el men� superior -->
 </div>
 
<div class="page-header">
	<h1><%=titulo%></h1>
</div>

<h3><%=alumno.getApellido() + ", " + alumno.getNombre()%></h3>
<br> 

<div class="form-group">

<form action="NotaEdit?do=<%=accion%>" method="post">
	<table class="table table-hover table-bordered">
	<tr>
		<td><label for="input"><%=inf%></label></td>
        <td>
        	<div class="col-xs-10">
        		<textarea class="form-control" cols="50" rows="4" name="desc_informe" placeholder="Informe"><%=informe!=null?informe:""%></textarea>
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
	<form action="nota_lista_inf.jsp" method="post">
		<button type="submit" class="btn btn-primary"  value="Volver al Listado"><i class="glyphicon glyphicon-share-alt"></i> Volver al Listado</button>
	</form>
</div>

	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>
	
	<script src="js/jquery-ui.js"></script>	

	<!-- men� superior -->
	<script src="js/menu_user.js"></script>
</div>
</body>
</html>