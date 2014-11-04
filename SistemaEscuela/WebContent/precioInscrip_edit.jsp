<%@page import="datos.PrecioInscrip"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Precios Inscripciones</title>

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
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "precioInscrip_edit.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
	
	int dia = 0;
	String mes = "";
	int año = 0;
	
	PrecioInscrip precio = (PrecioInscrip)session.getAttribute("precioInscrip");
	
    if (precio != null){
    	
    	String fecha = precio.getFecha_max();
		
		String[] fecha_ent = fecha.split ("-");		
		dia = Integer.parseInt(fecha_ent[fecha_ent.length - 1]);
		mes = fecha_ent[fecha_ent.length - 2];
		año = Integer.parseInt(fecha_ent[fecha_ent.length - 3]);
		
    }else{
    	
		dia = Integer.valueOf((String)session.getAttribute("dia_sys"));
		
		int mes_sys = Integer.valueOf((String) session.getAttribute("mes_sys"));
				
		if (mes_sys < 10){
			mes = "0" + mes_sys;	
		}else{
			mes = "" + mes_sys;
		}
    	
    	año = (Integer) session.getAttribute("añoPrecios");
    }%>
    
   <div class="page-header">
   <%if (precio == null){%>
		
	<h1>Ingreso de Precios - Inscripción <%=año%></h1>
	
<%}else{%>
	  
	<h1>Modificación de Precios - Inscripción <%=año%></h1>
			
<%}%> 
	</div>
	
	<div class="form-group">
	    
    <form action="PrecioEdit" method="post" id="formPrecio" onsubmit="return validarPrecio()">
    
      <table class="table table-hover table-bordered">
			<tr>
				<td>Fecha Maxima</td>				
				<td>
					<select name="dia_inscrip">   
					<%  
					for (int i = 1; i <= 31; i++){			  	
		 			%>
					 	<option <%=dia==i ? "selected" : ""%>><%=i%></option>		 	
		   			<%
					}	
					%>
		 			 </select>
		  			 <select name="mes_inscrip">
		  			 <option value="01" <%=mes.equals("01") ? "selected" : ""%>>Enero</option>
					 <option value="02" <%=mes.equals("02") ? "selected" : ""%>>Febrero</option>
					 <option value="03" <%=mes.equals("03") ? "selected" : ""%>>Marzo</option>
					 <option value="04" <%=mes.equals("04") ? "selected" : ""%>>Abril</option>
					 <option value="05" <%=mes.equals("05") ? "selected" : ""%>>Mayo</option>
					 <option value="06" <%=mes.equals("06") ? "selected" : ""%>>Junio</option>
					 <option value="07" <%=mes.equals("07") ? "selected" : ""%>>Julio</option>
					 <option value="08" <%=mes.equals("08") ? "selected" : ""%>>Agosto</option>
					 <option value="09" <%=mes.equals("09") ? "selected" : ""%>>Septiembre</option>
					 <option value="10" <%=mes.equals("10") ? "selected" : ""%>>Octubre</option>
					 <option value="11" <%=mes.equals("11") ? "selected" : ""%>>Noviembre</option>
					 <option value="12" <%=mes.equals("12") ? "selected" : ""%>>Diciembre</option>	   			 		
		 			 </select>		 		 		 		 		 		 
				 <input readonly type="text" name="año_inscrip" value="<%=año%>"></td>
			</tr>
		<tr>
          <td>Precio:</td>
          <td><input type="text" class="form-control" placeholder="Precio Regular" name="regular" value="<%=precio!=null?precio.getPrecio():"" %>"></td>
        </tr>
        
        <tr>
          <td>Recargo</td>
          <td><input type="text" class="form-control" placeholder="Recargo" name="recargo" value="<%=precio!=null?precio.getRecargo():""%>"></td>
        </tr>
        <tr></tr>
        <tr>        
        <td></td>       
         <td>
         	 <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnSave" onclick="return confirm('Esta seguro que desea guardar?');">Aceptar</button>
         	 <button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave" onclick="return confirm('Esta seguro que desea cancelar?');">Cancelar</button>         
             <input type="hidden" name="error" value="ERROR!!!">
         </td>
       </tr>
      </table>
    </form>
    </div>    
    <br>
    <br>
    <center>
  	<div class="form-group">
		 <form action="PrecioList" method="get">
			<button type="submit" class="btn btn-primary"  value="Volver al Menú de Precios">Volver al Menú de Precios</button>
		</form>
	</div>
	</center> 
  <%String error = (String)session.getAttribute("error");
    if(error!=null){
    	 %>
    	<center><h3><%=error %></h3></center>
    	 <% 
    	 session.setAttribute("error", null);
    }
    %>    
 <script type="text/javascript">
 var form = document.getElementById("formPrecio");
 
 function validarPrecio(){
	 var año = form.año_inscrip.value;
	 var mes = form.mes_inscrip.value;
	 var dia = form.dia_inscrip.value;
	 var regular = form.regular.value;	 
	 var recargo = form.recargo.value;
	 
	 if(año=='' || mes=='' || dia=='' || regular=='' || recargo==''){
		 alert("Debe completar todos los campos");
		 return false;
	 }
	 
	 else if(isNaN(regular)){
		 alert('Debe ingresar sólo números');
		 return false;
	 }
	 else if(isNaN(recargo)){
		 alert('Debe ingresar sólo números');
		 return false;	
	 
	 }else{
		 return true;
	 }
	 
}
 
</script>
</div>
</body>
</html>