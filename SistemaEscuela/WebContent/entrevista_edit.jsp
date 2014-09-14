<%@page import="datos.Entrevista"%>
<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Editar Entrevista</title>
</head>
<body>
<%
	if (session.getAttribute("login") != null) {
		if(!session.getAttribute("login").equals("admin")){
			Entrevista entrevista = (Entrevista)session.getAttribute("entrevista");
			%>
			 <center>
			    <h1>Edición de Datos</h1>
			  <form action="EntrevistaEdit" method="post" id="formEditar" onsubmit="return validarEditar()">
			    <table>
			     <tr>
			       <th>NOMBRE DEL ALUMNO</th>
			       <td><input type="text" name="nombre_alum" value="<%=entrevista.getNombre()%>"></td>
			     </tr>
			     <tr>
			       <th>DESCRIPCIÓN</th>
			       <td><textarea name="desc" cols="40" rows="4"><%=entrevista.getDescripcion() %></textarea></td>
			     </tr>
			     <tr>
			       <td></td>
			       <td><input type="submit" value="Cerrar Entrevista"></td>
			     </tr>
			    </table>
			  </form>
			  <br>
			  <br>
			  <form action="menu_admin.jsp" method="get">
			  	<input type="submit" value="Volver al Menú Principal">
			  </form>
			  <br>
			  <br>
			  <form action="CerrarSesion" method="get">
			  	<input type="submit" value="Cerrar Sesión">
			  </form>
			  </center>
			    
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
				error = (String)session.getAttribute("error");
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
		    	mes_entrevista = "0" + (String) session.getAttribute("mes_sys");
		    	año_entrevista = Integer.valueOf((String)session.getAttribute("año_sys"));
		  //Alta de entrevista  
			}	
		  %>
		<%if(entrevista != null){%>
		<center><h1>MODIFICACION DE ENTREVISTA</h1></center>
		<h2><%="Entrevista para " + entrevista.getNombre()%></h2>
		<%}else{%>
		<center><h1>ALTA DE ENTREVISTA</h1></center>
		<%}%>
		<form action="EntrevistaEdit" method="post">
		<%if(entrevista != null){%>
		<input type="hidden" name="action" value="modificar">
		<%}else{%>
		<input type="hidden" name="action" value="alta">
		<%}%>
		<table>
			<tr>
				<td>Fecha </td>
				<td><select name="dia_entrevista">   
					<%  
					for (int i = 1; i <= 31; i++){			  	
		 			%>
					 	<option <%=dia_entrevista==i ? "selected" : ""%>><%=i%></option>		 	
		   			<%
					}	
					%>
		 			 </select>
		  			 <select name="mes_entrevista">
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
					 <select name="año_entrevista">
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
				<select name="hora_entrevista">
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
				<td><select name="maestro_entrevista">		
				<%
				for (Maestro m : maestros.getLista()){		 		
		 		%>  			  
		   			<option value="<%=m.getCod_maest()%>"><%=m.getNombre()+ " " + m.getApellido()%> </option>   			  
		   		 <%   			
				}		
				%>
				</select>
			</tr>	
			<tr>
				<td>Nombre</td>
				<td><input type="text" name="nombre_entrevista" value="<%=entrevista!=null? entrevista.getNombre() : ""%>"></td>
			</tr>
		<%}%>
		</table>
		<br>
		<input type="submit" value="Guardar">
		<input type="reset" value="Cancelar">
		</form>
		<br>
		<%if (!error.equals("")) {%>
		<%=error%>
		<br>
		<br>
		<%}%>
		<form action="menu_admin.jsp" method="post">
		<input type="submit" value="Volver al Menú Principal">
		</form>
		<% 
		}
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>