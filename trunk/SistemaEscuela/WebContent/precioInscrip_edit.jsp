<%@page import="datos.PrecioInscrip"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Precios Inscripciones</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<!--<link rel="stylesheet" href="style/jquery-ui.css">  con ese no se ven las flechitas-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="js/jquery-1.10.2.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/entrevista.js"></script> <!-- DatePic para entrevistas -->

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
              <li><a href="menu_tardanzas.jsp">Tardanzas</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Entrevistas <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="EntrevistaList">Listado</a></li>
                  <li><a href="EntrevistaEdit?do=alta">Nueva entrevista</a></li>          
                </ul>
              </li>
              <li class="active"><a href="menu_cuotas.jsp">Cuotas</a></li>
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
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "precioInscrip_edit.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
	
	
	int año = 0;
	
	PrecioInscrip precio = (PrecioInscrip)session.getAttribute("precioInscrip");
	año = (Integer) session.getAttribute("añoPrecios");
	
    %>
    
   <div class="page-header">
   <%if (precio == null){%>
		
	<h1>Ingreso de Precios - Inscripción <%=año%></h1>
	
<%}else{%>
	  
	<h1>Modificación de Precios - Inscripción <%=año%></h1>
			
<%}%> 
	</div>
	
	<div class="form-group">
	    
    <form action="PrecioEdit" method="post" id="formPrecio" onsubmit="return validarPrecio()">
    <input name="fecha" id="fecha" type="hidden" value="<%=precio!=null?precio.getFecha_max() :"0"%>">
    
      <table class="table table-hover table-bordered">
		<tr>
			<th><label for="input">Fecha:</label></th>			
			<td>
			<div class="col-xs-5">
			<input class="form-control" type="text" id="datepicker" required autofocus name="fecha_inscrip">
			</div>
			</td>			
	    </tr>
		<tr>
          <td>Precio:</td>          
          <td>
          <div class="col-xs-5">
          	<input type="text" class="form-control" placeholder="Precio Regular" name="regular" value="<%=precio!=null?precio.getPrecio():"" %>">
		   </div>          	
          </td>
          
        </tr>
        
        <tr>
          <td>Recargo</td>
          <td>
          <div class="col-xs-5">
          <input type="text" class="form-control" placeholder="Recargo" name="recargo" value="<%=precio!=null?precio.getRecargo():""%>">
          </div>
          </td>
        </tr>        
      </table>      
      <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnSave" onclick="return confirm('Esta seguro que desea guardar?');">Aceptar</button>
      <button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave" onclick="return confirm('Esta seguro que desea cancelar?');">Cancelar</button>         
      <input type="hidden" name="error" value="ERROR!!!">
    </form>
    </div>    
    <br>
    <br>    
  	<div class="form-group">
		 <form action="PrecioList" method="get">
			<button type="submit" class="btn btn-primary"  value="Volver al Menú de Precios">Volver al Menú de Precios</button>
		</form>
	</div>	 
  <%String error = (String)session.getAttribute("error");
    if(error!=null){ %>
    	<center><h3><%=error %></h3></center>
    	 <% 
    	 session.setAttribute("error", null);
    }
    %>    
 <script type="text/javascript">
 var form = document.getElementById("formPrecio");
 
 function validarPrecio(){
	 var año = form.año_inscrip.value;
	 var mes = form.mes_inscrip.value;
	 var dia = form.dia_inscrip.value;
	 var regular = form.regular.value;	 
	 var recargo = form.recargo.value;
	 
	 if(año=='' || mes=='' || dia=='' || regular=='' || recargo==''){
		 alert("Debe completar todos los campos");
		 return false;
	 }
	 
	 else if(isNaN(regular)){
		 alert('Debe ingresar sólo números');
		 return false;
	 }
	 else if(isNaN(recargo)){
		 alert('Debe ingresar sólo números');
		 return false;	
	 
	 }else{
		 return true;
	 }
	 
}
 
</script>
</div>
</body>
</html>