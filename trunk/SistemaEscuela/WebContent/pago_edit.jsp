<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Alumno"%>
<%@page import="conexion.AccionesAlumno"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Listado de pagos por dia</title>

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
 if (session.getAttribute("admin") != null) {
	 
 	Cuota cuota = (Cuota) session.getAttribute("pagoEdit");
    int dni = (Integer) session.getAttribute("dni");
 	int año = (Integer) session.getAttribute("año");
 	int mes = (Integer) session.getAttribute("mes");
 	
 	if (cuota != null){
 %>  		
 <div class="page-header">  	  
	<h1>Modificar Pago</h1>		
 </div>
 <%}else{%>
  <div class="page-header">  	  
	<h1>Alta de Pago</h1>		
 </div> 
 <%}%>
<%
	Alumno a = null;
		
	if (cuota != null){
	
		a = AccionesAlumno.getOne(cuota.getDni());
	%>	
<h2><%=a.getNombre() + " " + a.getApellido() + " - Año " + cuota.getAño() + " - Mes = " + cuota.getPeriodo() %></h2>
   <%}else{ 
   		
   		a = AccionesAlumno.getOne(dni);
   	%>
   	
<h2><%=a.getNombre() + " " + a.getApellido() + " - Año " + año + " - Mes= " + mes %></h2>

   <%}  
	
	int dia_pago = 0;
	String mes_pago = "";
	int año_pago = 0;
	
	if (cuota != null) {
		//recupero la fecha
		String fecha_pago = cuota.getFecha();
		//separo la fecha (1990-01-01) por el "-"" y almaceno el año, mes y dia en un array
		String[] fecha_ent = fecha_pago.split ("-");
		//obtengo el dia, mes y año respectivamente
		dia_pago = Integer.parseInt(fecha_ent[fecha_ent.length - 1]);
		mes_pago = fecha_ent[fecha_ent.length - 2];
		año_pago = Integer.parseInt(fecha_ent[fecha_ent.length - 3]);
		
	}else{	
	//Alta de pago	
	   	dia_pago = Integer.valueOf((String)session.getAttribute("dia_sys"));
		
	   	mes_pago = (String) session.getAttribute("mes_sys");
	   	
	   	//System.out.println("mes_pago= " + mes_pago);
	   	//System.out.println("mes_pago.substring(0,1)= " + mes_pago.substring(0,1));	   	
	   	
	   	if (!mes_pago.substring(0,1).equals("1")){		
	   		mes_pago = "0" + mes_pago;	   	
	   	}
	   	
	   	año_pago = Integer.valueOf((String)session.getAttribute("año_sys"));
	 //Alta de pago  
	}
		
   	%>
   	<div class="form-group">   	
	<form action="CuotaEdit" method="<%=cuota!= null?"post":"get"%>">
	<%if (cuota != null) { %>
	<input name=accion type=hidden value ="modificarPago">
	<%}else{%>
	<input name=accion type=hidden value ="altaPago">
	<%}%>	
	<table class="table table-hover table-bordered">
				<tr>
				<td>Fecha </td>
				<td><select name="dia_pago">   
					<%  
					for (int i = 1; i <= 31; i++){			  	
		 			%>
					 	<option <%=dia_pago==i ? "selected" : ""%>><%=i%></option>		 	
		   			<%
					}	
					%>

		 		</select>
		 		
  			 	<select name="mes_pago">
  			 	
  			 	<option value="01" <%=mes_pago.equals("01") ? "selected" : ""%>>Enero</option>
			 	<option value="02" <%=mes_pago.equals("02") ? "selected" : ""%>>Febrero</option>
			 	<option value="03" <%=mes_pago.equals("03") ? "selected" : ""%>>Marzo</option>
			 	<option value="04" <%=mes_pago.equals("04") ? "selected" : ""%>>Abril</option>
			 	<option value="05" <%=mes_pago.equals("05") ? "selected" : ""%>>Mayo</option>
			 	<option value="06" <%=mes_pago.equals("06") ? "selected" : ""%>>Junio</option>
				<option value="07" <%=mes_pago.equals("07") ? "selected" : ""%>>Julio</option>
			 	<option value="08" <%=mes_pago.equals("08") ? "selected" : ""%>>Agosto</option>
			 	<option value="09" <%=mes_pago.equals("09") ? "selected" : ""%>>Septiembre</option>
				<option value="10" <%=mes_pago.equals("10") ? "selected" : ""%>>Octubre</option>
			 	<option value="11" <%=mes_pago.equals("11") ? "selected" : ""%>>Noviembre</option>
			 	<option value="12" <%=mes_pago.equals("12") ? "selected" : ""%>>Diciembre</option>	   			 		
 			 	</select> 			 	
		  		</td>
		  		<td> <input name="año_pago" type="hidden" value="<%=año%>">  </td>
		  	<tr>	
		<tr>
			<td>PAGO</td>
			<td><input type="text" class="form-control" placeholder="importe" name="pago" value="<%=cuota!=null?cuota.getPago(): ""%>"></td>
		</tr>
		
		<tr>
			<td>OBSERVACIONES</td>
			<td><textarea class="form-control" placeholder="Observaciones" name="obs" cols="40" rows="1"><%=cuota!=null?cuota.getObservaciones(): ""%></textarea></td>			
		</tr>
		
	</table> 
	<br>
	<br>
	<%if (cuota != null) { %>	
	<button type="submit" class="btn btn-primary"  value="Realizar modificación">Realizar modificación</button>	
	<%}else{%>	
	<button type="submit" class="btn btn-primary"  value="Realizar alta">Realizar alta</button>
	<%}%>	
	</form>
</div>
<br>
<br>
<div class="form-group">
	<form action="CuotaList" method="get">
	<input name="accion" type="hidden" value="visualizarPagos">
	<button type="submit" class="btn btn-primary"  value="Volver atrás">Volver atrás</button>
</form>
</div>
 <%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</div>
</body>
</html>