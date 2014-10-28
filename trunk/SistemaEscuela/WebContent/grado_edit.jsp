<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="conexion.AccionesGrado"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<title>Grados</title>
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
              <li class="active" class="dropdown">
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
	if (session.getAttribute("admin") != null) { 
  
  	Grado grado = (Grado) session.getAttribute("grado_edit");
  	Grados grados = (Grados) request.getAttribute("grados_alta"); //agregado
    Maestros maestros = (Maestros) request.getAttribute("maestros_list");
  	Maestro titular = (Maestro)request.getAttribute("maestro_tit");
  	Maestro paralelo = (Maestro)request.getAttribute("maestro_par"); 	
 	
  	int año;
  	
  	if (grado != null){
  	 	año = AccionesGrado.getCurrentYear(grado.getGrado(), grado.getTurno());
  	}else{
  		//año = -1;
  		año = 0;
  	}

if (grado != null){
%>

<div class="page-header">  
	<h1>Edición de grado</h1>
</div> 
<h2><%= grado.getGrado() + " - Turno " + grado.getTurno() %></h2>
<%}else{%>
<div class="page-header">  
	<h1>Alta de grado</h1>
</div> 
<%}%>
<div class="form-group">
 <form action="GradoEdit" method="post">
<%if (grado != null){
   	if (maestros != null){%>
	<input type="hidden" name="action" value="update">
	<%}else{%>
	<input type="hidden" name="action" value="update">
	<%
	}
}else{%>
<input type="hidden" name="action" value="insert">
<%}%>
<table class="table table-hover table-bordered">
<% 
	if (grado == null){
%>
	<tr>
		<td>Grado/Turno: </td>
		<td>
			<select name=anio_grado_turno class="form-control">
<% 			
			
			for (Grado g : grados.getLista()){ %>

			 <option value="<%=g.getGrado() + "-" + g.getTurno()%>"><%=g.getGrado() + "-" + g.getTurno()%></option>
			   
<%          } %>		 	   		 
 			 </select> 
 		</td>
	</tr>
<%}%>
	<tr>
		<td>Tipo de Calificación: </td>
		<td>
			<% 
			   String ck_bim = "";
			   String ck_tri = "";			   
			   
			   if (grado != null && grado.getBimestre()) {
				   ck_bim = "checked";
			   } else {
				   ck_tri = "checked";
			   }			           
			 	
			 %>
			<input type="radio" name="bimestral" value="si" <%=ck_bim%> /> Bimestral
			<input type="radio" name="bimestral" value="no" <%=ck_tri%>/> Trimestral
		</td>
	</tr>
		<tr>
		<td>Tipo de Evaluación: </td>
		<td>
			<% 
			   String ck_informe = "";
			   String ck_cualitaviva = "";
			   String ck_numerica = "";
			   
			   ck_informe = "checked";
			   
			   if (grado != null && grado.getEvaluacion() == 0) {
				   ck_informe = "checked";
				   ck_cualitaviva = "";
				   ck_numerica = "";
			   }
			   
			   if (grado != null && grado.getEvaluacion() == 1) {
				   ck_cualitaviva = "checked";
				   ck_informe = "";
				   ck_numerica = "";
			   }
			   
			   if (grado != null && grado.getEvaluacion() == 2) {
				   ck_informe = "";
				   ck_cualitaviva = "";
				   ck_numerica = "checked"; 
	
			   }			           
			 	
			 %>
			<input type="radio" name="evaluacion" value=0 <%=ck_informe%> /> Informe
			<input type="radio" name="evaluacion" value=1 <%=ck_cualitaviva%>/> Cualitativa
			<input type="radio" name="evaluacion" value=2 <%=ck_numerica%>/> Numérica
		</td>
	</tr>
	<tr>
		<td>Salón: </td>
		<td><input class="form-control" type="text" placeholder="Salon" name="salon_grado" value="<%=grado!=null? grado.getSalon() : ""%>"></td>
	</tr>
	<tr>
		<td>Maestro Titular: </td>
<% if (año > 0){%>
		<td><select name="maestro_tit_grado" class="form-control" placeholder="Maestro Titular" >
		<% if (grado != null && titular != null){ %>
			<option value="<%= titular.getDni()%>"><%=titular.getNombre()+ " " + titular.getApellido()%> </option>
			<%
			for (Maestro m : maestros.getLista()){
				
				if (m.getDni() != titular.getDni()){ //elimina el maestro titular duplicado de la lista
			 		
 			 %>   
 			  
   			   <option value="<%=m.getDni()%>"><%=m.getNombre()+ " " + m.getApellido()%> </option>   			  
   			  <%   			
			 	}
			}
			
		}else{
			
			for (Maestro m : maestros.getLista()){			 		
 			%>   
 			  
   			   <option value="<%=m.getDni()%>"><%=m.getNombre()+ " " + m.getApellido()%> </option>   			  
   			 <%
			}
		}	
			 %>
			 </select>
<%}else{%>
		<td>Asignar alumnos antes</td>
<%}%>	
	</tr>
	<tr>
		<td>Maestro Paralelo: </td>
<% if (año > 0){%>
		<td><select name="maestro_par_grado" class="form-control"  placeholder="Maestro Paralelo">
		<% if (grado != null && paralelo != null){ %>
			<option value="<%= paralelo.getDni()%>"><%=paralelo.getNombre()+ " " + paralelo.getApellido()%> </option>						
			<%
			for (Maestro m : maestros.getLista()){			 	
				if (m.getDni() != paralelo.getDni()){	//elimina el maestro titular suplente de la lista
 			 %>
   			   <option value="<%=m.getDni()%>"><%=m.getNombre()+ " " + m.getApellido() %></option>
   			 <%
			 	}
			}
		}else{			
			for (Maestro m : maestros.getLista()){		
 			 %>
   			   <option value="<%=m.getDni()%>"><%=m.getNombre()+ " " + m.getApellido() %></option>
   			 <%			 
			}
		}
		%>
		</select>
<%}else{%>
		<td>Asignar alumnos antes</td>
<%}%>		 
	</tr>
</table>
<br>
<%
	String mensaje= "return confirm('Esta seguro que desea realizar el alta?');"; 
	  
	if (grado != null){
			
		mensaje = "return confirm('Esta seguro que desea modificar?');"; 
	}
		 
%>
	<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="<%=mensaje%>">Guardar</button>
	<button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave" onclick="return confirm('Esta seguro que desea cancelar?');">Cancelar</button>	
</form>
</div>
<br>
<%if (año == 0 && grado != null){%>
<a>No hay alumnos asignados, el grado se puede </a><a href="GradoEdit?do=baja">borrar</a>
<br>
<br>
<%}%>
<div class="form-group">
<form action="GradoList" method="get">
<button type="submit" class="btn btn-primary"  value="Volver al Listado">Volver al Listado</button>
</form>
</div>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</div>
</body>
<script language = "JavaScript">
function pru(){
p=document.anio_grado.selectedIndex;
alert(p);
}
</script>
</html>