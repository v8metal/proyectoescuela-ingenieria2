<%@page import="datos.Entrevista"%>
<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@page import="datos.Mensaje"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMensaje"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "entrevistas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Entrevistas</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<!--<link rel="stylesheet" href="style/jquery-ui.css">  con ese no se ven las flechitas-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">

</head>
<body>
<div class="container">
<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");
	if (AccionesUsuario.validarAcceso(tipo, "entrevista_list.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
	
	String nombre = "";
	String apellido = "";
%>

  <div id="divmenu">
  	<!-- sirve para visualizar el men� superior -->
  </div>
  
<%		if(session.getAttribute("dni_maestro") != null){
			Entrevista entrevista = (Entrevista)session.getAttribute("entrevista");
			%>
		
			  <div class="page-header">  
				  <h1>Edici�n de Datos</h1>
			  </div>
			  
			  <div class="form-group">
			  			  			  
			  <form action="EntrevistaEdit" method="post" id="formEditar" onsubmit="return validarEditar()">
			    
			    <table class="table table-hover table-bordered"> 

			    <tr>
				    <td><label for="input">Nombre del Alumno</label></td>
         			<td>
         				<div class="col-xs-5">
         				<input type="text" class="form-control" name="nombre_alum" placeholder="Nombre" value="<%=entrevista.getNombre()%>" autofocus>
         				</div>
         			</td>
         		</tr>
         		
			   	<tr>
				    <td><label for="input">Descripci�n</label></td>
         			<td>
         				<div class="col-xs-10">
         				<textarea class="form-control" cols="40" rows="4" name="desc" placeholder="Descripci�n"><%=entrevista.getDescripcion() %></textarea>
         				</div>
         			</td>
         		</tr>		    
			    			    
			    </table>
			    
			     <button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick=<%=AccionesMensaje.getOne(1).getMensaje()%>><i class="glyphicon glyphicon-floppy-disk"></i> Guardar</button>
				<button type="reset" class="btn btn-primary"   onclick=<%=AccionesMensaje.getOne(3).getMensaje()%>><i class="glyphicon glyphicon-remove"></i> Cancelar</button>				
			  
			  </form>
			  
			  </div>
			  
			  <br>
			  <br>		  
			  
			  <div class="form-group">
				<form action="EntrevistaList" method="post">
				<button type="submit" class="btn btn-primary"  value="Volver al Listado"><i class="glyphicon glyphicon-share-alt"></i> Volver al Listado</button>
				</form>
			</div>			 	 
	<% 
		}else{
			
			Entrevista entrevista = (Entrevista) session.getAttribute("entrevista_edit");
		  	
			//Maestros maestros = null;
		  	Maestros maestros = new Maestros();
		  	
			//int dia_entrevista = 0;
			String mes_entrevista = "";
			//int a�o_entrevista = 0;
					
			// verifico qe se alla pasado un alumno (caso moficar)
			if (entrevista != null) {
				//recupero la fecha
				String fecha_entrevista = entrevista.getFecha();
				//separo la fecha (1990-01-01) por el "-"" y almaceno el a�o, mes y dia en un array
				String[] fecha_ent = fecha_entrevista.split ("-");
				//obtengo el dia, mes y a�o respectivamente
				//dia_entrevista = Integer.parseInt(fecha_ent[fecha_ent.length - 1]);
				mes_entrevista = fecha_ent[fecha_ent.length - 2];
				//a�o_entrevista = Integer.parseInt(fecha_ent[fecha_ent.length - 3]);
			}else{	
			//Alta de entrevista		
				//if (request.getAttribute("maestros_ent_alta") != null){
					maestros = (Maestros) session.getAttribute("maestros_ent_alta");	
				//}
			
		    	//dia_entrevista = Integer.valueOf((String)session.getAttribute("dia_sys"));
		    	int mes= Integer.parseInt((String) session.getAttribute("mes_sys"));
		    	if (mes < 10){
		    		mes_entrevista = "0" + mes;	
		    	}else{
		    		mes_entrevista = "" + mes;
		    	}
		    		
		    	//mes_entrevista = "0" + (String) session.getAttribute("mes_sys");
		    	//a�o_entrevista = Integer.valueOf((String)session.getAttribute("a�o_sys"));
		  //Alta de entrevista  
			}	
		  %>
		<%if(entrevista != null){%>		
		<div class="page-header">  
			<h1>Modificaci�n de Entrevista</h1>
		</div>
		<h3><%="Entrevista para " + entrevista.getNombre()%></h3>
		<br>
		<%}else{%>
		<div class="page-header">  
			<h1>Alta de Entrevista</h1>
		</div>
		<%}%>
		
		
		<%if(entrevista == null && maestros.getLista().isEmpty()) {     
    	
			Mensaje m = AccionesMensaje.getOne(61);%>
			<div class="alert <%=m.getTipo() %>" role="alert">
	  		<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      		<%=m.getMensaje()%> <a href="maestroEdit?accion=alta" class="alert-link"> Nuevo Maestro <i class="glyphicon glyphicon-edit"></i></a>
    		</div>
        
    	<%}else{ %>
		
		<div class="form-group">
		
		<form action="EntrevistaEdit" method="post">
		<%if(entrevista != null){%>
		<input type="hidden" name="action" value="modificar">
		<%}else{%>
		<input type="hidden" name="action" value="alta">
		<%}%>
		
		<input id="mesbase" type="hidden" value="<%=mes_entrevista%>">
		<input name="fecha" id="fecha" type="hidden" value="<%=entrevista!=null? entrevista.getFecha() : "0"%>">
		
		<table id="TablaEntrevistas" class="table table-hover table-bordered">
			<tr>
			<td><label for="input">Fecha</label></td>			
				<td>
				<div class="col-xs-2">
					<input class="form-control" type="text" id="datepicker" required autofocus name="fecha_entrevista">
				</div>
				</td>			
		  	</tr>
		  	<tr>
				<td><label for="input">Hora</label></td>
				<td>
				<div class="col-xs-2">
				<select name="hora_entrevista" class="form-control">
					 <option value="08:00:00" <%=entrevista!=null && entrevista.getHora().equals("08:00:00") ? "selected" : ""%>>08:00</option>
					 <option value="08:15:00" <%=entrevista!=null && entrevista.getHora().equals("08:15:00") ? "selected" : ""%>>08:15</option>
		  			 <option value="08:30:00" <%=entrevista!=null && entrevista.getHora().equals("08:30:00") ? "selected" : ""%>>08:30</option>
		  			 <option value="08:45:00" <%=entrevista!=null && entrevista.getHora().equals("08:45:00") ? "selected" : ""%>>08:45</option>
		  			 <option value="09:00:00" <%=entrevista!=null && entrevista.getHora().equals("09:00:00") ? "selected" : ""%>>09:00</option>
		  			 <option value="09:15:00" <%=entrevista!=null && entrevista.getHora().equals("09:15:00") ? "selected" : ""%>>09:15</option>
		  			 <option value="09:30:00" <%=entrevista!=null && entrevista.getHora().equals("09:30:00") ? "selected" : ""%>>09:30</option>
		  			 <option value="09:45:00" <%=entrevista!=null && entrevista.getHora().equals("09:45:00") ? "selected" : ""%>>09:45</option>
		  			 <option value="10:00:00" <%=entrevista!=null && entrevista.getHora().equals("10:00:00") ? "selected" : ""%>>10:00</option>
		  			 <option value="10:15:00" <%=entrevista!=null && entrevista.getHora().equals("10:15:00") ? "selected" : ""%>>10:15</option>
		  			 <option value="10:30:00" <%=entrevista!=null && entrevista.getHora().equals("10:30:00") ? "selected" : ""%>>10:30</option>
		  			 <option value="10:45:00" <%=entrevista!=null && entrevista.getHora().equals("10:45:00") ? "selected" : ""%>>10:45</option>
		  			 <option value="11:00:00" <%=entrevista!=null && entrevista.getHora().equals("11:00:00") ? "selected" : ""%>>11:00</option>
		  			 <option value="11:15:00" <%=entrevista!=null && entrevista.getHora().equals("11:15:00") ? "selected" : ""%>>11:15</option>
		  			 <option value="11:30:00" <%=entrevista!=null && entrevista.getHora().equals("11:30:00") ? "selected" : ""%>>11:30</option>
		  			 <option value="11:45:00" <%=entrevista!=null && entrevista.getHora().equals("11:45:00") ? "selected" : ""%>>11:45</option>
		  			 <option value="12:00:00" <%=entrevista!=null && entrevista.getHora().equals("12:00:00") ? "selected" : ""%>>12:00</option>
		  			 <option value="12:15:00" <%=entrevista!=null && entrevista.getHora().equals("12:15:00") ? "selected" : ""%>>12:15</option>
		  			 <option value="12:30:00" <%=entrevista!=null && entrevista.getHora().equals("12:30:00") ? "selected" : ""%>>12:30</option>
		  			 <option value="12:45:00" <%=entrevista!=null && entrevista.getHora().equals("12:45:00") ? "selected" : ""%>>12:45</option>
		  			 <option value="13:00:00" <%=entrevista!=null && entrevista.getHora().equals("13:00:00") ? "selected" : ""%>>13:00</option>
		  			 <option value="13:15:00" <%=entrevista!=null && entrevista.getHora().equals("13:15:00") ? "selected" : ""%>>13:15</option>
		  			 <option value="13:30:00" <%=entrevista!=null && entrevista.getHora().equals("13:30:00") ? "selected" : ""%>>13:30</option>
		  			 <option value="13:45:00" <%=entrevista!=null && entrevista.getHora().equals("13:45:00") ? "selected" : ""%>>13:45</option>
		  			 <option value="14:00:00" <%=entrevista!=null && entrevista.getHora().equals("14:00:00") ? "selected" : ""%>>14:00</option>
		  			 <option value="14:15:00" <%=entrevista!=null && entrevista.getHora().equals("14:15:00") ? "selected" : ""%>>14:15</option>
		  			 <option value="14:30:00" <%=entrevista!=null && entrevista.getHora().equals("14:30:00") ? "selected" : ""%>>14:30</option>
		  			 <option value="14:45:00" <%=entrevista!=null && entrevista.getHora().equals("14:45:00") ? "selected" : ""%>>14:45</option>
		  			 <option value="15:00:00" <%=entrevista!=null && entrevista.getHora().equals("15:00:00") ? "selected" : ""%>>15:00</option>
		  			 <option value="15:15:00" <%=entrevista!=null && entrevista.getHora().equals("15:15:00") ? "selected" : ""%>>15:15</option>
		  			 <option value="15:30:00" <%=entrevista!=null && entrevista.getHora().equals("15:30:00") ? "selected" : ""%>>15:30</option>
		  			 <option value="15:45:00" <%=entrevista!=null && entrevista.getHora().equals("15:45:00") ? "selected" : ""%>>15:45</option>
		  			 <option value="16:00:00" <%=entrevista!=null && entrevista.getHora().equals("16:00:00") ? "selected" : ""%>>16:00</option>
		  			 <option value="16:15:00" <%=entrevista!=null && entrevista.getHora().equals("16:15:00") ? "selected" : ""%>>16:15</option>
		  			 <option value="16:30:00" <%=entrevista!=null && entrevista.getHora().equals("16:30:00") ? "selected" : ""%>>16:30</option>
		  			 <option value="16:45:00" <%=entrevista!=null && entrevista.getHora().equals("16:45:00") ? "selected" : ""%>>16:45</option>
		  			 <option value="17:00:00" <%=entrevista!=null && entrevista.getHora().equals("17:00:00") ? "selected" : ""%>>17:00</option>
		  			 <option value="17:15:00" <%=entrevista!=null && entrevista.getHora().equals("17:15:00") ? "selected" : ""%>>17:15</option>
		  			 <option value="17:30:00" <%=entrevista!=null && entrevista.getHora().equals("17:30:00") ? "selected" : ""%>>17:30</option>
		  			 <option value="17:45:00" <%=entrevista!=null && entrevista.getHora().equals("17:45:00") ? "selected" : ""%>>17:45</option>  			 
		  		</select>  
		  		</div>			 
				</td>
			</tr>	
		<%if(entrevista == null){%>
			<tr>
				<td><label for="input">Maestro</label></td>
				<td>
				<div class="col-xs-5">
				<select required name="maestro_entrevista" class="form-control">		
				<%
				for (Maestro m : maestros.getLista()){		 		
		 		%>  			  
		   			<option value="<%=m.getDni()%>"><%=m.getNombre()+ " " + m.getApellido()%> </option>   			  
		   		 <%   			
				}		
				%>
				</select>
				</div>
			</tr>	
			<tr>
				<td><label for="input">Nombre</label></td>
				<td>
				<div class="col-xs-5">
				<input class="form-control" type="text" name="nombre_entrevista" required value="<%=entrevista!=null? entrevista.getNombre() : ""%>">
				</div>
				</td>
			</tr>
		<%}%>
		</table>
		<br>
			
		<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick=<%=AccionesMensaje.getOne(1).getMensaje()%>><i class="glyphicon glyphicon-floppy-disk"></i> Guardar</button>
		<button type="reset" class="btn btn-primary"   onclick=<%=AccionesMensaje.getOne(3).getMensaje()%>><i class="glyphicon glyphicon-remove"></i> Cancelar</button>
		
		</form>
		</div>		
		<%
		Mensaje mensaje = null;			
		if (session.getAttribute("mensaje") != null) {				
			mensaje = (Mensaje) session.getAttribute("mensaje");
			session.setAttribute("mensaje", null);				   
		%>
		<!-- MENSAJE DE WARNING -->
		<br>
		<div class="alert <%=mensaje.getTipo()%> fade in" role="alert">
     		 <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 	 <%=mensaje.getMensaje()%>
  	  	</div>
  	  	 <%}%>
		<br>			
		<div class="form-group">
		<form action="EntrevistaList" method="post">
		<button type="submit" class="btn btn-primary"  value="Volver al Listado"><i class="glyphicon glyphicon-share-alt"></i> Volver al Listado</button>
		</form>
		</div>
		<%}%>
<%}%>
</div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

	<!-- men� superior -->
	<script src="js/menu_admin.js"></script> 
	<script src="js/menu_user.js"></script>
	
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/entrevista.js"></script> <!-- DatePic para entrevistas -->
</body> 
</html>