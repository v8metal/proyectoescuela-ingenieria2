<%@page import="datos.PrecioMes"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Precios Mensuales</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

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
	if (AccionesUsuario.validarAcceso(tipo, "precioMes_edit.jsp") != 1){							
	response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}

	PrecioMes precio = null;
	int ind = 0;
	int año =  (Integer) session.getAttribute("añoPrecios");
	
	if ((PrecioMes)session.getAttribute("ultimoMes") != null){
		precio = (PrecioMes)session.getAttribute("ultimoMes");
    }else{
    	ind = 1;
    	precio = (PrecioMes)session.getAttribute("mesModific");
    }
    
 %>
	<center>
	<div class="page-header"> 		
	
<%if (ind == 0){%>

	<h1>Ingreso de Precios Mensuales - <%=año%></h1>
	
<%}else{%>
	  
	<h1>Modificación de Precios Mensuales - <%=año%></h1>
			
<%}%> 
	</div>
    
    <div class="form-group">
    <form action="PrecioEdit" method="post" id="formPrecio" onsubmit="return validarPrecio()">
      
      <table class="table table-hover table-bordered">

		<% 
	      String [] meses = new String[12];
	      meses[0]="Enero";
	      meses[1]="Febrero";
	      meses[2]="Marzo";
	      meses[3]="Abril";
	      meses[4]="Mayo";
	      meses[5]="Junio";
	      meses[6]="Julio";
	      meses[7]="Agosto";
	      meses[8]="Septiembre";
	      meses[9]="Octubre";
	      meses[10]="Noviembre";
	      meses[11]="Diciembre";
        	  %>
        	  
        <tr>
          <th>Mes Desde:</th>
          <td>
          <%if (ind == 0){ //controla si es un mes nuevo o no%>
            <input type="text" readonly value="<%=precio!=null?meses[precio.getMes()]:meses[2]%>" name="mes">
          <%}else{ %>
            <input type="text" readonly value="<%=precio!=null?meses[precio.getMes()-1]:meses[2]%>" name="mes">
          <%} %>
          </td>        
        <tr>
          <th>Precio Regular:</th>
          <td><input type="text" class="form-control" placeholder="Precio Regular" name="regular" value="<%=precio!=null?precio.getRegular():"" %>"></td>
        </tr>
        <tr>
          <th>Precio de Grupo:</th>
          <td><input type="text" class="form-control" placeholder="Precio Grupo" name="grupo" value="<%=precio!=null?precio.getGrupo():""%>"></td>
        </tr>
        <tr>
          <th>Precios de Hijos:</th>
          <td><input type="text" class="form-control" placeholder="Precio Hijos" name="hijos" value="<%=precio!=null?precio.getHijos():""%>"></td>
        </tr>
        <tr>
          <th>Recargo:</th>
          <td><input type="text" class="form-control" placeholder="Recargo Mensual" name="recargo" value="<%=precio!=null?precio.getRecargo():""%>"></td>
        </tr>
        <tr>
         <td></td>
         <td>
             <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnSave" onclick="return confirm('Esta seguro que desea guardar?');">Aceptar</button>         	 
             <button type="reset" class="btn btn-primary"   value="Cancelar" name="btnSave" onclick="return confirm('Esta seguro que desea cancelar?');">Cancelar</button>
             <input type="hidden" name="error" value="ERROR!!!">
         </td>
       </tr>
      </table>
    </form>
    </div>
    <br>
    <div class="form-group">
		<form action="PrecioList" method="get">
		<button type="submit" class="btn btn-primary"  value="Volver al Menú de precios">Volver al Menú de precios</button>
		</form>
	</div>
	</center> 
  <%String error = (String)session.getAttribute("error");
    if(error!=null){
    	 %>
    	<center><h3><%=error %></h3></center>
    	 <% 
    	 session.setAttribute("error", null);
    }
    %>    
   <script type="text/javascript">
 var form = document.getElementById("formPrecio");
 function validarPrecio(){
	// var año = form.año.value;
	 var mes = form.mes.value;
	 var regular = form.regular.value;
	 var grupo = form.grupo.value;
	 var hijos=form.hijos.value;
	 var recargo = form.recargo.value;
	 
	 if(año=='' || mes=='' || regular=='' || grupo=='' || hijos=='' || recargo==''){
		 alert("Debe completar todos los campos");
		 return false;
	 }
	 
	 else if(isNaN(regular)){
		 alert('Debe ingresar sólo números');
		 return false;
	 }
	 else if(isNaN(grupo)){
		 alert('Debe ingresar sólo números');
		 return false;
		 }
	 else if(isNaN(hijos)){
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