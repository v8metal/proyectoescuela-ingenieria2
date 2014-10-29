<%@page import="datos.Maestro"%>
<%@page import="datos.Maestro_Grado"%>
<%@page import="datos.Maestros_Grados"%>
<%@page import="datos.Tardanza"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.Alumnos"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Asistencias</title>
<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</head>
<body>
<div class="container">

<%
	if (session.getAttribute("usuario") != null) {

	Maestro maestro = (Maestro)session.getAttribute("maestro");
	String nombre = maestro.getNombre();
	String apellido = maestro.getApellido();
	
	Tardanza asistencia = (Tardanza) request.getAttribute("asistencia");
	Alumnos alumnos = (Alumnos) session.getAttribute("alumnosAltaAsistencia");
	String fecha = (String) session.getAttribute("fechaDisplayAsistencia");
	
	int dia_asistencia = 0;
	String mes_asistencia = "";
	int año_asistencia = 0;
	
	String error = "";
	
	if (session.getAttribute("error") != null) error = (String) session.getAttribute("error");
	
	String accion = "alta";
	
	if (asistencia != null) {
		
		accion = "modificar";
		//recupero la fecha
		String fecha_asistencia = asistencia.getFecha();
		//separo la fecha (1990-01-01) por el "-"" y almaceno el año, mes y dia en un array
		String[] fecha_ent = fecha_asistencia.split ("-");
		//obtengo el dia, mes y año respectivamente
		dia_asistencia = Integer.parseInt(fecha_ent[fecha_ent.length - 1]);
		mes_asistencia = fecha_ent[fecha_ent.length - 2];
		año_asistencia = Integer.parseInt(fecha_ent[fecha_ent.length - 3]);
	}else{	
	
    	dia_asistencia = Integer.valueOf((String)session.getAttribute("dia_sys"));
    	int mes= Integer.parseInt((String) session.getAttribute("mes_sys"));
    	if (mes < 10){
    		mes_asistencia = "0" + mes;	
    	}else{
    		mes_asistencia = "" + mes;
    	}
	}
	%>
	
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
              <li class="active"> <a href="menu_asistencias.jsp">Asistencias</a></li>
              <li class="dropdown">
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
              <li class="active"><a href="CerrarSesion">Salir</a></li>
            </ul>
            <ul>
          		<p class="navbar-text navbar-right"><strong><%= nombre + " " + apellido %></strong></p>
            </ul> 
        </div>
      </div>
    </div>  
  <br>
  
<div class="page-header">
<%
	if(asistencia != null){
		
		Alumno a = AccionesAlumno.getOne(asistencia.getDni());
%>
<h1>Edición de asistencia - <%=a.getNombre() + " " + a.getApellido() + " - " + fecha %></h1>
<%}else{%>
<h1>Alta de asistencia </h1>
<%}%>
</div>
	<div class="form-group">	
	<form action="AsistenciaEdit" method="post">
	<input type="hidden" name=do value="<%=accion%>">
	<%if(asistencia != null){%>
	<input type="hidden" class="form-control" name="alumno_asistencia"value=<%=asistencia.getDni()%>>	
	<%}%>
		 <table class="table table-hover table-bordered">
		    <tr> <%= error %>
		    <%if(asistencia == null){%>
				<td>Fecha </td>
				<td><select name="dia_asistencia" class="form-control" >   
					<%  
					for (int i = 1; i <= 31; i++){			  	
		 			%>
					 	<option <%=dia_asistencia==i ? "selected" : ""%>><%=i%></option>		 	
		   			<%
					}	
					%>
		 			 </select>
		  			 <select id="mes" name="mes_asistencia" class="form-control">
		  			 <option value="03" <%=mes_asistencia.equals("03") ? "selected" : ""%>>Marzo</option>
					 <option value="04" <%=mes_asistencia.equals("04") ? "selected" : ""%>>Abril</option>
					 <option value="05" <%=mes_asistencia.equals("05") ? "selected" : ""%>>Mayo</option>
					 <option value="06" <%=mes_asistencia.equals("06") ? "selected" : ""%>>Junio</option>
					 <option value="07" <%=mes_asistencia.equals("07") ? "selected" : ""%>>Julio</option>
					 <option value="08" <%=mes_asistencia.equals("08") ? "selected" : ""%>>Agosto</option>
					 <option value="09" <%=mes_asistencia.equals("09") ? "selected" : ""%>>Septiembre</option>
					 <option value="10" <%=mes_asistencia.equals("10") ? "selected" : ""%>>Octubre</option>
					 <option value="11" <%=mes_asistencia.equals("11") ? "selected" : ""%>>Noviembre</option>
					 <option value="12" <%=mes_asistencia.equals("12") ? "selected" : ""%>>Diciembre</option>	   			 		
		 			 </select>		  
		  		</td>
		  	</tr>
		  	<tr>		  		
		  		<th>ALUMNO</th>
		  		<td>
		  			<select name="alumno_asistencia" class="form-control" >   
		  			<%
					for (Alumno a : alumnos.getLista()){		 		
		 			%>
		 			<option value=<%=a.getDni() %>><%= a.getNombre() + " " + a.getApellido() %></option>
		 			<%} %>		 		
		 			</select>
		 		</td>		 		
		 	<%}%>
		 	</tr>
		    <tr>
		      <th>OBSERVACIONES:</th>
		      <td><textarea name="observaciones" cols="40" rows="4" class="form-control" placeholder="Observaciones"><%=asistencia!=null?asistencia.getObservaciones():"" %></textarea></td>
		    </tr>
		    <tr>
		      <th>CONDICION:</th>		      
		      <td><input type="text" class="form-control" name="condicion" placeholder="Condicion" value=<%=asistencia!=null?asistencia.getIndicador():"" %>></td>
		    </tr>
		    <tr>
		      <td></td>
		      <td>
		      	  <button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="return confirm('Esta seguro que desea guardar?');">Guardar</button>
		          <button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave" onclick="return confirm('Esta seguro que desea cancelar?');">Cancelar</button> 
		      </td>
		    </tr>  
		  </table>
		  </form>
		  </div>
		  <br>
		  <br>		  	
		 	<div class="form-group">
			<form action="AsistenciaList" method="get">
			<input type="hidden" name="accion" value="listarAsistencias">
			<button type="submit" class="btn btn-primary"  value="Volver al Listado de asistencias">Volver al Listado de asistencias</button>
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