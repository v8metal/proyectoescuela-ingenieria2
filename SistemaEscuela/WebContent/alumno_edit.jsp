<%@page import="datos.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Editar Alumno</title>
</head>
<body>
<%
	if (session.getAttribute("admin") != null) {
%>
<center><h1>FICHA IDENTIFICATORIA DEL ALUMNO</h1></center>
<%	String error = "";
	if (session.getAttribute("error") != null) {
		error = (String)session.getAttribute("error");
		session.setAttribute("error", "");
	}

  	Padre tutor = (Padre)request.getAttribute("tutor");
    Padre madre = (Padre)request.getAttribute("madre");
	Alumno alumno = (Alumno)request.getAttribute("alumno");
	
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
<form action="alumnoEdit" method="post" class="alumno-alta">
<h2>DATOS PERSONALES:</h2>
<table>
	<tr>
		<td>Apellido: </td>
		<td><input type="text" size="29" name="apellido_alum" value="<%=alumno!=null? alumno.getApellido() : ""%>"></td><td><%= error %></td>
	</tr>
	<tr>
		<td>Nombres: </td>
		<td><input type="text" size="29" name="nombre_alum" value="<%=alumno!=null? alumno.getNombre() : ""%>"></td>
	</tr>
	<tr>
		<td>Lugar de nacimiento: </td>
		<td><input type="text" size="29" name="lugar_nac_alum" value="<%=alumno!=null? alumno.getLugar_nac() : ""%>"></td>
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
		<td><input type="text" size="29" name="dni_alum" value="<%=alumno!=null? alumno.getDni() : ""%>"></td>
	</tr>
	<tr>
		<td>Domicilio: </td>
		<td><input type="text" size="29" name="domicilio_alum" value="<%=alumno!=null? alumno.getDomicilio() : ""%>"></td>
	</tr>
	<tr>
		<td>Teléfono: </td>
		<td><input type="text" size="29" name="telefono_alum" value="<%=alumno!=null? alumno.getTelefono() : ""%>"></td>
	</tr>
	<tr>
		<td>Escolaridad: </td>
		<td>	 
			<input type="radio" name="esc" value="Inicial" <%=alumno!=null && alumno.getEsc().equals("Inicial") ? "checked" : ""%> /> Inicial
			<input type="radio" name="esc" value="Primaria" <%=alumno!=null && alumno.getEsc().equals("Primaria") ? "checked" : ""%>/> Primaria
		</td>
	</tr>
	<tr>
		<td>Grupo Familiar: </td>
		<td>
			<input type="radio" name="ind_grupo" value="si" <%=alumno!=null && alumno.isInd_grupo() ? "checked" : ""%>/> Si
			<input type="radio" name="ind_grupo" value="no" <%=alumno!=null && !alumno.isInd_grupo() ? "checked" : ""%>/> No 
		</td>
	</tr>
	<tr>
		<td>Subsidio: </td>
		<td>
			<input type="radio" name="ind_subsidio" value="si" <%=alumno!=null && alumno.isInd_subsidio() ? "checked" : ""%>/> Si
			<input type="radio" name="ind_subsidio" value="no" <%=alumno!=null && !alumno.isInd_subsidio() ? "checked" : ""%>/> No
		</td>
	</tr>
</table>
<br>
<h2>DATOS DE LA FAMILIA:</h2>
<h3>Padre o Tutor:</h3>
<table>	
	<tr>
		<td>Apellido: </td>
		<td><input type="text" size="29" name="apellido_tutor" value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getApellido() : ""%>"></td>
	</tr>
	<tr>
		<td>Nombres: </td>
		<td><input type="text" size="29" name="nombre_tutor" value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getNombre() : ""%>"></td>
	</tr>
	<tr>
		<td>Lugar de nacimiento: </td>
		<td><input type="text" size="29" name="lugar_nac_tutor" value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getLugar_nac() : ""%>"></td>
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
		<td><input type="text" size="29" name="dni_tutor" value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getDni() : ""%>"></td>
	</tr>
	<tr>
		<td>Domicilio: </td>
		<td><input type="text" size="29" name="domicilio_tutor" value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getDomicilio() : ""%>"></td>
	</tr>
	<tr>
		<td>Teléfono: </td>
		<td><input type="text" size="29" name="telefono_tutor" value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getTelefono() : ""%>"></td>
	</tr>
	<tr>
		<td>Ocupación: </td>
		<td><input type="text" size="29" name="ocupacion_tutor" value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getOcupacion() : ""%>"></td>
	</tr>
	<tr>
		<td>Dom. Lab.: </td>
		<td><input type="text" size="29" name="dom_lab_tutor" value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getDom_lab() : ""%>"></td>
	</tr>
	<tr>
		<td>Teléfono Lab.: </td>
		<td><input type="text" size="29" name="telefono_lab_tutor" value="<%=tutor!=null && tutor.getDni()!=0 ? tutor.getTel_lab() : ""%>"></td>
	</tr>
	<tr>
		<td>Estado Civil: </td>
		<td><select name="est_civil_tutor">
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
		<td><input type="text" size="29" name="apellido_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getApellido() : ""%>"></td>
	</tr>
	<tr>
		<td>Nombres: </td>
		<td><input type="text" size="29" name="nombre_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getNombre() : ""%>"></td>
	</tr>
	<tr>
		<td>Lugar de nacimiento: </td>
		<td><input type="text" size="29" name="lugar_nac_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getLugar_nac() : ""%>"></td>
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
		<td><input type="text" size="29" name="dni_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getDni() : ""%>"></td>
	</tr>
	<tr>
		<td>Domicilio: </td>
		<td><input type="text" size="29" name="domicilio_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getDomicilio() : ""%>"></td>
	</tr>
	<tr>
		<td>Teléfono: </td>
		<td><input type="text" size="29" name="telefono_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getTelefono() : ""%>"></td>
	</tr>
	<tr>
		<td>Ocupación: </td>
		<td><input type="text" size="29" name="ocupacion_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getOcupacion() : ""%>"></td>
	</tr>
	<tr>
		<td>Dom. Lab.: </td>
		<td><input type="text" size="29" name="dom_lab_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getDom_lab() : ""%>"></td>
	</tr>
	<tr>
		<td>Teléfono Lab.: </td>
		<td><input type="text" size="29" name="telefono_lab_madre" value="<%=madre!=null && madre.getDni()!=0 ? madre.getTel_lab() : ""%>"></td>
	</tr>
	<tr>
		<td>Estado Civil: </td>
		<td><select name="est_civil_madre">
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
		<td><input type="text" size="1" name="cant_her_may" value="<%=alumno!=null? alumno.getCant_her_may() : "0"%>"></td>	
		<td>Menores: </td>
		<td><input type="text" size="1" name="cant_her_men" value="<%=alumno!=null? alumno.getCant_her_men() : "0"%>"></td>
	</tr>
</table>
<br>
<h2>IGLESIA</h2>
<table>	
	<tr>
		<td>Nombre: </td>
		<td><input type="text" size="29" name="iglesia" value="<%=alumno!=null? alumno.getIglesia() : ""%>"></td>
	</tr>							
</table>
<br>
<br>
<%
		if (alumno==null) {		//la fecha de inscripcion, el grado y el año en que arrancar aparece solo si es un alumno nuevo, no si es una modificacion de uno existente
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
		<td><select name="grado">
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
		</td>
	<tr>	
		<td>Turno:</td>
		<td><select name="turno">
			<option value="MAÑANA">Mañana</option>
			<option value="TARDE">Tarde</option>
			</select>
		</td>
	</tr>		
	<tr>
		<td>Ingreso Escolar: </td>
		<td>
			<select name="año_ing">
			 <%
			 	for (int i = año_sys+1; i >= año_sys; i--){
 			 %>
			 <option <%=año_sys==i ? "selected" : ""%>><%=i%></option>
			 <%
			 	}
			 %>
  			 </select>
		</td>
	</tr>
</table>
<br>
<br>
<%
		}
%>
<input type="submit" value="Guardar">
<input type="reset" value="Cancelar">
</form>
<br>
<% 
	String volver = "menu_alumnos.jsp";
	if (alumno!=null) { 
	  volver = "alumno_list.jsp";
	}
%>
<form action="<%= volver %>" method="post">
<input type="submit" value="Volver">
</form>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>