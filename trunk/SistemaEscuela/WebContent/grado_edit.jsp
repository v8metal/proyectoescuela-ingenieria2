<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="conexion.AccionesGrado"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "grados");%>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<title>Grados</title>
</head>
<body>
<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>
   
<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "grado_edit.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	} 
  
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
<h3><%= grado.getGrado() + " - Turno " + grado.getTurno() %></h3>
<br>
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
		<td><label for="input">Grado/Turno</label></td>
		<td>
			<div class="col-xs-4">
			<select name=anio_grado_turno class="form-control" autofocus>
<% 			
			
			for (Grado g : grados.getLista()){ %>

			 <option value="<%=g.getGrado() + "-" + g.getTurno()%>"><%=g.getGrado() + "-" + g.getTurno()%></option>
			   
<%          } %>		 	   		 
 			 </select> 
 			 </div>
 		</td>
	</tr>
<%}%>
	<tr>
		<td><label for="input">Tipo de Calificación</label></td>
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
			 <div class="col-xs-6">
				<label class="radio-inline"> 
					<input type="radio" name="bimestral" value="si" <%=ck_bim%> /> Bimestral
				</label>
				<label class="radio-inline">
					<input type="radio" name="bimestral" value="no" <%=ck_tri%>/> Trimestral
				</label>
			</div>
		</td>
	</tr>
		<tr>
		<td><label for="input">Tipo de Evaluación</label></td>
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
			 <div class="col-xs-6">
			<label class="radio-inline"> 
			<input type="radio" name="evaluacion" value=0 <%=ck_informe%> /> Informe
			</label>
			<label class="radio-inline">
			<input type="radio" name="evaluacion" value=1 <%=ck_cualitaviva%>/> Cualitativa
			</label>
			<label class="radio-inline">
			<input type="radio" name="evaluacion" value=2 <%=ck_numerica%>/> Numérica
			</label>
			</div>
		</td>
	</tr>
	<tr>
		<td><label for="input">Salón</label></td>
		<td>
			<div class="col-xs-2">
			<input class="form-control" type="text" placeholder="Salón" name="salon_grado" required value="<%=grado!=null? grado.getSalon() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td><label for="input">Maestro Titular</label></td>
<% if (año > 0){%>
		<td>
		<div class="col-xs-6">
		<select name="maestro_tit_grado" class="form-control" placeholder="Maestro Titular" >
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
			 </div>
<%}else{%>
		<td class="warning">
			<div class="col-xs-6">
				<strong> Asignar alumnos antes <i class="glyphicon glyphicon-warning-sign"></i></strong>
			</div>
		</td>
<%}%>	
	</tr>
	<tr>
		<td><label for="input">Maestro Paralelo</label></td>
<% if (año > 0){%>
		<td>
		<div class="col-xs-6">
		<select name="maestro_par_grado" class="form-control"  placeholder="Maestro Paralelo">
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
		</div>
<%}else{%>
		<td class="warning">
			<div class="col-xs-6">
				<strong> Asignar alumnos antes <i class="glyphicon glyphicon-warning-sign"></i></strong>
			</div>
		</td>
<%}%>		 
	</tr>
</table>

<%
	String mensaje= "return confirm('¿Está seguro que desea realizar el alta?');"; 
	  
	if (grado != null){
			
		mensaje = "return confirm('¿Está seguro que desea editar?');"; 
	}
		 
%>
	<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="<%=mensaje%>"><i class="glyphicon glyphicon-floppy-disk"></i> Guardar</button>
	<button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave" onclick="return confirm('¿Está seguro que desea cancelar?');"><i class="glyphicon glyphicon-remove"></i> Cancelar</button>	
</form>
</div>
<br>
<%if (año == 0 && grado != null){%>
<!-- MENSAJE DE WARNING -->
	<div class="alert alert-warning" role="alert">
	  <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <strong><i class="glyphicon glyphicon-warning-sign"></i> Cuidado!</strong> No hay alumnos asignados. <a href="GradoEdit?do=baja" class="alert-link"> Borrar grado <i class="glyphicon glyphicon-trash"></i></a>
    </div>
<br>
<%}%>
<div class="form-group">
<form action="GradoList" method="get">
<button type="submit" class="btn btn-primary"  value="Volver al Listado"><i class="glyphicon glyphicon-share-alt"></i> Volver al Listado</button>
</form>
</div>
</div>
</body>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

	<!-- menú superior -->
	<script src="js/menu_admin.js"></script> 
	
    <script language = "JavaScript">
		function pru(){
		p=document.anio_grado.selectedIndex;
		alert(p);
		}	
	</script>
</html>