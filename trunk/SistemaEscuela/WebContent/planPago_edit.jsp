<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.Alumnos"%>
<%@page import="datos.PlanPago"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesPlanPago"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Plan de Pagos</title>
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<body>
<div class="container">
<center>
 <% 
 if (session.getAttribute("admin") != null) {
	 
 	PlanPago plan = (PlanPago) request.getAttribute("PlanPago"); 	
 	Alumnos alumnos = (Alumnos) session.getAttribute("alumnos_PlanPagos");
 	int año = (Integer) session.getAttribute("añoPlan");
 	int dni = (Integer) session.getAttribute("dni");
 	int mes = (Integer) session.getAttribute("mes");
 	 	
 	Alumno a = new Alumno(); 
 	
 	if (plan != null){
 	
 		a = AccionesAlumno.getOne(plan.getDni());
 	
 %>
 <div class="page-header">  
	 <h1>Modificar Plan de Pago</h1>
</div> 
 <%}else{%>
  
 
<div class="page-header">  
	 <h1>Alta Plan Pago</h1>
</div>
 
 <%}
 		int dia_plan = 0;
		String mes_plan = "";
		int año_plan = 0;
		int inicio = 0;
		int fin = 0;		
	
		if (plan != null) {
			//recupero la fecha
			String fecha_pago = plan.getFecha();
			//separo la fecha (1990-01-01) por el "-"" y almaceno el año, mes y dia en un array
			String[] fecha_ent = fecha_pago.split ("-");
			//obtengo el dia, mes y año respectivamente
			dia_plan = Integer.parseInt(fecha_ent[fecha_ent.length - 1]);
			mes_plan = fecha_ent[fecha_ent.length - 2];
			año_plan = Integer.parseInt(fecha_ent[fecha_ent.length - 3]);
		
			inicio = plan.getPeriodoini();
			fin = plan.getPeriodofin();			
		
		}else{	
	//Alta de plan
	   		dia_plan = Integer.valueOf((String)session.getAttribute("dia_sys"));
		
	   		mes_plan = (String) session.getAttribute("mes_sys");
	   	
	   		//System.out.println("mes_plan= " + mes_plan);
	   		//System.out.println("mes_plan.substring(0,1)= " + mes_plan.substring(0,1));	   	
	   	
	   		if (!mes_plan.substring(0,1).equals("1")){		
	   			mes_plan = "0" + mes_plan;	   	
	   		}
	   	
	   		//año_plan = Integer.valueOf((String)session.getAttribute("año_sys"));
	   		año_plan= año;
	   	
	   		inicio = Integer.parseInt(mes_plan);
	   		fin = inicio;	   		
	 //Alta de plan  
		}
		
		String mesplan = "";
	
		if(mes_plan.equals("01")) mesplan="Enero";
		if(mes_plan.equals("02")) mesplan="Febrero";
		if(mes_plan.equals("03")) mesplan="Marzo";
		if(mes_plan.equals("04")) mesplan="Abril";
		if(mes_plan.equals("05")) mesplan="Mayo";
		if(mes_plan.equals("06")) mesplan="Junio";
		if(mes_plan.equals("07")) mesplan="Julio";
		if(mes_plan.equals("08")) mesplan="Agosto";
		if(mes_plan.equals("09")) mesplan="Septiembre";
		if(mes_plan.equals("10")) mesplan="Octubre";
		if(mes_plan.equals("11")) mesplan="Noviembre";
		if(mes_plan.equals("12")) mesplan="Diciembre";
		
if (alumnos.getLista().size() == 0){%>

<a> No hay alumnos en condiciones de planes de pago</a>
<br>

<%}else{%>
 	
 	<div class="form-group">
	<form action="PlanPagoList" method="get">
	<%if (plan != null) { %>
	<input name=accion type=hidden value ="modificarPlanPago">
	<%}else{%>
	<input name=accion type=hidden value ="altaPlanPago">
	<%}%>	
	<table class="table table-hover table-bordered">
	<%if (plan != null){%>
		<tr>
			<td>Fecha Alta</td>			
			<td>
				<input readonly size= 2 name="dia_plan" type="text" value="<%=dia_plan %>"> 				 		
  			 	<input readonly size= 10 name="mes_plan" type="text" value="<%=mesplan%>">	  	 		
		  	    <input name="año_plan" size= 4  type="text" value="<%=año%>">  
		  	</td>
		</tr>
		
	<%}else{%>		
		<tr>
			<td>Fecha </td>			
			<td>
				<select name="dia_plan">			   
				<% for (int i = 1; i <= 31; i++){%>
				<option <%=dia_plan==i ? "selected" : ""%>><%=i%></option>		 	
		   		<%}%>
		 		</select>
		 				 		
  			 	<select name="mes_plan">
  			 	
  			 	<option value="03" <%=mes_plan.equals("03") ? "selected" : ""%>>Abril</option>
			 	<option value="04" <%=mes_plan.equals("04") ? "selected" : ""%>>Abril</option>
			 	<option value="05" <%=mes_plan.equals("05") ? "selected" : ""%>>Mayo</option>
			 	<option value="06" <%=mes_plan.equals("06") ? "selected" : ""%>>Junio</option>
				<option value="07" <%=mes_plan.equals("07") ? "selected" : ""%>>Julio</option>
			 	<option value="08" <%=mes_plan.equals("08") ? "selected" : ""%>>Agosto</option>
			 	<option value="09" <%=mes_plan.equals("09") ? "selected" : ""%>>Septiembre</option>
				<option value="10" <%=mes_plan.equals("10") ? "selected" : ""%>>Octubre</option>
			 	<option value="11" <%=mes_plan.equals("11") ? "selected" : ""%>>Noviembre</option>
			 	<option value="12" <%=mes_plan.equals("12") ? "selected" : ""%>>Diciembre</option>	   			 		
 				</select>
		  		
		  	    <input name="año_plan" type="hidden" value="<%=año%>">
		</tr>
		
		<%}%>
		
		<%if (plan == null){%>
		<tr>
			<td> Alumno </td>		
			<td>			
			<select name="dni">
	      	<%for (Alumno a1 : alumnos.getLista()) { 
	      		
	      		if(!AccionesAlumno.getTipoCobro(a1.getDni(), año).equals("SUBSIDIO")){%>
	      			            
	            <option value="<%=a1.getDni() %>"><%= a1.getNombre() + " "+ a1.getApellido() %></option>            
	          
	      	<%	}
	      	}%>	      	
	     	</select>
	     	<td>
	    </tr>
	    <%}else{%>
	    <tr>
			<td> ALUMNO </td>		
			<td> <input readonly size = 40 name="alumno" type="text" value="<%= a.getNombre() + " " + a.getApellido() %>"></td>
			<td> <input name="cod_plan" type="hidden" value="<%=plan.getCod_plan()%>"></td>
	    </tr>
	    <%}%>
		<tr>		
			<td>AÑO INICIO</td>
			<td>
				<select name="añoini">   
				<%  
			    int i = 0;				
				int añop = 0;
				
				
				if (plan != null) añop = plan.getAñoini(); else añop= año_plan;
				
				if (plan != null && plan.getAñoini() < plan.getAñofin()) añop = añop + 1;
				
				if (plan != null) i = plan.getAñoini()-3; else i= año_plan - 3;
				
				for (; i <= añop; i++){					
					if (plan != null){ %>
						<option <%=i==plan.getAñoini() ? "selected" : ""%>><%=i%></option>
					<%}else{%>		 	
						<option <%=i==año_plan ? "selected" : ""%>><%=i%></option>
					<%}%>
		   		<%}%>			 
				</select>			
 			</td>
 		<tr>
			<td>PERIODO INICIO</td>
			<td>
			  	<select name="periodo_ini">
  			 	  			 	
			 	<option value="3" <%=inicio == 3 ? "selected" : ""%>>Marzo</option>
			 	<option value="4" <%=inicio == 4 ? "selected" : ""%>>Abril</option>
			 	<option value="5" <%=inicio == 5 ? "selected" : ""%>>Mayo</option>
			 	<option value="6" <%=inicio == 6 ? "selected" : ""%>>Junio</option>
				<option value="7" <%=inicio == 7 ? "selected" : ""%>>Julio</option>
			 	<option value="8" <%=inicio == 8 ? "selected" : ""%>>Agosto</option>
			 	<option value="9" <%=inicio == 9 ? "selected" : ""%>>Septiembre</option>
				<option value="10" <%=inicio == 10 ? "selected" : ""%>>Octubre</option>
			 	<option value="11" <%=inicio == 11 ? "selected" : ""%>>Noviembre</option>
			 	<option value="12" <%=inicio == 12 ? "selected" : ""%>>Diciembre</option>
			 	<option value="13" <%=inicio == 13 ? "selected" : ""%>>Inscripcion</option>			 	
			 				 		   			 		
 			 	</select>
 			  			 	
		  	</td>	  		
		</tr>
		
		<tr>
			<td>AÑO FIN</td>
			<td>
				<select name="añofin">   
					<%				
					if (plan != null) añop = plan.getAñofin(); else añop= año_plan;				
					if (plan != null) i = plan.getAñofin()-3; else i= año_plan - 3;
				
					for (; i <= añop; i++){%>
						<option <%=i==añop? "selected" : ""%>><%=i%></option>		 	
		   			<%}%>			
				</select>			
 			</td>
 		<tr>
			<td>PERIODO FIN</td>
			<td>
			  	<select name="periodo_fin">
  			 	  			 	
				<option value="3" <%=fin == 3 ? "selected" : ""%>>Marzo</option>
			 	<option value="4" <%=fin == 4 ? "selected" : ""%>>Abril</option>
			 	<option value="5" <%=fin == 5 ? "selected" : ""%>>Mayo</option>
			 	<option value="6" <%=fin == 6 ? "selected" : ""%>>Junio</option>
				<option value="7" <%=fin == 7 ? "selected" : ""%>>Julio</option>
			 	<option value="8" <%=fin == 8 ? "selected" : ""%>>Agosto</option>
			 	<option value="9" <%=fin == 9 ? "selected" : ""%>>Septiembre</option>
				<option value="10" <%=fin == 10 ? "selected" : ""%>>Octubre</option>
			 	<option value="11" <%=fin == 11 ? "selected" : ""%>>Noviembre</option>
			 	<option value="12" <%=fin == 12 ? "selected" : ""%>>Diciembre</option>
			 	<option value="13" <%=fin == 13 ? "selected" : ""%>>Inscripcion</option>
			 				 		   			 		
 			 	</select>
 			  			 	
		  		</td>		  		
		</tr>
		
		<tr>
			<td>OBSERVACIONES</td>
			<td><textarea name="obs" cols="40" rows="1"><%=plan!=null?plan.getObservaciones(): ""%></textarea></td>			
		</tr>
		
		<%if(plan !=null){%>
		<tr>
			<td>TOTAL DE PAGOS</td>
			<td><input readonly type=text name="total" value= <%=AccionesPlanPago.getTotalPlanPago(plan.getCod_plan())%>></td>			
		</tr>
		<%}%>
		<tr>
		<td></td>
		<%if (plan != null) { %>
			<td><button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="return confirm('Esta seguro que desea modificar?');">Modificar</button></td>	
		<%}else{%>
			<td><button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="return confirm('Esta seguro que desea guardar?');">Realizar alta</button></td>
		<%}%>
		</tr>	
	</table> 
	<br>	
	</form>
	</div>
<%if (plan != null) { %>
<div class="form-group">
<form action="PlanPagoList" method="get">
	<input name="codplan" type="hidden" value="<%=plan.getCod_plan()%>">
	<input id="accion" name="accion" type="hidden">	
	<table>
	<tr>
	<td>		
		<button id="listar" type="submit" class="btn btn-primary"  value="Listar Pagos realizados" name="btnSave" onClick="accion1()">Listar Pagos realizados</button>	
	<td>		
		<button id="borrar" type="submit" class="btn btn-primary"  value="Borrar Plan de Pagos"  name="btnSave" onclick="accion2()">Borrar Plan de Pagos</button>	
	</td>
	</tr>
	</table>	
</form>
</div>
<%}%>
<%}%>
</center>
<br>
<div class="form-group">
<form action="CuotaList">
<input name="accion" type="hidden" value="listarGrado">
<button type="submit" class="btn btn-primary"  value="Volver al listado de Cuotas">Volver al listado de Cuotas</button>
</form>
</div>

 <%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
<script type="text/javascript">

function accion1() {
	var accion = document.getElementById('accion');	
	accion.value = "listarPagosPlan"; 
	
}

function accion2() {
	var accion = document.getElementById('accion');	
	accion.value = "borrarPlanPago"; 
	
	return confirm("Esta seguro que desea modificar?");
	
}
</script>
</div>
</body>
</html>
