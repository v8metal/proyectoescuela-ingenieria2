<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<title>Maestros</title>
</head>
<body>

<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "menu_admin.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
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
              <li class="active" class="dropdown">
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
              <li><a href="menu_tardanzas.jsp">Tardanzas</a></li>
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
  
<%		
		Maestro maestro = (Maestro)request.getAttribute("maestro");

  	//get the maestro object from the request
  	
  		String accion = "alta";
  	
  		if (maestro != null){
  			accion = "modificar";
%>
<div class="page-header">  
	<h1>Edición de Maestro</h1>
</div> 
	   <%}else{%>
<div class="page-header">  
	<h1>Alta de Maestro</h1>
  </div> 
  	 
 		<%}%>  
 		
	<div class="form-group">
	
	<form action="maestroEdit" method="post">
	
	<input type="hidden" name="accion" value="<%=accion%>">
	
		<table class="table table-hover table-bordered">
		
			<tbody>
				<tr>
				    <td><label for="input">Apellido:</label></td>
         			<td><input type="text" class="form-control" name="apellido" placeholder="Apellido" required value="<%=maestro!=null? maestro.getApellido() : ""%>"></td>
         		</tr>
         		
         		<tr>
				    <td><label for="input">Nombre:</label></td>
         			<td><input type="text" class="form-control" name="nombre" placeholder="Nombre" required value="<%=maestro!=null ? maestro.getNombre() : ""%>"></td>
         		</tr>					
							
				<tr>
					<% if(maestro != null){%>
					<td><label for="input">D.N.I.:</label></td>					
					<td><input readonly type="text" class="form-control" name="dni" placeholder="Dni" value="<%=maestro.getDni()%>"></td>
					<%}else{%>					
					<td><label for="input">D.N.I.:</label></td>
         			<td><input type="text" class="form-control" name="dni" required placeholder="Dni" value=""></td>
					<%}%>
				</tr>

				<tr>
				    <td><label for="input">Domicilio:</label></td>
         			<td><input type="text" class="form-control" name="domicilio" placeholder="Domicilio"  required value="<%=maestro!=null ? maestro.getDomicilio() : ""%>"></td>
         		</tr>				
					
				<tr>
				    <td><label for="input">Teléfono:</label></td>
         			<td><input type="text" class="form-control"  name="telefono" placeholder="Teléfono" required value="<%=maestro!=null ? maestro.getTelefono() : ""%>"></td>
         		</tr>				
			</tbody>
		</table>
		<!-- MENSAJE DE CONFIRMACION -->
		<%
		String mensaje= "return confirm('Esta seguro que desea realizar el alta?');"; 
		  
		if (maestro != null){
			
			mensaje = "return confirm('Esta seguro que desea modificar?');"; 
		}
		 
		%>
		<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="<%=mensaje%>">Guardar</button>
		<button type="reset" class="btn btn-primary"  value="Cancelar" name="btnCancel">Cancelar</button>	
	</form> 
	</div>
 <br>
 <br>
 <!-- MENSAJE DE ERROR -->
 <%	String error = "";
	
	if (session.getAttribute("error") != null) {
		error = (String)session.getAttribute("error");
		session.setAttribute("error", null);		
	
 %>
   <div class="bs-example">
    	 <div class="alert alert-danger fade in" role="alert">
     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <strong>Ups!</strong> <%= error %>
  	  </div>
  </div><!-- /example -->
<br> 	
 <% } %>
<strong><a href="maestroList" class="alert-link">Volver a materias</a></strong>

</div>
</body>
</html>