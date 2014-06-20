<%@page import="datos.Cuota"%>
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
<body>
	<center>
	
	<%
		Cuota c = (Cuota)session.getAttribute("cuota");
		if(c==null){
			%>
			<h1>Alta Cuota</h1>
			<form action="CuotaList" method="post" id="formGrado" onsubmit="return validarGrado()">
	  <table>
	    <tr>
	      <th>Seleccionar grado:</th>
	      <td><select name="grado">
	            <option value=""></option>
	            <option value="Sala 4">Sala de 4</option>
	            <option value="Sala 5">Sala de 5</option>
	            <option value="1ro">1�</option>
	            <option value="2do">2�</option>
	            <option value="3ro">3�</option>
	            <option value="4to">4�</option>
	            <option value="5to">5�</option>
	            <option value="6to">6�</option>
	            <option value="7mo">7�</option>
	          </select>
	      </td>
	    </tr>
	    <tr>
	      <th>Seleccionar turno:</th>
	      <td><select name="turno">
	            <option value=""></option>
	            <option value="ma�ana">ma�ana</option>
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
			if(c!=null){
			%>
			<h1>Edici�n de Datos</h1>
			<%}%>
  			<form action="CuotaEdit" method="post" id="formAlta" onsubmit="return altaCuota()">
    		  <table>
      		    <tr>
                  <th>ALUMNO:</th>
                  
                    	<%	
                    		if(c==null){
                    			%>
                    			<td>
                                  <select name="dni">
                    			    <option value=""></option>
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
        	        		    	if(c.getDni()==alumno.getDni()){
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
                 <th>A�O:</th>
                   
                     <%
                     if(c==null){
                    	 %>
                    	 <td><select name="a�o">
                    	 <% 
                    	 int a�o=(Integer)session.getAttribute("a�o");
               	       for(int i=a�o;i>a�o-20;i--){
               		 %>
               		     <option value="<%=i %>"><%=i %></option>
               		 <%
               	}
                       %>
                         </select>
                     </td>
                     <% 
                     }else{
                    	 %>
                    	 <td><select name="a�o">
                    	 <option value="<%=c.getA�o() %>"><%=c.getA�o() %></option>
                    	 </select>
                    	 </td>
                    	 <% 
                     }
                     %>
                      
               </tr>
               <tr>
                 <th>PERIODO:</th>
                 
                    	<%
                    		if(c==null){
                    			%>
                    			<td>
                                <select name="periodo">
                                  <option value=""></option>
                                  <option value="Marzo">Marzo</option>
				                  <option value="Abril">Abril</option>
				                  <option value="Mayo">Mayo</option>
				                  <option value="Junio">Junio</option>
				                  <option value="Julio">Julio</option>
				                  <option value="Agosto">Agosto</option>
				                  <option value="Septiembre">Septiembre</option>
				                  <option value="Octubre">Octubre</option>
				                  <option value="Noviembre">Noviembre</option>
				                  <option value="Diciembre">Diciembre</option>
				                </select>
                 </td>
                                  <% 
                    		}else{
                    			%>
                    			<td><select name="periodo">
                    			      <option value="<%=c.getPeriodo() %>"><%=c.getPeriodo() %></option> 
                    			    </select>
                    			</td>
                    			<% 
                    		}
                    	%>
                     
  	           <tr>
      <th>REINSCRIPCI�N</th>
      <%
      	if(c==null){
      		%>
      		<td><input type="checkbox" name="reinsc"></td>
      		<% 
      	}else{
      		%>
      		<td><%
      		if(c.getReinscripcion()==1){
      		%>
      		<input type="checkbox" name="reinsc" checked="checked">
      		<% 
      		}else{
      			%>
      			<input type="checkbox" name="reinsc">
      			<%
      		}
      %>
      </td>
      <%
      	}
      %>
      
    </tr>
    			<tr>
  	             <th>REINSCRIPCI�N ANTICIPADA</th>
  	             <%
      	if(c==null){
      		%>
      		<td><input type="checkbox" name="reinsc_ant"></td>
      		<% 
      	}else{
      		%>
      		<td><%
      		if(c.getReinscripcion_ant()==1){
      		%>
      		<input type="checkbox" name="reinsc_ant" checked="checked">
      		<% 
      		}else{
      			%>
      			<input type="checkbox" name="reinsc_ant">
      			<%
      		}
      %>
      </td>
      <%
      	}
      %>
  	           </tr>
  	           <tr>
  	             <td></td>
  	             <td>
  	               <input type="submit" value="Aceptar">
  	               <input type="reset" value="Cancelar">
  	               <input type="hidden" name="error" value=" ERROR!! NO HAY PRECIO CARGADO PARA EL A�O VIGENTE O ESA CUOTA YA EXISTE">
  	             </td>
  	           </tr>   
             </table>
  </form>
  <br>
  <br>
		<%
		session.setAttribute("activador", null);
		}
	%>
	 <form action="menu_cuotas.jsp" method="post">
    <input type="submit" value="Volver al Men� de Cuotas">
  </form>
  <br>
  <br>
  <form action="CerrarSesion" method="get">
    <input type="submit" value="Cerrar Sesi�n">
  </form>
	</center>
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
 function altaCuota(){
	 var dni = form.dni.value;
	 var a�o = form.a�o.value;
	 var periodo = form.periodo.value;
	 
	 if(dni==''){
		 alert('Debe completar el dni');
		 return false;
	 }
	 if(a�o==''){
		 alert('Debe completar el a�o');
		 return false;
	 }
	 if(periodo==''){
		 alert('Debe completar el periodo');
		 return false;
	 }
	 if(dni!='' && a�o!='' && periodo!=''){
		 return true;
	 }
 }
	</script> 
	<%String error = (String)session.getAttribute("error");
    if(error!=null){
    	 %>
    	 <center><h3><%=error %></h3></center>
    	 <% 
    	 session.setAttribute("error", null);
    }
    %>
</body>
</html>