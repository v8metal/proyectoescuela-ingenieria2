<%@page import="datos.Tardanza"%>
<%@page import="datos.Maestro_Grado"%>
<%@page import="datos.Maestros_Grados"%>
<%@page import="conexion.AccionesAlumno"%>
<%@page import="datos.Alumno_Grado"%>
<%@page import="datos.Alumnos_Grados"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style.css" />
<title>Sistema Alumnado</title>
</head>
<body>
<%
	if (session.getAttribute("login") != null) {
%>
<center>
<% 
				Tardanza t = (Tardanza)session.getAttribute("asistencia");
				if(t==null){
					%><h1>Alta Asistencia</h1>
					<form action="AsistenciaListEdit" method="post" id="formGrado" onsubmit="return validarGrado()">
	  <table>
	    <tr>
	      <th>Seleccionar grado:</th>
	      <td><select name="grado">
	            <option value=""></option>
	            <%
	        	
          		Maestros_Grados maestros_grados = (Maestros_Grados)session.getAttribute("maestros_grados");
          		for(Maestro_Grado m:maestros_grados.getMaestros_Grados()){
          			%>
          			<option value="<%=m.getGrado() %>"><%=m.getGrado() %></option>
          			<%
          		}
          	%>
	            
	          </select>
	      </td>
	    </tr>
	    <tr>
	      <th>Seleccionar turno:</th>
	      <td><select name="turno">
	            <option value=""></option>
	            <option value="mañana">mañana</option>
	            <option value="tarde">tarde</option>
	      </select>
	      </td>
	    </tr>
	    <tr>
	      <td></td>
	      <td><input type="submit" value="Aceptar">
	          <input type="reset" value="Cancelar">
	      </td>
	    </tr>
	  </table>
	</form>
	<br>
	<br>
					<%
				}
			%>
	
	<%
		String activador = (String)session.getAttribute("activador");
		if(activador!=null){
			%>
			<h1><%if(t!=null){
					%>Edición de Datos
					<%
				}
			%>
			</h1>
			<form action="AsistenciaEdit" method="post" id="formAlta" onsubmit="return validarAlta()">
			  <table>
			    <tr>
			      <th>ALUMNO:</th>
			      <%
			      	if(t==null){
			      		%>
			      		<td>
	                    <select name="dni">
	                     <%
	    			    Alumnos_Grados alumnos = (Alumnos_Grados)session.getAttribute("alumnos_grado");
	        		    for(Alumno_Grado alumno:alumnos.getAlumnos_Grados()){
	    				%>
	    		          <option value="<%=alumno.getDni() %>"><%=AccionesAlumno.getOneAlumno(alumno.getDni()).getNombre() %>, <%=AccionesAlumno.getOneAlumno(alumno.getDni()).getApellido() %></option>
	    			<%
	        		}
	    			%>
	    		        </select>
	                  </td>
	                  <%
			      	}else{
			      		%>
			      		<td>
	                    <select name="dni">
	                     <%
	    			    Alumnos_Grados alumnos = (Alumnos_Grados)session.getAttribute("alumnos_grado");
	        		    for(Alumno_Grado alumno:alumnos.getAlumnos_Grados()){
	        		    	if(t.getDni()==alumno.getDni()){
	        		    		%>
	        		    		 <option value="<%=alumno.getDni() %>" selected><%=AccionesAlumno.getOneAlumno(alumno.getDni()).getNombre() %>, <%=AccionesAlumno.getOneAlumno(alumno.getDni()).getApellido() %></option>
	        		    		<%
	        		    	}else{
	        		    		%>
	        		    		<option value="<%=alumno.getDni() %>"><%=AccionesAlumno.getOneAlumno(alumno.getDni()).getNombre() %>, <%=AccionesAlumno.getOneAlumno(alumno.getDni()).getApellido() %></option>
	        		    	<%
	        		    	}
	    				%>
	    			
	    		          
	    			<%
	        		}
	    			%>
	    		        </select>
	                  </td>
	                  <%
			      	}
			      %>
			    </tr>
			    <tr>
			      <th>OBSERVACIONES:</th>
			      <td><textarea name="observaciones" cols="40" rows="4"><%=t!=null?t.getObservaciones():"" %></textarea></td>
			    </tr>
			    <tr>
			      <th>TIPO:</th>
			      <td><select name="tipo">
			            <option value="<%=t!=null?t.getTipo():"" %>"><%=t!=null?t.getTipo():"" %></option>
			            <% String tipo [] = new String[2];
			            	tipo[0]="presente";
			            	tipo[1]="ausente";
			            	if(t!=null){
			            	%>
			      	    <option value="<%=t.getTipo().equals("presente")?tipo[1]:tipo[0]%>"><%=t.getTipo().equals("presente")?tipo[1]:tipo[0]%></option>
			      	    <%
			            	}else{
			            		for(int i=0;i<2;i++){
			            			%>
			            			<option value="<%=tipo[i] %>"><%=tipo[i] %></option>
			            			<% 
			            		}
			            	}
			      	    %>
			      						    
			          </select>
			      </td>
			    </tr>
			    <tr>
			      <td></td>
			      <td><input type="submit" value="Cargar">
			          <input type="reset" value="Cancelar">
			          <input type="hidden" name="error" value="YA FUE CARGADA UNA ASISTENCIA O TARDANZA PARA EL ALUMNO">
			      </td>
			    </tr>  
			  </table>
			  </form>
			  <br>
			  <br>
			  
			<%
			session.setAttribute("activador", null);
			session.setAttribute("asistencia", null);
		}
			%>
	 			<form action="menu_asistencias.jsp" method="get">
			  		<input type="submit" value="Volver al Menú de Asistencias">
			 	</form>
			  	<br>
			  	<br>
			  	<form action="CerrarSesion" method="get">
			   	 <input type="submit" value="Cerrar Sesión">
			  	</form>
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
		 var form = document.getElementById("formGrado");
		 	function validarGrado(){
				 var grado = form.grado.value;
				 var turno = form.turno.value;
				 
				 if(grado=='' || turno==''){
					 alert("Debe completar todos los campos");
					 return false;
				 }else{
					 return true;
				 }
		 	}
	</script> 
	<script type="text/javascript">
			 	var form = document.getElementById("formAlta");
				function validarAlta(){
					 var dni = form.dni.value;
					 var tipo = form.tipo.value;
					 
					 if(dni==''){
						 alert('Debe completar el dni');
						 return false;
					 }
					 if(tipo==''){
						 alert('Debe completar el tipo');
						 return false;
					 }
					 if(dni!='' && tipo!=''){
						 return true;
					 }
				}
	</script>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>	 
</body>
</html>