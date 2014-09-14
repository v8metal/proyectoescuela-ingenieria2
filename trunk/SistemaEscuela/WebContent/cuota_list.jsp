<%@page import="conexion.AccionesAlumno"%>
<%@page import="datos.Cuota"%>
<%@page import="conexion.AccionesCuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Alumno_Grado"%>
<%@page import="datos.Alumnos_Grados"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Listado de Cuotas</title>
</head>
<body>
	<center>
	<h1>Alumnos</h1>
	<form action="CuotaList" method="get" id="formGrado" onsubmit="return validarGrado()">
	  <table>
	  <tr>
	    <th>Seleccionar a�o:</th>
	    <td><select name="a�o">
	      		<%
	      		    int a�o = (Integer)session.getAttribute("a�o");
	      			for(int i=a�o; i>a�o-20;i--){
	      		%>	
	      	  <option value="<%=i %>"><%=i %></option>
	      		<%
	      			}
	      		%>
	        </select>
	  </tr>
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
	      <th>Seleccionar turno</th>
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
		String activador = (String)session.getAttribute("activador");
		if(activador!=null){
			%>

    <table border="2">
      <tr>
        <th><%=session.getAttribute("grado") %></th>
        <th><%
        if(session.getAttribute("turno").equals("MA�ANA") || session.getAttribute("turno").equals("ma�ana")){
	%>
    	TM
    	<%
		}else if(session.getAttribute("turno").equals("tarde") || session.getAttribute("turno").equals("TARDE")){
	%>
    		 TT
    		 <%
		}
	%>
		</th>
	</tr>	
      <tr>
        <th>A�O</th>
        <th>DNI</th>
        <th>NOMBRE</th>
        <th>APELLIDO</th>
        <th>REINSCRIPCI�N</th>
        <th>PERIODO</th>
        <th>REINSCRIPCI�N ANTICIPADA</th>
      </tr>
      <%
      	Alumnos_Grados alumnos = (Alumnos_Grados)session.getAttribute("alumnos_grado");
            	for(Alumno_Grado alumno:alumnos.getAlumnos_Grados()){
            		Cuotas c = AccionesCuota.getAll(alumno.getDni());
            		for(Cuota cuota:c.getCuotas()){
      %>
      	<tr>
      	  <td><%=cuota.getA�o()%></td>
      	  <td><%=cuota.getDni()%></td>
      	  <td><%=AccionesAlumno.getOneAlumno(cuota.getDni()).getNombre()%></td>
      	  <td><%=AccionesAlumno.getOneAlumno(cuota.getDni()).getApellido()%></td>
      	  <td><%
      	  	if(cuota.getReinscripcion()==1){
      	  		%>
      	  		<input type="checkbox" checked="checked" disabled>
     			<% 
      	  	}else{
      	  		%>
      	  		<input type="checkbox" disabled>
      	  		<% 
      	  	}
      	  	%>
         </td>
      	  <td><%=cuota.getPeriodo() %></td>
      	  <td><%
      	  	if(cuota.getReinscripcion_ant()==1){
      	  		%>
      	  		<input type="checkbox" checked="checked" disabled>
      	  	<% 
      	  	}else{
      	  	%>
     			<input type="checkbox" disabled>
     			<%
      	  	}
      		
      	
      	  	%>
      	  </td>
      	  <td><a href="CuotaEdit?dni=<%=cuota.getDni() %>&&a�o=<%=cuota.getA�o() %>&&periodo=<%=cuota.getPeriodo() %>">Editar</a></td>
      	  <% 
      	 }
      }
      	%>
      	</tr>
    </table>
			<% 
			session.setAttribute("activador", null);
		}
	%>
	<br>
	<br>
	<form action="menu_cuotas.jsp">
	  <input type="submit" value="Vovler al Men� de Cuotas">
	</form>
	<br>
	<br>
	<form action="CerrarSesion">
	  <input type="submit" value="Cerrar Sesi�n">
	</form>
	</center>
	
	  <script type="text/javascript">
 var form = document.getElementById("formGrado");
 function validarGrado(){
	 var a�o = form.a�o.value;
	 var grado = form.grado.value;
	 var turno = form.turno.value;
	 
	 if(grado=='' || turno=='' || a�o==''){
		 alert("Debe completar todos los campos");
		 return false;
	 }else{
		 return true;
	 }
 }
	</script> 
</body>
</html>