<%@page import="datos.*"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesAlumno"%>
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
  	<!-- sirve para visualizar el menú superior -->
  </div>	 
  
<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "alumno_edit.jsp") != 1){							
		response.sendRedirect("Login");						
	}	
	
	
	//Datos del grado cuando se accede desde el listado por grado
	String grado = (String) session.getAttribute("grado_alta");
	String turno = (String) session.getAttribute("turno_alta");
	Integer año = (Integer) session.getAttribute("añoAlta");	
	//Datos del grado cuando se accede desde el listado por grado
	
	//se remueven los atributos para que no queden colgados
	session.removeAttribute("grado_alta");
	session.removeAttribute("turno_alta");
	//session.removeAttribute("añoAlta"); //ver si esta ok comentarlo o no
	//se remueven los atributos para que no queden colgados

	String error = "";
	if (session.getAttribute("error") != null) {
		error = (String)session.getAttribute("error");
		session.setAttribute("error", "");
	}

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
	//para la carga de un hermano
	
	// necesito las variables como globales para que lleguen hasta el select
	int dia_nac_alum = 0;
	String mes_nac_alum = "";
	int año_nac_alum= 0;
	
	// verifico qe se alla pasado un alumno (caso modificar)
	if (alumno != null) {
		//recupero la fecha
		String fecha_nac_alum = alumno.getFecha_nac();
		//separo la fecha (1990-01-01) por el "-"" y almaceno el año, mes y dia en un array
		String[] nac_alum = fecha_nac_alum.split ("-");
		//obtengo el dia, mes y año respectivamente
		dia_nac_alum = Integer.parseInt(nac_alum[nac_alum.length - 1]);
		mes_nac_alum = nac_alum[nac_alum.length - 2];
		año_nac_alum = Integer.parseInt(nac_alum[nac_alum.length - 3]);	
	}
	
	// lo mismo con el tutor y la madre
	int dia_nac_tutor = 0;
	String mes_nac_tutor = "";
	int año_nac_tutor = 0;
	
	if (tutor != null) {
		String fecha_nac_tutor = tutor.getFecha_nac();
		String[] nac_tutor = fecha_nac_tutor.split ("-");
		dia_nac_tutor = Integer.parseInt(nac_tutor[nac_tutor.length - 1]);
		mes_nac_tutor = nac_tutor[nac_tutor.length - 2];
		año_nac_tutor = Integer.parseInt(nac_tutor[nac_tutor.length - 3]);
	}
	
	int dia_nac_madre = 0;
	String mes_nac_madre = "";
	int año_nac_madre = 0;
	
	if (madre != null) {
		String fecha_nac_madre = madre.getFecha_nac();
		String[] nac_madre = fecha_nac_madre.split ("-");
		dia_nac_madre = Integer.parseInt(nac_madre[nac_madre.length - 1]);
		mes_nac_madre = nac_madre[nac_madre.length - 2];
		año_nac_madre = Integer.parseInt(nac_madre[nac_madre.length - 3]);
	}	
	
	//recupero de la sesion la fecha del sistema
	int año_sys = Integer.parseInt((String)session.getAttribute("año_sys"));
	String mes_sys = (String)session.getAttribute("mes_sys");
	int dia_sys = Integer.parseInt((String)session.getAttribute("dia_sys"));
	
	String reingreso = null;
	reingreso = (String) session.getAttribute("reingreso");
	
	String cabecera = "";
	int ind_reingreso = 0;
	
	if(ind != null){ 

		if(reingreso == null){
			cabecera = "Edición de Alumno";
		}else{
			ind_reingreso = 1;
			cabecera = "Reingreso de Alumno";

		}	

	}else{

		cabecera = "Alta de Alumno";

	}
	
  %>
<div class="page-header"> 
<h1>Ficha identificatoria del alumno - <%=cabecera%></h1>
</div>

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
		<td>Apellido: </td>
		<td><input type="text" class="form-control" size="29" name="apellido_alum" required autofocus value="<%=alumno!=null? alumno.getApellido() : ""%>"></td><td><%= error %></td>
	</tr>
	<tr>
		<td>Nombres: </td>
		<td><input type="text" class="form-control" size="29" name="nombre_alum" required value="<%=(alumno!=null&&ind==0)? alumno.getNombre() : ""%>"></td>
	</tr>
	<tr>
		<td>Lugar de nacimiento: </td>
		<td><input type="text" class="form-control" size="29" name="lugar_nac_alum" required value="<%=alumno!=null? alumno.getLugar_nac() : ""%>"></td>
	</tr>
	<tr>
		<td><label for="input">Fecha de Nacimiento:</label></td>			
			<td>
			<!-- <div class="col-xs-2"> -->
				<input class="form-control" type="text" id="datepicker" required name="fecha_nac_alum">
			<!-- </div> -->
			</td>			
	  	</tr>
	<tr>
		<td>D.N.I.: </td>
		<td><input type="text" class="form-control" size="29" name="dni_alum" required value="<%=alumno!=null&&ind==0? alumno.getDni() : ""%>"></td>
	</tr>
	<tr>
		<td>Domicilio: </td>
		<td><input type="text" class="form-control" size="29" name="domicilio_alum" required value="<%=alumno!=null? alumno.getDomicilio() : ""%>"></td>
	</tr>
	<tr>
		<td>Teléfono: </td>
		<td><input type="text" class="form-control" size="29" name="telefono_alum" value="<%=alumno!=null? alumno.getTelefono() : ""%>"></td>
	</tr>
	<tr>
		<td>Escolaridad: </td>
		<td>	 
			<label class="radio-inline"> 
			<input type="radio"  name="esc" value="Inicial" required <%=alumno!=null && alumno.getEsc().equals("Inicial") ? "checked" : ""%> /> Inicial
			</label>
			<label class="radio-inline"> 
			</label>
			<input type="radio"  name="esc" value="Primaria" required <%=alumno!=null && alumno.getEsc().equals("Primaria") ? "checked" : ""%>/> Primaria
		</td>
	</tr>
	<tr>
		<td>Grupo Familiar: </td>
		<td>
			<label class="radio-inline"> 
			<input type="radio"  name="ind_grupo" value="si" required <%=alumno!=null && alumno.isInd_grupo() ? "checked" : ""%>/> Si
			</label>
			<label class="radio-inline"> 
			<input type="radio"  name="ind_grupo" value="no" required <%=alumno!=null && !alumno.isInd_grupo() ? "checked" : ""%>/> No 
			</label>		
		</td>
	</tr>
	<tr>
		<td>Subsidio: </td>
		<td>
			<label class="radio-inline"> 
			<input type="radio" name="ind_subsidio" value="si" required <%=alumno!=null && alumno.isInd_subsidio() ? "checked" : ""%>/> Si
			</label>
			<label class="radio-inline"> 
			<input type="radio" name="ind_subsidio" value="no" required <%=alumno!=null && !alumno.isInd_subsidio() ? "checked" : ""%>/> No
			</label>
		</td>
	</tr>
</table>
<br>
<h2>Datos de la familia</h2>
<h3>Padre o Tutor:</h3>
<table>	
	<tr>
		<td>Apellido: </td>
		<td><input type="text" class="form-control" size="29" name="apellido_tutor" required autofocus value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getApellido() : ""%>"></td>
	</tr>
	<tr>
		<td>Nombres: </td>
		<td><input type="text" class="form-control" size="29" name="nombre_tutor" required value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getNombre() : ""%>"></td>
	</tr>
	<tr>
		<td>Lugar de nacimiento: </td>
		<td><input type="text" class="form-control" size="29" name="lugar_nac_tutor" required value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getLugar_nac() : ""%>"></td>
	</tr>
	<tr>
		<td><label for="input">Fecha de Nacimiento:</label></td>			
		<td>
			<!-- <div class="col-xs-2"> -->
			<input class="form-control" type="text" id="datepicker2" required name="fecha_nac_tutor">
			<!-- </div>-->
		</td>			
 	</tr>
	<tr>
		<td>D.N.I.: </td>
		<td><input type="text" class="form-control" size="29" name="dni_tutor" required value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getDni() : ""%>"></td>
	</tr>
	<tr>
		<td>Domicilio: </td>
		<td><input type="text" class="form-control" size="29" name="domicilio_tutor" required value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getDomicilio() : ""%>"></td>
	</tr>
	<tr>
		<td>Teléfono: </td>
		<td><input type="text" class="form-control" size="29" name="telefono_tutor" required value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getTelefono() : ""%>"></td>
	</tr>
	<tr>
		<td>Ocupación: </td>
		<td><input type="text" class="form-control" size="29" name="ocupacion_tutor" required value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getOcupacion() : ""%>"></td>
	</tr>
	<tr>
		<td>Dom. Lab.: </td>
		<td><input type="text" class="form-control" size="29" name="dom_lab_tutor" value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getDom_lab() : ""%>"></td>
	</tr>
	<tr>
		<td>Teléfono Lab.: </td>
		<td><input type="text" class="form-control" size="29" name="telefono_lab_tutor" value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getTel_lab() : ""%>"></td>
	</tr>
	<tr>
		<td>Estado Civil: </td>
		<td><select class="form-control" name="est_civil_tutor" required>
			<option <%=tutor!=null && tutor.getEst_civil().equals("Soltero/a")? "selected" : ""%>>Soltero/a</option>
			<option <%=tutor!=null && tutor.getEst_civil().equals("Casado/a")? "selected" : ""%>>Casado/a</option>
			<option <%=tutor!=null && tutor.getEst_civil().equals("Divorsiado/a")? "selected" : ""%>>Divorciado/a</option>
			<option <%=tutor!=null && tutor.getEst_civil().equals("Viudo/a")? "selected" : ""%>>Viudo/a</option>
			<option <%=tutor!=null && tutor.getEst_civil().equals("Separado/a")? "selected" : ""%>>Separado/a</option>
			</select>
		</td>
	</tr>
</table>
<br>
<h3>Madre:</h3>
<table>	
	<tr>
		<td>Apellido: </td>
		<td><input type="text" class="form-control" size="29" name="apellido_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getApellido() : ""%>"></td>
	</tr>
	<tr>
		<td>Nombres: </td>
		<td><input type="text" class="form-control" size="29" name="nombre_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getNombre() : ""%>"></td>
	</tr>
	<tr>
		<td>Lugar de nacimiento: </td>
		<td><input type="text" class="form-control" size="29" name="lugar_nac_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getLugar_nac() : ""%>"></td>
	</tr>
	<tr>
		<td><label for="input">Fecha de Nacimiento:</label></td>			
		<td>
			<!-- <div class="col-xs-2"> -->
			<input class="form-control" type="text" id="datepicker3" required name="fecha_nac_madre">
			<!-- </div>-->
		</td>			
 	</tr>
	<tr>
		<td>D.N.I.: </td>
		<td><input type="text" class="form-control" size="29" name="dni_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getDni() : ""%>"></td>
	</tr>
	<tr>
		<td>Domicilio: </td>
		<td><input type="text" class="form-control" size="29" name="domicilio_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getDomicilio() : ""%>"></td>
	</tr>
	<tr>
		<td>Teléfono: </td>
		<td><input type="text" class="form-control" size="29" name="telefono_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getTelefono() : ""%>"></td>
	</tr>
	<tr>
		<td>Ocupación: </td>
		<td><input type="text" class="form-control" size="29" name="ocupacion_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getOcupacion() : ""%>"></td>
	</tr>
	<tr>
		<td>Dom. Lab.: </td>
		<td><input type="text" class="form-control" size="29" name="dom_lab_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getDom_lab() : ""%>"></td>
	</tr>
	<tr>
		<td>Teléfono Lab.: </td>
		<td><input type="text" class="form-control" size="29" name="telefono_lab_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getTel_lab() : ""%>"></td>
	</tr>
	<tr>
		<td>Estado Civil: </td>
		<td><select class="form-control" name="est_civil_madre" required>
			<option <%=madre!=null && madre.getEst_civil().equals("Soltero/a")? "selected" : ""%>>Soltero/a</option>
			<option <%=madre!=null && madre.getEst_civil().equals("Casado/a")? "selected" : ""%>>Casado/a</option>
			<option <%=madre!=null && madre.getEst_civil().equals("Divorsiado/a")? "selected" : ""%>>Divorciado/a</option>
			<option <%=madre!=null && madre.getEst_civil().equals("Viudo/a")? "selected" : ""%>>Viudo/a</option>
			<option <%=madre!=null && madre.getEst_civil().equals("Separado/a")? "selected" : ""%>>Separado/a</option>
			</select>
		</td>
	</tr>
</table>
<br>
<h3>Hermanos:</h3>
<table>	
	<tr>
		<td>Mayores: </td>
		<td><input type="text" class="form-control" size="1" name="cant_her_may" required value="<%=alumno!=null? alumno.getCant_her_may() : "0"%>"></td>	
		<td>Menores: </td>
		<td><input type="text" class="form-control" size="1" name="cant_her_men" required value="<%=alumno!=null? alumno.getCant_her_men() : "0"%>"></td>
	</tr>
</table>
<br>
<h2>Iglesia</h2>
<table>	
	<tr>
		<td>Nombre: </td>
		<td><input type="text" class="form-control" size="29" name="iglesia" value="<%=alumno!=null? alumno.getIglesia() : ""%>"></td>
	</tr>							
</table>
<br>
<br>
<%
		if (alumno!=null && dias <= 7){
			mensaje = "Se puede modificar grado/tuno de ingreso hasta 7 dias después del alta";
		}

		//la fecha de inscripcion, el grado y el año en que arrancar aparece solo si es un alumno nuevo,
		//o si es una modificación de un alumno existente 7 días después del alta
		if (alumno==null || ind==1 || (alumno!=null && dias <= 7)) {		
		
%>
<table>	
	<tr>
		<td><label for="input">Fecha de Ingreso:</label></td>			
		<td>
			<!-- <div class="col-xs-2"> -->
			<input class="form-control" type="text" id="datepicker4" required autofocus name="fecha_ing_alum">
			<!-- </div>-->
		</td>			
 	</tr>
	<tr>
		<td>Grado:</td>
		<td>		
		<%if(alumno != null && dias > 7 && ind == 0){%>
		<input readonly type="text" class="form-control" name="grado" value="<%=grado%>">
		<%}else{%>		
		<select name="grado">
			<option value="Sala 4">Sala 4</option>
			<option value="Sala 5">Sala 5</option>
			<option value="1° Grado">1° Grado</option>
			<option value="2° Grado">2° Grado</option>
			<option value="3° Grado">3° Grado</option>
			<option value="4° Grado">4° Grado</option>
			<option value="5° Grado">5° Grado</option>
			<option value="6° Grado">6° Grado</option>
			<option value="7° Grado">7° Grado</option>
		</select>
		<%}%>		
		</td>
	<tr>	
		<td>Turno:</td>
		<td>		
		<%if((alumno != null && dias > 7 && ind == 0)){%>
			<input readonly type="text" class="form-control" name="turno" value="<%=turno%>">
		<%}else{%>		
			<select name="turno">
			<option value="MAÑANA">Mañana</option>
			<option value="TARDE">Tarde</option>
			</select>
		<%}%>
		</td>		
	</tr>		
	<tr>
		<td>Ingreso Escolar: </td>
		<td>
		<%if(año != null && ind_reingreso == 0){%>
			<input readonly type="text" class="form-control" name="año_ing" value="<%=año%>">
		<%}else{%>
			<select name="año_ing">
			 <%
			  int año_max = AccionesAlumno.getAñoAlumnos("MAX");
			  if (año_max == año_sys); año_max = año_max + 1;
			  if (año_max > año_sys); año_max = año_max - 1;
			 	for (int i = año_max; i >= (año_max-1); i--){
 			 %>
			 <option <%=año_max==i ? "selected" : ""%>><%=i%></option>
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
<%
}				
%>

<button id=guardar title="<%=mensaje%>" type="submit" class="btn btn-primary" value="Guardar">Guardar</button>
<button type="reset" class="btn btn-primary" value="Cancelar">Cancelar</button>
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
if (año != null || hermano != null || ind_reingreso == 1){%>
<div class="form-group">
<form action="<%=volver%>" method="post">
<input type="hidden" name="accion" value="listarAlumnos">
<button type="submit" class="btn btn-primary" value="Volver">Volver</button>
</form>
</div>
</div>
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

	<!-- menú superior -->
	<script src="js/menu_admin.js"></script>
</body>
</html>