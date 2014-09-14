<%@page import="conexion.AccionesAlumno"%>
<%@page import="datos.Tardanza"%>
<%@page import="conexion.AccionesTardanza"%>
<%@page import="datos.Tardanzas"%>
<%@page import="datos.Alumno_Grado"%>
<%@page import="datos.Alumnos_Grados"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Alumnos</title>
</head>
<body>
<center>
	<h1>Listado de Tardanzas</h1>
	<form action="TardanzaList" method="get" id="formGrado" onsubmit="return validarGrado()">
	  <table>
	    <tr>
	      <th>Seleccionar año:</th>
	      <td>
	        <select name="año">
	      <% 
	      		int año = (Integer)session.getAttribute("año");
	      		for(int i=año;i>año-20;i--){
	            %>
	          <option value="<%=i %>"><%=i %></option>
	      		  <%
	      		}
	      		  %>
	        </select>
	      </td>
	    <tr>
	      <th>Seleccionar grado:</th>
	      <td><select name="grado">
	            <option value=""></option>
	            <option value="Sala 4">Sala de 4</option>
	            <option value="Sala 5">Sala de 5</option>
	            <option value="1ro">1º</option>
	            <option value="2do">2º</option>
	            <option value="3ro">3º</option>
	            <option value="4to">4º</option>
	            <option value="5to">5º</option>
	            <option value="6to">6º</option>
	            <option value="7mo">7º</option>
	          </select>
	      </td>
	    </tr>
	    <tr>
	      <th>Seleccionar turno:</th>
	      <td><select name="turno">
	            <option value=""></option>
	            <option value="MAÑANA">mañana</option>
	            <option value="TARDE">tarde</option>
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
		String activador=(String)session.getAttribute("activador");
		if(activador!=null){
			%>
    <table border="2">
      <tr>
        <th><%=session.getAttribute("grado") %></th>
        <th><%
        if(session.getAttribute("turno").equals("MAÑANA") || session.getAttribute("turno").equals("mañana")){
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
        <th>FECHA</th>
        <th>DNI</th>
        <th>NOMBRE</th>
        <th>APELLIDO</th>
        <th>OBSERVACIONES</th>
        <th>TIPO</th>
      </tr>
        
    		<%
            	Alumnos_Grados alumnos = (Alumnos_Grados)session.getAttribute("alumnos_grado");
                	
                    for(Alumno_Grado alumno:alumnos.getAlumnos_Grados()){
                    	Tardanzas t = AccionesTardanza.getAllTardanzas(alumno.getDni());
                    	for(Tardanza tardanza:t.getTardanzas()){
            %>
        	
        	<tr>
        	  <td><%=tardanza.getFecha()%></td>
        	  <td><%=tardanza.getDni()%></td>
        	  <td ><%=AccionesAlumno.getOneAlumno(tardanza.getDni()).getNombre()%></td>
        	  <td><%=AccionesAlumno.getOneAlumno(tardanza.getDni()).getApellido()%></td>
        	  <td><%=tardanza.getObservaciones()%></td>
        	  <td><%=tardanza.getTipo()%></td>
        	  <td><a href="TardanzaEdit?do=editar&&dni=<%=tardanza.getDni() %>&&fecha=<%=tardanza.getFecha() %>">Editar</a>
        	  <td><a href="TardanzaEdit?do=borrar&&dni=<%=tardanza.getDni() %>	&&fecha=<%=tardanza.getFecha() %>">Borrar</a></td>				
        	</tr>
        	  <% 
        	}
        }
    %>
    	</table>
			<% 
			session.setAttribute("activador", null);
		}
	%>
	<br>
	<br>
	<form action="menu_tardanzas.jsp">
	  <input type="submit" value="Vovler al Menú de Tardanzas">
	</form>
	<br>
	<br>
	<form action="CerrarSesion">
	  <input type="submit" value="Cerrar Sesión">
	</form>
	</center>
	
	  <script type="text/javascript">
 var form = document.getElementById("formGrado");
 function validarGrado(){
	 var año = form.año.value;
	 var grado = form.grado.value;
	 var turno = form.turno.value;
	 
	 if(grado=='' || turno=='' || año==''){
		 alert("Debe completar todos los campos");
		 return false;
	 }else{
		 return true;
	 }
 }
	</script> 
</body>
</html>