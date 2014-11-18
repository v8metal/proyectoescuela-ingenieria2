<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Alumno"%>
<%@page import="datos.Alumnos"%>
<%@page import="datos.PlanPago"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="conexion.AccionesPlanPago"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "cuotas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Plan de Pagos</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<link rel="stylesheet" href="style/jquery-ui.css">
<!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css"> -->

</head>
<body>
<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el menú superior -->
  </div>
  
 <% 
 	int tipo = (Integer) session.getAttribute("tipoUsuario");						
 	if (AccionesUsuario.validarAcceso(tipo, "planPago_edit.jsp") != 1){							
 		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
 	}
 	
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
	<input name="fecha" id="fecha" type="hidden" value="<%=plan!=null?plan.getFecha():"0"%>">
	<input name="cod_plan" type="hidden" value="<%=plan!=null?plan.getCod_plan():0%>">
	<%if (plan != null) { %>
	<input name=accion type=hidden value ="modificarPlanPago">
	<%}else{%>
	<input name=accion type=hidden value ="altaPlanPago">
	<%}%>	
	<table class="table table-hover table-bordered">
		<tr>
			<th>
				<label for="input">Fecha</label>
			</th>			
			<td>
				<div class="col-xs-2">
					<input <%if(plan!=null){%> readonly <%}%> class="form-control" type="text" id="datepicker" required autofocus name="fecha_pp">
				</div>			
			</td>			
	    </tr>		
		<%if (plan == null){%>
		<tr>
			<th>
				<label for="input"> Alumno </label>
			</th>		
			<td>
				<div class="col-xs-5">			
					<select name="dni" class="form-control">
	      			<%for (Alumno a1 : alumnos.getLista()) { 
	      		
	      				if(!AccionesAlumno.getTipoCobro(a1.getDni(), año).equals("SUBSIDIO")){%>
	      			            
	            		<option value="<%=a1.getDni() %>"><%= a1.getNombre() + " "+ a1.getApellido() %></option>            
	          
	      			<%	}
	      			}%>	      	
	     			</select>
	     		</div>
	     	<td>
	    </tr>
	    <%}else{%>
	    <tr>
			<th> Alumno </th>		
			<td>
				<div class="col-xs-5">	 
				<input readonly size = 40 name="alumno" class="form-control" type="text" value="<%= a.getNombre() + " " + a.getApellido() %>">
				</div>
			</td>			
	    </tr>
	    <%}%>
		<tr>		
			<th>Año Inicio</th>
			<td>
				<div class="col-xs-2">	
				<select name="añoini" class="form-control">   
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
				</div>	
 			</td>
 		<tr>
			<th>Periodo Inicio</th>
			<td>
				<div class="col-xs-3">	
			  	<select name="periodo_ini" class="form-control">
  			 	  			 	
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
 			 	</div> 			  			 	
		  	</td>	  		
		</tr>
		
		<tr>
			<th>Año Fin</th>
			<td>
				<div class="col-xs-2">
				<select name="añofin" class="form-control">   
					<%				
					if (plan != null) añop = plan.getAñofin(); else añop= año_plan;				
					if (plan != null) i = plan.getAñofin()-3; else i= año_plan - 3;
				
					for (; i <= añop; i++){%>
						<option <%=i==añop? "selected" : ""%>><%=i%></option>		 	
		   			<%}%>			
				</select>
				</div>			
 			</td>
 		<tr>
			<th>Periodo Fin</th>
			<td>
				<div class="col-xs-3">	
			  	<select name="periodo_fin" class="form-control">
  			 	  			 	
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
 			 	</div>
 			  			 	
		  		</td>		  		
		</tr>
		
		<tr>
			<th>Observaciones</th>
			<td>
				<div class="col-xs-10">	
				<textarea name="obs" class="form-control" cols="50" rows="4"><%=plan!=null?plan.getObservaciones(): ""%></textarea>
				</div>
			</td>			
		</tr>
		
		<%if(plan !=null){%>
		<tr>
			<th>TOTAL DE PAGOS</th>
			<td>
				<div class="col-xs-2">	
				<input readonly type=text name="total" class="form-control" value= <%=AccionesPlanPago.getTotalPlanPago(plan.getCod_plan())%>>
				</div>
			</td>			
		</tr>
		<%}%>
		</table> 

		
		<%if (plan != null) { %>
			<button type="submit" class="btn btn-primary"  value="Modificar" name="btnSave" onclick="return confirm('Esta seguro que desea modificar?');">Modificar</button>	
		<%}else{%>
			<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="return confirm('Esta seguro que desea guardar?');">Realizar alta</button>
		<%}%>
			
	<br>
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
<br>
<div class="form-group">
<form action="CuotaList">
<input name="accion" type="hidden" value="listarGrado">
<button type="submit" class="btn btn-primary"  value="Volver al listado de Cuotas">Volver al listado de Cuotas</button>
</form>
</div>

</div>
   <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

	<!-- menú superior -->
	<script src="js/menu_admin.js"></script>
	
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/entrevista.js"></script> <!-- DatePic para entrevistas -->
	
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
</body>
</html>
