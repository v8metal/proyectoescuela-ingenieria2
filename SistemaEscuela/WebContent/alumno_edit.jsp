<%@page import="datos.*"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>

<%session.setAttribute("pagina", "alumnos");%>
			
<meta name="viewport" content="width=device-width; initial-scale=1.0">
<title>Editar Alumno</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.10.2.js"></script>
<script src="js/bootstrap.min.js"></script>

<link rel="stylesheet" href="style/jquery-ui.css">
<!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css"> -->
<script src="js/jquery-ui.js"></script>
<script src="js/menu_admin.js"></script>
<script src="js/alumno.js"></script><!-- DatePic para entrevistas -->
</head>
<body>
<div class="container"> 	
 <div id="divmenu"></div> 	 
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
	
%>
<div class="page-header"> 
<h1>Ficha identificatoria del alumno</h1>
</div>
<%	String error = "";
	if (session.getAttribute("error") != null) {
		error = (String)session.getAttribute("error");
		session.setAttribute("error", "");
	}

  	Padre tutor = (Padre)request.getAttribute("tutor");
    Padre madre = (Padre)request.getAttribute("madre");
    Alumno alumno = null;
    Alumno hermano = null;
    Integer dias = -1;
    
	Integer ind = null;
	
	String mensaje = "";
	
    if (request.getAttribute("alumno") != null){
    	 
    	alumno = (Alumno) request.getAttribute("alumno");
    	dias = (Integer) request.getAttribute("diasAlta");
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
	
  %>
<div class="form-group">  
<form action="alumnoEdit" method="post" class="alumno-alta">
<h2>Datos personales:</h2>
<table>
	<tr>
		<td>Apellido: </td>
		<td><input type="text" class="form-control" size="29" name="apellido_alum" required value="<%=alumno!=null? alumno.getApellido() : ""%>"></td><td><%= error %></td>
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
		<td>Fecha de nacimiento: </td>
				 		
			<td><select name="dia_nac_alum">   
			<%  
				for (int i = 1; i <= 31; i++){			  	
 			 %>
			 <option <%=alumno!=null && dia_nac_alum==i ? "selected" : ""%>><%=i%></option>		 	
   			<%
				}	
			 %>
 			 </select>
  			 <select name="mes_nac_alum">
  			 <option value="01" <%=alumno!=null && mes_nac_alum.equals("01") ? "selected" : ""%>>Enero</option>
			 <option value="02" <%=alumno!=null && mes_nac_alum.equals("02") ? "selected" : ""%>>Febrero</option>
			 <option value="03" <%=alumno!=null && mes_nac_alum.equals("03") ? "selected" : ""%>>Marzo</option>
			 <option value="04" <%=alumno!=null && mes_nac_alum.equals("04") ? "selected" : ""%>>Abril</option>
			 <option value="05" <%=alumno!=null && mes_nac_alum.equals("05") ? "selected" : ""%>>Mayo</option>
			 <option value="06" <%=alumno!=null && mes_nac_alum.equals("06") ? "selected" : ""%>>Junio</option>
			 <option value="07" <%=alumno!=null && mes_nac_alum.equals("07") ? "selected" : ""%>>Julio</option>
			 <option value="08" <%=alumno!=null && mes_nac_alum.equals("08") ? "selected" : ""%>>Agosto</option>
			 <option value="09" <%=alumno!=null && mes_nac_alum.equals("09") ? "selected" : ""%>>Septiembre</option>
			 <option value="10" <%=alumno!=null && mes_nac_alum.equals("10") ? "selected" : ""%>>Octubre</option>
			 <option value="11" <%=alumno!=null && mes_nac_alum.equals("11") ? "selected" : ""%>>Noviembre</option>
			 <option value="12" <%=alumno!=null && mes_nac_alum.equals("12") ? "selected" : ""%>>Diciembre</option>	   			 		
 			 </select>
			 <select name="año_nac_alum">
			<%
			 	for (int i = año_sys; i >= 1905; i--){
 			 %>
 			 <option <%=alumno!=null && año_nac_alum==i ? "selected" : ""%>><%=i%></option>
			<%
			 	}
			 %>
  			 </select>			 
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
		<td><input type="text" class="form-control" size="29" name="apellido_tutor" required value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getApellido() : ""%>"></td>
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
		<td>Fecha de nacimiento: </td>
		<td><select name="dia_nac_tutor">
   			 <%
			 	for (int i = 1; i <= 31; i++){
 			 %>
 			 <option <%=tutor!=null && dia_nac_tutor==i ? "selected" : ""%>><%=i%></option>
   			  <%
			 	}
			 %>
 			 </select>
  			 <select name="mes_nac_tutor">
  			 <option value="01" <%=tutor!=null && mes_nac_tutor.equals("01") ? "selected" : ""%>>Enero</option>
			 <option value="02" <%=tutor!=null && mes_nac_tutor.equals("02") ? "selected" : ""%>>Febrero</option>
			 <option value="03" <%=tutor!=null && mes_nac_tutor.equals("03") ? "selected" : ""%>>Marzo</option>
			 <option value="04" <%=tutor!=null && mes_nac_tutor.equals("04") ? "selected" : ""%>>Abril</option>
			 <option value="05" <%=tutor!=null && mes_nac_tutor.equals("05") ? "selected" : ""%>>Mayo</option>
			 <option value="06" <%=tutor!=null && mes_nac_tutor.equals("06") ? "selected" : ""%>>Junio</option>
			 <option value="07" <%=tutor!=null && mes_nac_tutor.equals("07") ? "selected" : ""%>>Julio</option>
			 <option value="08" <%=tutor!=null && mes_nac_tutor.equals("08") ? "selected" : ""%>>Agosto</option>
			 <option value="09" <%=tutor!=null && mes_nac_tutor.equals("09") ? "selected" : ""%>>Septiembre</option>
		 	 <option value="10" <%=tutor!=null && mes_nac_tutor.equals("10") ? "selected" : ""%>>Octubre</option>
			 <option value="11" <%=tutor!=null && mes_nac_tutor.equals("11") ? "selected" : ""%>>Noviembre</option>
		     <option value="12" <%=tutor!=null && mes_nac_tutor.equals("12") ? "selected" : ""%>>Diciembre</option>
 			 </select>
			 <select name="año_nac_tutor">
			 <%
			 	for (int i = año_sys; i >= 1905; i--){
 			 %>
 			 <option <%=tutor!=null && año_nac_tutor==i ? "selected" : ""%>><%=i%></option>
			 <%
			 	}
			 %>
  			 </select>
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
		<td>Fecha de nacimiento: </td>
			<td><select name="dia_nac_madre">
   			 <%
			 	for (int i = 1; i <= 31; i++){
 			 %>
   			 <option <%=madre!=null && dia_nac_madre==i ? "selected" : ""%>><%=i%></option>
   			  <%
			 	}
			 %>
 			 </select>
  			 <select name="mes_nac_madre">
  			 <option value="01" <%=madre!=null && mes_nac_madre.equals("01") ? "selected" : ""%>>Enero</option>
			 <option value="02" <%=madre!=null && mes_nac_madre.equals("02") ? "selected" : ""%>>Febrero</option>
			 <option value="03" <%=madre!=null && mes_nac_madre.equals("03") ? "selected" : ""%>>Marzo</option>
			 <option value="04" <%=madre!=null && mes_nac_madre.equals("04") ? "selected" : ""%>>Abril</option>
			 <option value="05" <%=madre!=null && mes_nac_madre.equals("05") ? "selected" : ""%>>Mayo</option>
			 <option value="06" <%=madre!=null && mes_nac_madre.equals("06") ? "selected" : ""%>>Junio</option>
			 <option value="07" <%=madre!=null && mes_nac_madre.equals("07") ? "selected" : ""%>>Julio</option>
			 <option value="08" <%=madre!=null && mes_nac_madre.equals("08") ? "selected" : ""%>>Agosto</option>
			 <option value="09" <%=madre!=null && mes_nac_madre.equals("09") ? "selected" : ""%>>Septiembre</option>
			 <option value="10" <%=madre!=null && mes_nac_madre.equals("10") ? "selected" : ""%>>Octubre</option>
			 <option value="11" <%=madre!=null && mes_nac_madre.equals("11") ? "selected" : ""%>>Noviembre</option>
			 <option value="12" <%=madre!=null && mes_nac_madre.equals("12") ? "selected" : ""%>>Diciembre</option>
 			 </select>
			 <select name="año_nac_madre">
			 <%
			 	for (int i = año_sys; i >= 1905; i--){
 			 %>
			 <option <%=madre!=null && año_nac_madre==i ? "selected" : ""%>><%=i%></option>
			 <%
			 	}
			 %>
  			 </select>
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

		if (alumno==null || ind==1 || (alumno!=null && dias <= 7)) {		//la fecha de inscripcion, el grado y el año en que arrancar aparece solo si es un alumno nuevo, no si es una modificacion de uno existente
		
%>
<table>	
	<tr>
		<td>Fecha de ingreso: </td>
			<td><select name="dia_insc">
   			 <%
			 	for (int i = 1; i <= 31; i++){
 			 %>
   			 <option <%=dia_sys==i ? "selected" : ""%>><%=i%></option>
   			  <%
			 	}
			 %>
 			 </select>
  			 <select name="mes_insc">
  			 <option value="01" <%=mes_sys.equals("1") ? "selected" : ""%>>Enero</option>
			 <option value="02" <%=mes_sys.equals("2") ? "selected" : ""%>>Febrero</option>
			 <option value="03" <%=mes_sys.equals("3") ? "selected" : ""%>>Marzo</option>
			 <option value="04" <%=mes_sys.equals("4") ? "selected" : ""%>>Abril</option>
			 <option value="05" <%=mes_sys.equals("5") ? "selected" : ""%>>Mayo</option>
			 <option value="06" <%=mes_sys.equals("6") ? "selected" : ""%>>Junio</option>
			 <option value="07" <%=mes_sys.equals("7") ? "selected" : ""%>>Julio</option>
			 <option value="08" <%=mes_sys.equals("8") ? "selected" : ""%>>Agosto</option>
			 <option value="09" <%=mes_sys.equals("9") ? "selected" : ""%>>Septiembre</option>
			 <option value="10" <%=mes_sys.equals("10") ? "selected" : ""%>>Octubre</option>
			 <option value="11" <%=mes_sys.equals("11") ? "selected" : ""%>>Noviembre</option>
			 <option value="12" <%=mes_sys.equals("12") ? "selected" : ""%>>Diciembre</option>
 			 </select>
			 <select name="año_insc">
			 <%
			 	for (int i = año_sys; i >= 1990; i--){
 			 %>
			 <option <%=año_sys==i ? "selected" : ""%>><%=i%></option>
			 <%
			 	}
			 %>
  			 </select>
		</td>
	</tr>
	<tr>
		<td>Grado:</td>
		<td>
		<%if(grado != null && dias > 7){%>
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
		<%if(turno != null && dias > 7){%>
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
		<%if(año != null){%>
			<input readonly type="text" class="form-control" name="año_ing" value="<%=año%>">
		<%}else{%>
			<select name="año_ing">
			 <%
			 	for (int i = año_sys+1; i >= año_sys; i--){
 			 %>
			 <option <%=año_sys==i ? "selected" : ""%>><%=i%></option>
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
<%if(alumno != null && hermano == null){%>
<a href="alumno_edit.jsp">Cargar Hermano</a>
<br>
<br>
<br>
<%}
if (año != null || hermano != null){%>
<div class="form-group">
<form action="AlumnoList" method="post">
<input type="hidden" name="accion" value="listarAlumnos">
<button type="submit" class="btn btn-primary" value="Volver">Volver</button>
</form>
</div>
</div>
<%}%>
</body>
</html>