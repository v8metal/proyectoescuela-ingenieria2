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
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Plan de Pagos</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<!-- <script src="js/jquery-1.7.2.min.js"></script> -->
<script src="js/bootstrap.min.js"></script>

<link rel="stylesheet" href="style/jquery-ui.css">
<!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css"> -->
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
			<td><label for="input">Fecha:</label></td>			
			<td>
			<div class="col-xs-5">
			<input <%if(plan!=null){%> readonly <%}%> class="form-control" type="text" id="datepicker" required autofocus name="fecha_pp">
			</div>			
			</td>			
	    </tr>		
		<%if (plan == null){%>
		<tr>
			<td> Alumno </td>		
			<td>
			<div class="col-xs-5">			
			<select name="dni">
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
			<td> Alumno </td>		
			<td>
				<div class="col-xs-5">	 
				<input readonly size = 40 name="alumno" type="text" value="<%= a.getNombre() + " " + a.getApellido() %>">
				</div>
			</td>			
	    </tr>
	    <%}%>
		<tr>		
			<td>Año Inicio</td>
			<td>
				<div class="col-xs-5">	
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
				</div>	
 			</td>
 		<tr>
			<td>Periodo Inicio</td>
			<td>
				<div class="col-xs-5">	
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
 			 	</div> 			  			 	
		  	</td>	  		
		</tr>
		
		<tr>
			<td>Año Fin</td>
			<td>
				<div class="col-xs-5">
				<select name="añofin">   
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
			<td>Periodo Fin</td>
			<td>
				<div class="col-xs-5">	
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
 			 	</div>
 			  			 	
		  		</td>		  		
		</tr>
		
		<tr>
			<td>Observaciones</td>
			<td>
				<div class="col-xs-5">	
				<textarea name="obs" cols="40" rows="1"><%=plan!=null?plan.getObservaciones(): ""%></textarea>
				</div>
			</td>			
		</tr>
		
		<%if(plan !=null){%>
		<tr>
			<td>TOTAL DE PAGOS</td>
			<td>
				<div class="col-xs-5">	
				<input readonly type=text name="total" value= <%=AccionesPlanPago.getTotalPlanPago(plan.getCod_plan())%>>
				</div>
			</td>			
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
<br>
<div class="form-group">
<form action="CuotaList">
<input name="accion" type="hidden" value="listarGrado">
<button type="submit" class="btn btn-primary"  value="Volver al listado de Cuotas">Volver al listado de Cuotas</button>
</form>
</div>
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
