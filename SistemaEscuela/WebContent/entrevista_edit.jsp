<%@page import="datos.Entrevista"%>
<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@page import="conexion.AccionesUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Entrevistas</title>

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
              <li class="active" class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Entrevistas <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="EntrevistaList">Listado</a></li>
                  <li><a href="EntrevistaEdit?do=alta">Nueva entrevista</a></li>          
                </ul>
              </li>
              <li><a href="menu_cuotas.jsp">Cuotas</a></li>
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
	if (AccionesUsuario.validarAcceso(tipo, "entrevista_edit.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
	
		if(session.getAttribute("dni_maestro") != null){
			Entrevista entrevista = (Entrevista)session.getAttribute("entrevista");
			%>
		
			  <div class="page-header">  
				  <h1>Edición de Datos</h1>
			  </div>
			  
			  <div class="form-group">
			   			
			  <form action="EntrevistaEdit" method="post" id="formEditar" onsubmit="return validarEditar()">
			    
			    <table class="table table-hover table-bordered"> 
			        
			    <tr>
				    <td><label for="input">Nombre del Alumno</label></td>
         			<td><input type="text" class="form-control" name="nombre_alum" placeholder="Nombre" value="<%=entrevista.getNombre()%>"></td>
         		</tr>
         		
			   	<tr>
				    <td><label for="input">Descripción</label></td>
         			<td><textarea class="form-control" cols="40" rows="4" name="desc" placeholder="Descripción"><%=entrevista.getDescripcion() %></textarea></td>
         		</tr>		    
			    			    
			    </table>
			    
			    
			    <button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="return confirm('Esta seguro que desea guardar?');">Guardar</button>
				<button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave">Cancelar</button>
				
			  
			  </form>
			  
			  </div>
			  
			  <br>
			  <br>		  
			  
			  <div class="form-group">
				<form action="menu_user.jsp" method="get">
				<button type="submit" class="btn btn-primary"  value="Volver al Menú Principal">Volver al Menú Principal</button>
				</form>
			  </div>

			  <br>
			  <br>
			  
			  <div class="form-group">
				<form action="CerrarSesion" method="get">
				<button type="submit" class="btn btn-primary"  value="Cerrar Sesión">Cerrar Sesión</button>
				</form>
			  </div>			  
			 		    
			   <script type="text/javascript">
			 var form = document.getElementById("formEditar");
			 function validarEditar(){
				var nombre_alum =form.nombre_alum.value;
				var desc = form.desc.value;
				 
				 if(nombre_alum=='' || desc==''){
					 alert("Debe completar todos los campos");
					 return false;
				 }else{
					 return true;
				 }
			 }
				</script> 
				<% 
		}else{
			
			Entrevista entrevista = (Entrevista) session.getAttribute("entrevista_edit");
		  	
			String error = "";
			
			if (session.getAttribute("error") != null) {
				//System.out.println("error != null");
				error = (String) session.getAttribute("error");
				System.out.println(error);
				session.setAttribute("error", "");
			}
		   
		  	//Maestros maestros = null;
		  	Maestros maestros = new Maestros();
		  	
			int dia_entrevista = 0;
			String mes_entrevista = "";
			int año_entrevista = 0;
					
			// verifico qe se alla pasado un alumno (caso moficar)
			if (entrevista != null) {
				//recupero la fecha
				String fecha_entrevista = entrevista.getFecha();
				//separo la fecha (1990-01-01) por el "-"" y almaceno el año, mes y dia en un array
				String[] fecha_ent = fecha_entrevista.split ("-");
				//obtengo el dia, mes y año respectivamente
				dia_entrevista = Integer.parseInt(fecha_ent[fecha_ent.length - 1]);
				mes_entrevista = fecha_ent[fecha_ent.length - 2];
				año_entrevista = Integer.parseInt(fecha_ent[fecha_ent.length - 3]);
			}else{	
			//Alta de entrevista		
				//if (request.getAttribute("maestros_ent_alta") != null){
					maestros = (Maestros) session.getAttribute("maestros_ent_alta");	
				//}
			
		    	dia_entrevista = Integer.valueOf((String)session.getAttribute("dia_sys"));
		    	int mes= Integer.parseInt((String) session.getAttribute("mes_sys"));
		    	if (mes < 10){
		    		mes_entrevista = "0" + mes;	
		    	}else{
		    		mes_entrevista = "" + mes;
		    	}
		    		
		    	//mes_entrevista = "0" + (String) session.getAttribute("mes_sys");
		    	año_entrevista = Integer.valueOf((String)session.getAttribute("año_sys"));
		  //Alta de entrevista  
			}	
		  %>
		<%if(entrevista != null){%>		
		<div class="page-header">  
			<h1>Modificación de Entrevista</h1>
		</div>
		<h2><%="Entrevista para " + entrevista.getNombre()%></h2>
		<%}else{%>
		<div class="page-header">  
			<h1>Alta de Entrevista</h1>
		</div>
		<%}%>
		
		<div class="form-group">
		
		<form action="EntrevistaEdit" method="post">
		<%if(entrevista != null){%>
		<input type="hidden" name="action" value="modificar">
		<%}else{%>
		<input type="hidden" name="action" value="alta">
		<%}%>
		
		<input id="mesbase" type="hidden" value="<%=mes_entrevista%>">
				
		<table id="TablaEntrevistas" class="table table-hover table-bordered">
			<tr>
				<td>Fecha </td>
				<td><select name="dia_entrevista" class="form-control" autofocus>   
					<%  
					for (int i = dia_entrevista; i <= 31; i++){			  	
		 			%>
					 	<option <%=dia_entrevista==i ? "selected" : ""%>><%=i%></option>		 	
		   			<%
					}	
					%>
		 			 </select>
		  			 <select id="mes" name="mes_entrevista" class="form-control">
		  			 <option value="01" <%=mes_entrevista.equals("01") ? "selected" : ""%>>Enero</option>
					 <option value="02" <%=mes_entrevista.equals("02") ? "selected" : ""%>>Febrero</option>
					 <option value="03" <%=mes_entrevista.equals("03") ? "selected" : ""%>>Marzo</option>
					 <option value="04" <%=mes_entrevista.equals("04") ? "selected" : ""%>>Abril</option>
					 <option value="05" <%=mes_entrevista.equals("05") ? "selected" : ""%>>Mayo</option>
					 <option value="06" <%=mes_entrevista.equals("06") ? "selected" : ""%>>Junio</option>
					 <option value="07" <%=mes_entrevista.equals("07") ? "selected" : ""%>>Julio</option>
					 <option value="08" <%=mes_entrevista.equals("08") ? "selected" : ""%>>Agosto</option>
					 <option value="09" <%=mes_entrevista.equals("09") ? "selected" : ""%>>Septiembre</option>
					 <option value="10" <%=mes_entrevista.equals("10") ? "selected" : ""%>>Octubre</option>
					 <option value="11" <%=mes_entrevista.equals("11") ? "selected" : ""%>>Noviembre</option>
					 <option value="12" <%=mes_entrevista.equals("12") ? "selected" : ""%>>Diciembre</option>	   			 		
		 			 </select>
		<%if(entrevista != null){%>
					 <select name="año_entrevista" class="form-control">
					<%
					for (int i = 1900; i < 2090; i++){
		 			 %>
		 			 	<option <%=año_entrevista==i ? "selected" : ""%>><%=i%></option>
					<%
					 }
					 %>
		  			 </select>
		  <%}%>
		  		</td>
		  	<tr>
				<td>Hora</td>
				<td>
				<select name="hora_entrevista" class="form-control">
					 <option value="08:00:00" <%=entrevista!=null && entrevista.getHora().equals("08:00:00") ? "selected" : ""%>>08:00</option>
		  			 <option value="08:30:00" <%=entrevista!=null && entrevista.getHora().equals("08:30:00") ? "selected" : ""%>>08:30</option>
		  			 <option value="09:00:00" <%=entrevista!=null && entrevista.getHora().equals("09:00:00") ? "selected" : ""%>>09:00</option>
		  			 <option value="09:30:00" <%=entrevista!=null && entrevista.getHora().equals("09:30:00") ? "selected" : ""%>>09:30</option>
		  			 <option value="10:00:00" <%=entrevista!=null && entrevista.getHora().equals("10:00:00") ? "selected" : ""%>>10:00</option>
		  			 <option value="10:30:00" <%=entrevista!=null && entrevista.getHora().equals("10:30:00") ? "selected" : ""%>>10:30</option>
		  			 <option value="11:00:00" <%=entrevista!=null && entrevista.getHora().equals("11:00:00") ? "selected" : ""%>>11:00</option>
		  			 <option value="11:30:00" <%=entrevista!=null && entrevista.getHora().equals("11:30:00") ? "selected" : ""%>>11:30</option>
		  			 <option value="12:00:00" <%=entrevista!=null && entrevista.getHora().equals("12:00:00") ? "selected" : ""%>>12:00</option>
		  			 <option value="12:30:00" <%=entrevista!=null && entrevista.getHora().equals("12:30:00") ? "selected" : ""%>>12:30</option>
		  			 <option value="13:00:00" <%=entrevista!=null && entrevista.getHora().equals("13:00:00") ? "selected" : ""%>>13:00</option>
		  			 <option value="13:30:00" <%=entrevista!=null && entrevista.getHora().equals("13:30:00") ? "selected" : ""%>>13:30</option>
		  			 <option value="14:00:00" <%=entrevista!=null && entrevista.getHora().equals("14:00:00") ? "selected" : ""%>>14:00</option>
		  			 <option value="14:30:00" <%=entrevista!=null && entrevista.getHora().equals("14:30:00") ? "selected" : ""%>>14:30</option>
		  			 <option value="15:00:00" <%=entrevista!=null && entrevista.getHora().equals("15:00:00") ? "selected" : ""%>>15:00</option>
		  			 <option value="15:30:00" <%=entrevista!=null && entrevista.getHora().equals("15:30:00") ? "selected" : ""%>>15:30</option>
		  			 <option value="16:00:00" <%=entrevista!=null && entrevista.getHora().equals("16:00:00") ? "selected" : ""%>>16:00</option>
		  			 <option value="16:30:00" <%=entrevista!=null && entrevista.getHora().equals("16:30:00") ? "selected" : ""%>>16:30</option>
		  			 <option value="17:00:00" <%=entrevista!=null && entrevista.getHora().equals("17:00:00") ? "selected" : ""%>>17:00</option>
		  			 <option value="17:30:00" <%=entrevista!=null && entrevista.getHora().equals("17:30:00") ? "selected" : ""%>>17:30</option>  			 
		  		</select>  			 
				</td>
			</tr>	
		<%if(entrevista == null){%>
			<tr>
				<td>Maestro</td>
				<td><select required name="maestro_entrevista" class="form-control">		
				<%
				for (Maestro m : maestros.getLista()){		 		
		 		%>  			  
		   			<option value="<%=m.getDni()%>"><%=m.getNombre()+ " " + m.getApellido()%> </option>   			  
		   		 <%   			
				}		
				%>
				</select>
			</tr>	
			<tr>
				<td>Nombre</td>
				<td><input class="form-control" type="text" name="nombre_entrevista" required value="<%=entrevista!=null? entrevista.getNombre() : ""%>"></td>
			</tr>
		<%}%>
		</table>
		<br>
				<%
		String mensaje= "return confirm('Esta seguro que desea realizar el alta?');"; 
		  
		if (entrevista != null){
			
			mensaje = "return confirm('Esta seguro que desea modificar?');"; 
		}
		 
		%>
	
		<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="<%=mensaje%>">Guardar</button>
		<button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave">Cancelar</button>
		
		</form>
		</div>		
		<br>
		<%if (!error.equals("")) {%>
		<%=error%>
		<br>
		<br>
		<%}%>		
		<div class="form-group">
		<form action="EntrevistaList" method="post">
		<button type="submit" class="btn btn-primary"  value="Volver al Listado">Volver al Listado</button>
		</form>
		</div>
		<% 
		}
		%>
</div>
</body>
</html>