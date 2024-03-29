<%@page import="datos.*"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesGrado"%>
<%@page import="conexion.AccionesMensaje"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>

<%session.setAttribute("modulo", "alumnos");%>
			
<meta name="viewport" content="width=device-width; initial-scale=1.0">
<title>Editar Alumno</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<!-- <link rel="stylesheet" href="style/jquery-ui.css"> --> 
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css"> 

</head>
<body>

<div class="container"> 	

  <div id="divmenu">
  	<!-- sirve para visualizar el men� superior -->
  </div>	 
  
<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "alumno_edit.jsp") != 1){							
		response.sendRedirect("Login");						
	}	
	
	//Datos del grado cuando se accede desde el listado por grado
	String grado = null;
	String turno = null;
	Integer a�o = null;
	Grados grados = null;
	
	grado = (String) session.getAttribute("grado_alta");
	turno = (String) session.getAttribute("turno_alta");
	grados = (Grados) session.getAttribute("grados_alta");
	
	if(session.getAttribute("a�oAlta") != null){
		a�o = (Integer) session.getAttribute("a�oAlta");
	}
	
	String nuevo = "";
	
	if (request.getParameter("do") != null){
		nuevo = request.getParameter("do");
	}
	
	//recupero de la sesion la fecha del sistema
	int a�o_sys = Integer.parseInt((String)session.getAttribute("a�o_sys"));
	
	if(nuevo.equals("nuevo")){ //cuando se accede directamente a nuevo
		session.removeAttribute("grado_alta");
		session.removeAttribute("turno_alta");
		session.removeAttribute("grados_alta");
		a�o = AccionesAlumno.getA�oAlumnos("MAX");
		
		//if (a�o == 0) a�o = a�o_sys;
		grados = AccionesGrado.getAll();
	}
	//Datos del grado cuando se accede desde el listado por grado
	
	//se remueven los atributos para que no queden colgados
	session.removeAttribute("grado_alta");
	session.removeAttribute("turno_alta");
	//session.removeAttribute("a�oAlta"); //ver si esta ok comentarlo o no
	//se remueven los atributos para que no queden colgados

  	Padre tutor = (Padre)request.getAttribute("tutor");
    Padre madre = (Padre)request.getAttribute("madre");
    Alumno alumno = null;
    Alumno hermano = null;
    Integer dias = 8;
    
	Integer ind = null;
	
	String mensaje = "";
	String fecha_ing = null;
	
    if (request.getAttribute("alumno") != null){
    	 
    	alumno = (Alumno) request.getAttribute("alumno");
    	fecha_ing = (String) request.getAttribute("fecha_ingreso");
    	
    	if (request.getAttribute("diasAlta") != null){
    		dias = (Integer) request.getAttribute("diasAlta");
    	}
    	
    	ind = 0;
    }
	
	
	//para la carga de un hermano
	if(tutor != null){
		session.setAttribute("tutor", tutor);
		session.setAttribute("madre", madre);
		session.setAttribute("alumno", alumno);
	}
	
	//para la carga de un hermano
	if(alumno == null && session.getAttribute("tutor") != null){
	
		ind = 1; //para cargar los datos de apellido, direccion, telefono
		
		tutor = (Padre)session.getAttribute("tutor");
		madre = (Padre)session.getAttribute("madre");
		alumno = (Alumno)session.getAttribute("alumno");
		
		hermano = alumno;
	
		session.removeAttribute("tutor");
		session.removeAttribute("madre");
		session.removeAttribute("alumno");
		
	}
		

	String reingreso = null;
	reingreso = (String) session.getAttribute("reingreso");
	
	String cabecera = "";
	int ind_reingreso = 0;
	
	//if(ind != null){ 
	if(ind != null){

		if(ind != 1){
			
		
		if(reingreso == null){
			cabecera = "Edici�n de Alumno";
		}else{
			ind_reingreso = 1;
			cabecera = "Reingreso de Alumno";

		}
		
		}else{
			cabecera = "Alta de Alumno";
		}

	}else{

		cabecera = "Alta de Alumno";

	}
	
  %>
<div class="page-header"> 
<h1>Ficha identificatoria del alumno - <%=cabecera%></h1>
</div>

<%if(grados.getLista().isEmpty()){
	Mensaje m = AccionesMensaje.getOne(62);%>
	<div class="alert <%=m.getTipo() %>" role="alert">
  	<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
  	<%=m.getMensaje()%>
</div>
<%}%>

<div class="form-group">  
<form action="alumnoEdit" method="post" class="alumno-alta">
<input name="fecha1" id="fecha1" type="hidden" value="<%=alumno!=null? alumno.getFecha_nac() : "0"%>">
<input name="fecha2" id="fecha2" type="hidden" value="<%=alumno!=null?tutor.getFecha_nac() : "0"%>">
<input name="fecha3" id="fecha3" type="hidden" value="<%=alumno!=null?madre.getFecha_nac() : "0"%>">
<input name="fecha4" id="fecha4" type="hidden" value="<%=fecha_ing!=null?fecha_ing: "0"%>">

<%if(ind_reingreso == 1){
	session.removeAttribute("reingreso");%>
<input type="hidden" name="reingreso" value="reingreso">
<%}%>
<h2>Datos personales:</h2>
<table>
	<tr>
		<td>
			<label for="input">Apellido: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="apellido_alum" required autofocus value="<%=alumno!=null? alumno.getApellido() : ""%>">
			</div>	
		</td>
	<tr>
		<td>
			<label for="input">Nombres: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="nombre_alum" required value="<%=(alumno!=null&&ind==0)? alumno.getNombre() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Lugar de nacimiento: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="lugar_nac_alum" required value="<%=alumno!=null? alumno.getLugar_nac() : ""%>">
			</div>	
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Fecha de Nacimiento:</label>
		</td>			
		<td>
			<div class="col-xs-10"> 
				<input class="form-control" type="text" id="datepicker" required name="fecha_nac_alum">
			</div>
		</td>			
	</tr>
	<tr>
		<td>
			<label for="input">D.N.I.: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="dni_alum" required value="<%=alumno!=null&&ind==0? alumno.getDni() : ""%>">
			</div>	
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Domicilio: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="domicilio_alum" required value="<%=alumno!=null? alumno.getDomicilio() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Tel�fono: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="telefono_alum" value="<%=alumno!=null? alumno.getTelefono() : ""%>">
			</div>	
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Escolaridad: </label>
		</td>
		<td>
			<div class="col-xs-10">	 
				<label class="radio-inline"> 
					<input type="radio"  name="esc" value="Inicial" required <%=alumno!=null && alumno.getEsc().equals("Inicial") ? "checked" : ""%> /> Inicial
				</label>
				<label class="radio-inline"> 		
					<input type="radio"  name="esc" value="Primaria" required <%=alumno!=null && alumno.getEsc().equals("Primaria") ? "checked" : ""%>/> Primaria
				</label>
			</div>	
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Grupo Familiar: </label>
		</td>
		<td>
			<div class="col-xs-10">	
				<label class="radio-inline"> 
					<input type="radio"  name="ind_grupo" value="si" required <%=alumno!=null && alumno.isInd_grupo() ? "checked" : ""%>/> Si
				</label>
				<label class="radio-inline"> 
					<input type="radio"  name="ind_grupo" value="no" required <%=alumno!=null && !alumno.isInd_grupo() ? "checked" : ""%>/> No 
				</label>	
			</div>		
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Subsidio: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<label class="radio-inline"> 
					<input type="radio" name="ind_subsidio" value="si" required <%=alumno!=null && alumno.isInd_subsidio() ? "checked" : ""%>/> Si
				</label>
				<label class="radio-inline"> 
					<input type="radio" name="ind_subsidio" value="no" required <%=alumno!=null && !alumno.isInd_subsidio() ? "checked" : ""%>/> No
				</label>
			</div>	
		</td>
	</tr>
</table>
<br>
<h2>Datos de la familia</h2>
<h3>Padre o Tutor:</h3>
<table>	
	<tr>
		<td>
			<label for="input">Apellido: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="apellido_tutor" required autofocus value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getApellido() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Nombres: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="nombre_tutor" required value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getNombre() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Lugar de nacimiento: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="lugar_nac_tutor" required value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getLugar_nac() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Fecha de Nacimiento:</label>
		</td>			
		<td>
			<div class="col-xs-10">
				<input class="form-control" type="text" id="datepicker2" required name="fecha_nac_tutor">
			</div>
		</td>			
 	</tr>
	<tr>
		<td>
			<label for="input">D.N.I.: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="dni_tutor" required value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getDni() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Domicilio: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="domicilio_tutor" required value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getDomicilio() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Tel�fono: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="telefono_tutor" required value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getTelefono() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Ocupaci�n: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="ocupacion_tutor" required value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getOcupacion() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Dom. Lab.: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="dom_lab_tutor" value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getDom_lab() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Tel�fono Lab.: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="telefono_lab_tutor" value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getTel_lab() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Estado Civil: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<select class="form-control" name="est_civil_tutor">
					<option <%=tutor!=null && tutor.getEst_civil().equals("Soltero/a")? "selected" : ""%>>Soltero/a</option>
					<option <%=tutor!=null && tutor.getEst_civil().equals("Casado/a")? "selected" : ""%>>Casado/a</option>
					<option <%=tutor!=null && tutor.getEst_civil().equals("Divorsiado/a")? "selected" : ""%>>Divorciado/a</option>
					<option <%=tutor!=null && tutor.getEst_civil().equals("Viudo/a")? "selected" : ""%>>Viudo/a</option>
					<option <%=tutor!=null && tutor.getEst_civil().equals("Separado/a")? "selected" : ""%>>Separado/a</option>
				</select>
			</div>	
		</td>
	</tr>
</table>
<br>
<h3>Madre:</h3>
<table>	
	<tr>
		<td>
			<label for="input">Apellido: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="apellido_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getApellido() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Nombres: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="nombre_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getNombre() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Lugar de nacimiento: </label>
		</td>
		<td>	
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="lugar_nac_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getLugar_nac() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Fecha de Nacimiento:</label>
		</td>			
		<td>
			<div class="col-xs-10">
				<input class="form-control" type="text" id="datepicker3" required name="fecha_nac_madre">
			</div>
		</td>			
 	</tr>
	<tr>
		<td>
			<label for="input">D.N.I.: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="dni_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getDni() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Domicilio: </label>
		</td>
		<td>	
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="domicilio_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getDomicilio() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Tel�fono: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="telefono_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getTelefono() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Ocupaci�n: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="ocupacion_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getOcupacion() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Dom. Lab.: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="dom_lab_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getDom_lab() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Tel�fono Lab.: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="telefono_lab_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getTel_lab() : ""%>">
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="input">Estado Civil: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<select class="form-control" name="est_civil_madre">
					<option <%=madre!=null && madre.getEst_civil().equals("Soltero/a")? "selected" : ""%>>Soltero/a</option>
					<option <%=madre!=null && madre.getEst_civil().equals("Casado/a")? "selected" : ""%>>Casado/a</option>
					<option <%=madre!=null && madre.getEst_civil().equals("Divorsiado/a")? "selected" : ""%>>Divorciado/a</option>
					<option <%=madre!=null && madre.getEst_civil().equals("Viudo/a")? "selected" : ""%>>Viudo/a</option>
					<option <%=madre!=null && madre.getEst_civil().equals("Separado/a")? "selected" : ""%>>Separado/a</option>
				</select>
			</div>	
		</td>
	</tr>
</table>
<br>
<h3>Hermanos:</h3>
<table>	
	<tr>
		<td>
			<label for="input">Mayores: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="1" name="cant_her_may" required value="<%=alumno!=null? alumno.getCant_her_may() : "0"%>">
			</div>	
		</td>	
		<td>
			<label for="input">Menores: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="1" name="cant_her_men" required value="<%=alumno!=null? alumno.getCant_her_men() : "0"%>">
			</div>	
		</td>
	</tr>
</table>
<br>
<h2>Iglesia</h2>
<table>	
	<tr>
		<td>
			<label for="input">Nombre: </label>
		</td>
		<td>
			<div class="col-xs-10">
				<input type="text" class="form-control" size="29" name="iglesia" value="<%=alumno!=null? alumno.getIglesia() : ""%>">
			</div>	
		</td>
	</tr>							
</table>
<br>
<br>
<%
		if (alumno!=null && dias <= 7){
			mensaje = "Se puede modificar grado/tuno de ingreso hasta 7 dias despu�s del alta";
		}

		//la fecha de inscripcion, el grado y el a�o en que arrancar aparece solo si es un alumno nuevo,
		//o si es una modificaci�n de un alumno existente 7 d�as despu�s del alta
		//o si es un reingreso
		if (alumno==null || ind==1 || (alumno!=null && dias <= 7) || ind_reingreso == 1) {		
		
%>

<%if(!grados.getLista().isEmpty()){%>
<table>	
	<tr>
		<td>
			<label for="input">Fecha de Ingreso:</label>
		</td>			
		<td>			
			<input class="form-control" type="text" id="datepicker4" required autofocus name="fecha_ing_alum">		
		</td>			
 	</tr>
	<tr>
		<td>
			<label for="input">Grado/Turno</label>
		</td>
		<td>					
		<%if((grado != null && alumno == null) || (alumno != null && dias > 7 && ind == 0 && ind_reingreso != 1)){%>
				<input readonly type="text" class="form-control" name="grado_turno" value="<%=grado + " - " + turno%>">
		<%}else{%>		
				<select name="grado_turno" class="form-control">				
				<%for (Grado g : grados.getLista()){ %>
			 	<option value="<%=g.getGrado() + " - " + g.getTurno()%>"><%=g.getGrado() + " - " + g.getTurno()%></option>			   
				<%}%>
		<%}%>			
		</select>					
		</td>	
	<tr>
		<td>
			<label for="input">Ingreso Escolar: </label>
		</td>
		<td>			
		<%if(a�o != null && ind_reingreso == 0 && !nuevo.equals("nuevo")){%>
				<input readonly type="text" class="form-control" name="a�o_ing" value="<%=a�o%>">
		<%}else{%>
				<select name="a�o_ing" class="form-control">
			 <%
			  
			  int a�o_max = AccionesAlumno.getA�oAlumnos("MAX");
			  			  
			  if (a�o_max == 0); a�o_max =  a�o_sys; //+ 1;			  
			  
			  if (a�o_max == a�o_sys); a�o_max = a�o_max + 1;			  
			  //if (a�o_max > a�o_sys); a�o_max = a�o_max - 1;
			  			 
			 	for (int i = a�o_max; i >= (a�o_max-1); i--){
 			 %>
				 <option <%=a�o_max==i ? "selected" : ""%>><%=i%></option>
			 <%
			 	}
			 %>
  			 	</select>
  		<%}%>
		</td>
	</tr>
</table>
<br>
<br>
<%}%>
<%}%>
<%if(!grados.getLista().isEmpty()){%>
<button type="submit" id=guardar title="<%=mensaje%>" class="btn btn-primary"  onclick=<%=AccionesMensaje.getOne(1).getMensaje()%>><i class="glyphicon glyphicon-floppy-disk"></i> Guardar</button>
<button type="reset" class="btn btn-primary"   onclick=<%=AccionesMensaje.getOne(3).getMensaje()%>><i class="glyphicon glyphicon-remove"></i> Cancelar</button>
<%}%>

</form>
</div>
<br>
<br>
<%if(alumno != null && hermano == null && ind_reingreso == 0){%>
<strong><a href="alumno_edit.jsp">Cargar Hermano</a></strong>
<br>
<br>
<br>
<%}
String volver = "AlumnoList";
if (ind_reingreso == 1){
	volver  = "alumnoInactivo?do=listar";	
}

if (!nuevo.equals("nuevo")){
	
	if (a�o != null || hermano != null || ind_reingreso == 1){

%>
<div class="form-group">
<form action="<%=volver%>" method="post">
<input type="hidden" name="accion" value="listarAlumnos">
<button type="submit" class="btn btn-primary" value="Volver"><i class="glyphicon glyphicon-share-alt"></i> Volver</button>
</form>
</div>
</div>
<%}%>
<%}%>
 <!-- MENSAJE -->
 <%	
	Mensaje mensaje1 = null;
	if (session.getAttribute("mensaje") != null) {
		mensaje1 = (Mensaje) session.getAttribute("mensaje");
		session.setAttribute("mensaje", null);
 %>
 <br>
   <div class="bs-example">
    	 <div class="alert <%=mensaje1.getTipo()%> fade in" role="alert">
     	 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 <%= mensaje1.getMensaje()%>
  	  </div>
  </div>
<br>
 <%}%>  
	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>
	
	<script src="js/jquery-ui.js"></script>
	
	<!-- DatePic para Alumno -->
	<script src="js/alumnos.js"></script>

	<!-- men� superior -->
	<script src="js/menu_admin.js"></script>
</body>
</html>