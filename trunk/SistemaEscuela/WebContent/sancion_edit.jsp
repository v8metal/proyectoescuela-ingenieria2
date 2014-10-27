<%@page import="datos.Sancion"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.Alumnos"%>
<%@page import="conexion.AccionesAlumno"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0">
<title>Editar Sanción</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</head>
<body>
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
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Citaciones <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="citaciones_select.jsp?action=listar">Listado</a></li>                 
                  <li><a href="CitacionEdit?do=alta">Nueva citación</a></li>          
                </ul>
              </li>
              <li class="active" class="dropdown">
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
        		</div>
			</li>
          </ul>
        </div>
      </div>
    </div>
  
  <br>
<%
	if (session.getAttribute("usuario") != null) {

		Sancion s = (Sancion) session.getAttribute("sancion_edit");
		
		String error = "";
		
		if (session.getAttribute("error") != null) {
			error = (String)session.getAttribute("error");
			System.out.println(error);
			session.setAttribute("error", "");
		}
		
		int dia_sancion = 0;
		String mes_sancion = "";
		int año_sancion = 0;
		
		Alumno alumno = null;
		Alumnos alumnos = new Alumnos();
		Boolean empty = false;
		
		if (s != null){			
 			//separo la fecha (1990-01-01) por el "-"" y almaceno el año, mes y dia en un array
			String[] fecha_ent = s.getFecha().split ("-");
			//obtengo el dia, mes y año respectivamente
			dia_sancion = Integer.parseInt(fecha_ent[fecha_ent.length - 1]);
			mes_sancion = fecha_ent[fecha_ent.length - 2];
			año_sancion = Integer.parseInt(fecha_ent[fecha_ent.length - 3]);
				
			alumno = AccionesAlumno.getOne(s.getDni());
		
		}else{
			//alta de sancion
			alumnos = (Alumnos) session.getAttribute("alumnos_sancion");	    	
			dia_sancion = Integer.valueOf((String)session.getAttribute("dia_sys"));
			mes_sancion = (String)session.getAttribute("mes_sys");			
			año_sancion = Integer.valueOf((String)session.getAttribute("año_sys"));
			//alta de sancion
		}		
		
%>
<br>
<%if (s != null){ %>
<div class="page-header">
<h1>Modificación de Sanción</h1>
</div>
<h2><%="Sanción para " + alumno.getNombre() + " " + alumno.getApellido()%></h2>
<%}else if (alumnos.getLista().isEmpty() & error.equals("")){
	empty = true;
%>
<div class="alert alert-info" role="alert">
    <strong>Atención!</strong> No hay alumnos cargados para el año
</div>
<%}else{%>
<div class="page-header">
<h1>Alta de Sanción</h1>
</div>
<%}%>
<div class="form-group">
<form action="SancionEdit" method="post">
<%if (s != null){ %>
<input type="hidden" name="action" value="update">
<%}else{%>
<input type="hidden" name="action" value="alta">
<%}
if (empty == false){
%>
<table class="table table-hover table-bordered">
<%if (s == null){%>
	<tr>
		<td>Alumno</td>
		<td><select name="alumno_sancion">		
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
		<td><select name="dia_sancion">   
			<%  
			for (int i = 1; i <= 31; i++){			  	
 			%>
			 	<option <%= dia_sancion ==i ? "selected" : ""%>><%=i%></option>		 	
   			<%
			}	
			 %>
 			 </select>
  			 <select name="mes_sancion">
  			 <option value="01" <%=mes_sancion.equals("1") ? "selected" : ""%>>Enero</option>
			 <option value="02" <%=mes_sancion.equals("2") ? "selected" : ""%>>Febrero</option>
			 <option value="03" <%=mes_sancion.equals("3") ? "selected" : ""%>>Marzo</option>
			 <option value="04" <%=mes_sancion.equals("4") ? "selected" : ""%>>Abril</option>
			 <option value="05" <%=mes_sancion.equals("5") ? "selected" : ""%>>Mayo</option>
			 <option value="06" <%=mes_sancion.equals("6") ? "selected" : ""%>>Junio</option>
			 <option value="07" <%=mes_sancion.equals("7") ? "selected" : ""%>>Julio</option>
			 <option value="08" <%=mes_sancion.equals("8") ? "selected" : ""%>>Agosto</option>
			 <option value="09" <%=mes_sancion.equals("9") ? "selected" : ""%>>Septiembre</option>
			 <option value="10" <%=mes_sancion.equals("10") ? "selected" : ""%>>Octubre</option>
			 <option value="11" <%=mes_sancion.equals("11") ? "selected" : ""%>>Noviembre</option>
			 <option value="12" <%=mes_sancion.equals("12") ? "selected" : ""%>>Diciembre</option>	   			 		
 			 </select>
 <%if (s != null){ %>
			 <select name="año_sancion">
			<%
			for (int i = 1900; i < 2090; i++){
 			 %>
 			 	<option <%=año_sancion==i ? "selected" : ""%>><%=i%></option>
			<%
			 }
			 %>
  			 </select>
  <%}%>
  		</td>
  	<tr>
		<td>Hora</td>
		<td>
		<select name="hora_sancion">
			 <option value="08:00:00" <%=s != null && s.getHora().equals("08:00:00") ? "selected" : ""%>>08:00</option>
  			 <option value="08:30:00" <%=s != null && s.getHora().equals("08:30:00") ? "selected" : ""%>>08:30</option>
  			 <option value="09:00:00" <%=s != null && s.getHora().equals("09:00:00") ? "selected" : ""%>>09:00</option>
  			 <option value="09:30:00" <%=s != null && s.getHora().equals("09:30:00") ? "selected" : ""%>>09:30</option>
  			 <option value="10:00:00" <%=s != null && s.getHora().equals("10:00:00") ? "selected" : ""%>>10:00</option>
  			 <option value="10:30:00" <%=s != null && s.getHora().equals("10:30:00") ? "selected" : ""%>>10:30</option>
  			 <option value="11:00:00" <%=s != null && s.getHora().equals("11:00:00") ? "selected" : ""%>>11:00</option>
  			 <option value="11:30:00" <%=s != null && s.getHora().equals("11:30:00") ? "selected" : ""%>>11:30</option>
  			 <option value="12:00:00" <%=s != null && s.getHora().equals("12:00:00") ? "selected" : ""%>>12:00</option>
  			 <option value="12:30:00" <%=s != null && s.getHora().equals("12:30:00") ? "selected" : ""%>>12:30</option>
  			 <option value="13:00:00" <%=s != null && s.getHora().equals("13:00:00") ? "selected" : ""%>>13:00</option>
  			 <option value="13:30:00" <%=s != null && s.getHora().equals("13:30:00") ? "selected" : ""%>>13:30</option>
  			 <option value="14:00:00" <%=s != null && s.getHora().equals("14:00:00") ? "selected" : ""%>>14:00</option>
  			 <option value="14:30:00" <%=s != null && s.getHora().equals("14:30:00") ? "selected" : ""%>>14:30</option>
  			 <option value="15:00:00" <%=s != null && s.getHora().equals("15:00:00") ? "selected" : ""%>>15:00</option>
  			 <option value="15:30:00" <%=s != null && s.getHora().equals("15:30:00") ? "selected" : ""%>>15:30</option>
  			 <option value="16:00:00" <%=s != null && s.getHora().equals("16:00:00") ? "selected" : ""%>>16:00</option>
  			 <option value="16:30:00" <%=s != null && s.getHora().equals("16:30:00") ? "selected" : ""%>>16:30</option>
  			 <option value="17:00:00" <%=s != null && s.getHora().equals("17:00:00") ? "selected" : ""%>>17:00</option>
  			 <option value="17:30:00" <%=s != null && s.getHora().equals("17:30:00") ? "selected" : ""%>>17:30</option>  			 
  		</select>  			 
		</td>		
	</tr>
	<tr>
	<td>Motivo</td>	
	<td><textarea rows="4" cols="50" name="motivo_sancion"><%=s != null ? s.getMotivo() : ""%></textarea></td>	
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
<div class="alert alert-warning" role="alert">
   <strong>Cuidado!</strong> <%=error%>
</div>
<br>
<br>
<%}%>
<%
String volver =  "menu_user.jsp";
if (s != null){	
	volver = "sanciones_list.jsp";
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