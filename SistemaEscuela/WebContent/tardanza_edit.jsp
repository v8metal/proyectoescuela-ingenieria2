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
<title>Listado de Tardanzas</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

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
            <li><a href="menu_admin.jsp">Menú</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Alumnos <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="menu_listado_alum.jsp">Listado</a></li>
                  <li><a href="alumno_edit.jsp">Nuevo alumno</a></li>          
                  <li class="divider"></li>
                  <li class="dropdown-header">Nav header</li>
                  <li><a href="alumnoInactivo?do=listar">Registro de bajas</a></li>
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Grados <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="GradoList?listar=mañana">Turno mañana</a></li>                 
                  <li><a href="GradoList?listar=tarde">Turno tarde</a></li>          
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Maestros <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="maestroList">Listado</a></li>
                  <li><a href="maestroEdit?accion=alta">Nuevo maestro</a></li>          
                  <li class="divider"></li>
                  <li><a href="MaestroList?tipo=inactivos">Registro de bajas</a></li>
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Materias <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="materiaList?from=menu_admin">Listado</a></li>
                  <li><a href="materiaEdit?do=alta">Nueva materia</a></li>          
                  <li class="divider"></li>
                  <li><a href="materiaList?from=materia_inactiva_list">Materias inactivas</a></li>
                </ul>
              </li>
              <li class="active"><a href="menu_tardanzas.jsp">Tardanzas</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Entrevistas <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="EntrevistaList">Listado</a></li>
                  <li><a href="EntrevistaEdit?do=alta">Nueva entrevista</a></li>          
                </ul>
              </li>
              <li><a href="menu_cuotas.jsp">Cuotas</a></li>
              <li><a href="UsuarioList">Usuarios</a></li>
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
  <br>

<div class="page-header">
<%
	if (session.getAttribute("admin") != null) {
%>
<center>
<%
	Tardanza tardanza = (Tardanza) request.getAttribute("tardanza");
	Alumnos alumnos = (Alumnos) session.getAttribute("alumnosAltaTardanza");
	
	int dia_tardanza = 0;
	String mes_tardanza = "";
	int año_tardanza = 0;
	
	String error = "";
	
	if (session.getAttribute("error") != null) error = (String) session.getAttribute("error");
	
	String accion = "alta";
	
	if (tardanza != null) {
		
		accion = "modificar";
		//recupero la fecha
		String fecha_tardanza = tardanza.getFecha();
		//separo la fecha (1990-01-01) por el "-"" y almaceno el año, mes y dia en un array
		String[] fecha_ent = fecha_tardanza.split ("-");
		//obtengo el dia, mes y año respectivamente
		dia_tardanza = Integer.parseInt(fecha_ent[fecha_ent.length - 1]);
		mes_tardanza = fecha_ent[fecha_ent.length - 2];
		año_tardanza = Integer.parseInt(fecha_ent[fecha_ent.length - 3]);
	}else{	
	
    	dia_tardanza = Integer.valueOf((String)session.getAttribute("dia_sys"));
    	int mes= Integer.parseInt((String) session.getAttribute("mes_sys"));
    	if (mes < 10){
    		mes_tardanza = "0" + mes;	
    	}else{
    		mes_tardanza = "" + mes;
    	}
	}

	if(tardanza != null){
		Alumno a = AccionesAlumno.getOne(tardanza.getDni());
%>
<h1>Edición de Tardanza - <%=a.getNombre() + " " + a.getApellido() %></h1>
<%}else{%>
<h1>Alta de Tardanza </h1>
<%}%>
</center>
</div>
	<div class="form-group">	
	<form action="TardanzaEdit" method="post">
	<input type="hidden" name=do value="<%=accion%>">
		 <table class="table table-hover table-bordered">
		    <tr> <%= error %>
				<td>Fecha </td>
				<td><select name="dia_tardanza" class="form-control" >   
					<%  
					for (int i = 1; i <= 31; i++){			  	
		 			%>
					 	<option <%=dia_tardanza==i ? "selected" : ""%>><%=i%></option>		 	
		   			<%
					}	
					%>
		 			 </select>
		  			 <select id="mes" name="mes_tardanza" class="form-control">
		  			 <option value="01" <%=mes_tardanza.equals("01") ? "selected" : ""%>>Enero</option>
					 <option value="02" <%=mes_tardanza.equals("02") ? "selected" : ""%>>Febrero</option>
					 <option value="03" <%=mes_tardanza.equals("03") ? "selected" : ""%>>Marzo</option>
					 <option value="04" <%=mes_tardanza.equals("04") ? "selected" : ""%>>Abril</option>
					 <option value="05" <%=mes_tardanza.equals("05") ? "selected" : ""%>>Mayo</option>
					 <option value="06" <%=mes_tardanza.equals("06") ? "selected" : ""%>>Junio</option>
					 <option value="07" <%=mes_tardanza.equals("07") ? "selected" : ""%>>Julio</option>
					 <option value="08" <%=mes_tardanza.equals("08") ? "selected" : ""%>>Agosto</option>
					 <option value="09" <%=mes_tardanza.equals("09") ? "selected" : ""%>>Septiembre</option>
					 <option value="10" <%=mes_tardanza.equals("10") ? "selected" : ""%>>Octubre</option>
					 <option value="11" <%=mes_tardanza.equals("11") ? "selected" : ""%>>Noviembre</option>
					 <option value="12" <%=mes_tardanza.equals("12") ? "selected" : ""%>>Diciembre</option>	   			 		
		 			 </select>		  
		  		</td>
		  	</tr>
		  	<tr>		  		
		  		<%if(tardanza ==null){%>
		  		<th>ALUMNO</th>
		  		<td>
		  			<select name="alumno_tardanza" class="form-control" >   
		  			<%
					for (Alumno a : alumnos.getLista()){		 		
		 			%>
		 			<option value=<%=a.getDni() %>><%= a.getNombre() + " " + a.getApellido() %></option>
		 			<%} %>		 		
		 			</select>
		 		</td>
		 		<%}else{%>		 		
		 		<td><input type="hidden" class="form-control" name="alumno_tardanza"value=<%=tardanza.getDni()%>></td>
		 		<td><input type="hidden" class="form-control" name="fecha_tardanza"value=<%=tardanza.getFecha()%>></td>
		 		<%}%>
		 	</tr>
		    <tr>
		      <th>OBSERVACIONES:</th>
		      <td><textarea name="observaciones" cols="40" rows="4"><%=tardanza!=null?tardanza.getObservaciones():"" %></textarea></td>
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
		  <center> 			
		 	<div class="form-group">
			<form action="TardanzaList" method="get">
			<input type="hidden" name="accion" value="listarTardanzas">
			<button type="submit" class="btn btn-primary"  value="Volver al Listado de Tardanzas">Volver al Listado de Tardanzas</button>
			</form>
			</div>
		  	<br>
		  	<br>
		  </center>		  
		  	<div class="form-group">
					<form action="CerrarSesion" method="get">
			<button type="submit" class="btn btn-primary"  value="Cerrar Sesión">Cerrar Sesión</button>
			</form>
			</div>
<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>			
<%
} else {
	response.sendRedirect("login.jsp");
}
%> 
</div>
</body>
</html>