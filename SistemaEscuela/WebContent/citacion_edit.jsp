<%@page import="datos.Citacion"%>
<%@page import="datos.Maestro"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.Alumnos"%>
<%@page import="conexion.AccionesAlumno"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Editar Citación</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</head>
<body>

<%
		//Recupero el maestro para mostrar su nombre y apellido en el menú superior	
		Maestro maestro = (Maestro)session.getAttribute("maestro");
		String nombre = maestro.getNombre();
		String apellido = maestro.getApellido();
%>

<div class="container">

<!-- Fixed navbar -->
    <div class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Sistema</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
              <li><a href="menu_user.jsp">Menú</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Asistencias <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="AsistenciaList">Listado</a></li>
                  <li><a href="AsistenciaListEdit">Nueva asistencia</a></li>          
                </ul>
              </li>
              <li class="active" class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Citaciones <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="citaciones_select.jsp?action=listar">Listado</a></li>                 
                  <li><a href="CitacionEdit?do=alta">Nueva citación</a></li>          
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Sanciones <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="sanciones_select.jsp?action=listar">Listado</a></li>
                  <li><a href="SancionEdit?do=alta">Nueva sanción</a></li>          
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Entrevistas <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="EntrevistaList">Listado</a></li>
                </ul>
              </li>
              <li><a href="nota_menu.jsp">Notas</a></li>
               <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Cuenta <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="admin_user.jsp">Cambiar usuario</a></li>
                  <li><a href="admin_pass.jsp">Cambiar contraseña</a></li>          
                </ul>
              </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
            <li>
            	<div class="navbar-collapse collapse">
        		  <form action="cerrarSesion" method="post" class="navbar-form navbar-right" role="form">
           		 	<button type="submit" class="btn btn-primary">Salir</button>
        		  </form>
        		  <p class="navbar-text navbar-right"><strong><%= nombre + " " + apellido %></strong></p>
        		</div>
			</li>
          </ul>
        </div>
      </div>
    </div>
  
  <br>
  <br>


<%
	if (session.getAttribute("usuario") != null) {

		//update de sancion
		Citacion c = (Citacion) session.getAttribute("citacion_edit");
		//update de sancion
		
		String error = "";
		
		if (session.getAttribute("error") != null) {
			error = (String)session.getAttribute("error");
			System.out.println(error);
			session.setAttribute("error", "");
		}
		
		//alta de sancion
		int dia_alta = 0;
		boolean empty = false;
		
		Alumnos alumnos = new Alumnos();
		
		if (session.getAttribute("alumnos_citacion") != null){
			alumnos = (Alumnos) session.getAttribute("alumnos_citacion");
		}
		
		//alta de sancion
		
		int dia_citacion = 0;
		String mes_citacion = "";
		int año_citacion = 0;  
		
	if (c != null){		
		
		//separo la fecha (1990-01-01) por el "-"" y almaceno el año, mes y dia en un array
		String[] fecha_ent = c.getFecha().split ("-");
		//obtengo el dia, mes y año respectivamente
		dia_citacion = Integer.parseInt(fecha_ent[fecha_ent.length - 1]);
		mes_citacion = fecha_ent[fecha_ent.length - 2];
		año_citacion = Integer.parseInt(fecha_ent[fecha_ent.length - 3]);
		
		Alumno a = AccionesAlumno.getOne(c.getDni());
%>


<div class="page-header"> 
<h1>Modificación de Citación</h1>
</div>
<h2><%="Citación para " + a.getNombre() + " " + a.getApellido()%></h2>	
<%}else if (alumnos.getLista().isEmpty() & error.equals("")){
	empty = true;
%> 
<div class="alert alert-info" role="alert">
    <strong>Atención!</strong> No hay alumnos cargados para el año en curso
</div>
<%}else{	
	dia_citacion = Integer.valueOf((String)session.getAttribute("dia_sys"));
	mes_citacion = "0" + (String) session.getAttribute("mes_sys");
	año_citacion = Integer.valueOf((String)session.getAttribute("año_sys"));%>
<div class="page-header"> 	
<h1>Alta de Citación</h1>
</div>
<%}%>
<div class="form-group">
<form action="CitacionEdit" method="post">
<%
if (c == null){
%>
<input type="hidden" name="action" value="alta">
<%}else{%>
<input type="hidden" name="action" value="update">
<%}%>
<%if (empty == false){ %>
<table class="table table-hover table-bordered">
<% if (c == null){%>
	<tr>
		<td>Alumno</td>
		<td><select name="alumno_citacion">		
		<%
		for (Alumno a  : alumnos.getLista()){		 		
 		%>  			  
   			<option value="<%= a.getDni() %>"><%=a.getApellido()+ ", " + a.getNombre()%> </option>   			  
   		 <%   			
		}		
		%>
		</select>
	</tr>
<%}%>
	<tr>
		<td>Fecha </td>
		<td><select name="dia_citacion">   
			<%  
			for (int i = 1; i <= 31; i++){			  	
 			%>
			 	<option <%= dia_citacion ==i ? "selected" : ""%>><%=i%></option>		 	
   			<%
			}	
			 %>
 			 </select>
  			 <select name="mes_citacion">
  			 <option value="01" <%=mes_citacion.equals("01") ? "selected" : ""%>>Enero</option>
			 <option value="02" <%=mes_citacion.equals("02") ? "selected" : ""%>>Febrero</option>
			 <option value="03" <%=mes_citacion.equals("03") ? "selected" : ""%>>Marzo</option>
			 <option value="04" <%=mes_citacion.equals("04") ? "selected" : ""%>>Abril</option>
			 <option value="05" <%=mes_citacion.equals("05") ? "selected" : ""%>>Mayo</option>
			 <option value="06" <%=mes_citacion.equals("06") ? "selected" : ""%>>Junio</option>
			 <option value="07" <%=mes_citacion.equals("07") ? "selected" : ""%>>Julio</option>
			 <option value="08" <%=mes_citacion.equals("08") ? "selected" : ""%>>Agosto</option>
			 <option value="09" <%=mes_citacion.equals("09") ? "selected" : ""%>>Septiembre</option>
			 <option value="10" <%=mes_citacion.equals("10") ? "selected" : ""%>>Octubre</option>
			 <option value="11" <%=mes_citacion.equals("11") ? "selected" : ""%>>Noviembre</option>
			 <option value="12" <%=mes_citacion.equals("12") ? "selected" : ""%>>Diciembre</option>	   			 		
 			 </select>
 <%if (c != null){ %>
			 <select name="año_citacion">
			<%
			for (int i = 1900; i < 2090; i++){
 			 %>
 			 	<option <%= año_citacion==i ? "selected" : ""%>><%=i%></option>
			<%
			 }
			 %>
  			 </select>
 <%}%>
  		</td>
  	<tr>
		<td>Hora</td>
		<td>
		<select name="hora_citacion">
			 <option value="08:00:00" <%=c !=null && c.getHora().equals("08:00:00") ? "selected" : ""%>>08:00</option>
  			 <option value="08:30:00" <%=c !=null && c.getHora().equals("08:30:00") ? "selected" : ""%>>08:30</option>
  			 <option value="09:00:00" <%=c !=null && c.getHora().equals("09:00:00") ? "selected" : ""%>>09:00</option>
  			 <option value="09:30:00" <%=c !=null && c.getHora().equals("09:30:00") ? "selected" : ""%>>09:30</option>
  			 <option value="10:00:00" <%=c !=null && c.getHora().equals("10:00:00") ? "selected" : ""%>>10:00</option>
  			 <option value="10:30:00" <%=c !=null && c.getHora().equals("10:30:00") ? "selected" : ""%>>10:30</option>
  			 <option value="11:00:00" <%=c !=null && c.getHora().equals("11:00:00") ? "selected" : ""%>>11:00</option>
  			 <option value="11:30:00" <%=c !=null && c.getHora().equals("11:30:00") ? "selected" : ""%>>11:30</option>
  			 <option value="12:00:00" <%=c !=null && c.getHora().equals("12:00:00") ? "selected" : ""%>>12:00</option>
  			 <option value="12:30:00" <%=c !=null && c.getHora().equals("12:30:00") ? "selected" : ""%>>12:30</option>
  			 <option value="13:00:00" <%=c !=null && c.getHora().equals("13:00:00") ? "selected" : ""%>>13:00</option>
  			 <option value="13:30:00" <%=c !=null && c.getHora().equals("13:30:00") ? "selected" : ""%>>13:30</option>
  			 <option value="14:00:00" <%=c !=null && c.getHora().equals("14:00:00") ? "selected" : ""%>>14:00</option>
  			 <option value="14:30:00" <%=c !=null && c.getHora().equals("14:30:00") ? "selected" : ""%>>14:30</option>
  			 <option value="15:00:00" <%=c !=null && c.getHora().equals("15:00:00") ? "selected" : ""%>>15:00</option>
  			 <option value="15:30:00" <%=c !=null && c.getHora().equals("15:30:00") ? "selected" : ""%>>15:30</option>
  			 <option value="16:00:00" <%=c !=null && c.getHora().equals("16:00:00") ? "selected" : ""%>>16:00</option>
  			 <option value="16:30:00" <%=c !=null && c.getHora().equals("16:30:00") ? "selected" : ""%>>16:30</option>
  			 <option value="17:00:00" <%=c !=null && c.getHora().equals("17:00:00") ? "selected" : ""%>>17:00</option>
  			 <option value="17:30:00" <%=c !=null && c.getHora().equals("17:30:00") ? "selected" : ""%>>17:30</option>  			 
  		</select>  			 
		</td>		
	</tr>
	<tr>
	<td>Descripción</td>	
	<td><textarea rows="4" cols="50" name="descripcion_citacion"><%=c != null ? c.getDescripcion() : ""%></textarea></td>	
	</tr>
</table>
<br>
<button type="submit" class="btn btn-primary"  value="Guardar">Guardar</button>
<button type="reset" class="btn btn-primary"  value="Cancelar">Cancelar</button>
<%}%>
</form>
</div>
<br>
<%if (!error.equals("")) {%>
	<div class="bs-example">
    	 <div class="alert alert-warning fade in" role="alert">
     	 	<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 	<strong>Cuidado!</strong> <%=error%>
  	  	</div>
 	 </div><!-- /example -->
<br>
<br>
<%}%>
<%
String volver = "menu_user.jsp";
if (c != null){
	volver = "citaciones_list.jsp";
}
%>
<div class="form-group">
<form action="<%=volver%>" method="post">
<button type="submit" class="btn btn-primary"  value="Volver">Volver</button>
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