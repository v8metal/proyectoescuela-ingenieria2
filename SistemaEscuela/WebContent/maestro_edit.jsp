<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Maestros</title>
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<body>
<div class="container">
<%
	if (session.getAttribute("admin") != null) {
		
		Maestro maestro = (Maestro)request.getAttribute("maestro");
		
		String error = "";
		
		if (session.getAttribute("error") != null) {
			error = (String)session.getAttribute("error");
			session.setAttribute("error", "");
		} 
  	//get the maestro object from the request
  	
  		String accion = "alta";
  	
  		if (maestro != null){
  			accion = "modificar";
%>
<div class="page-header">  
	<h1>Edición de Maestro</h1>
</div> 
	   <%}else{%>
<div class="page-header">  
	<h1>Alta de Maestro</h1>
  </div> 
  	 
 		<%}%>  
  <% 
			if (!error.equals("")) { %>
<%=error%>
<br>
<br>
<%
			}
%> 
	<div class="form-group">
	
	<form action="maestroEdit" method="post">
	
	<input type="hidden" name="accion" value="<%=accion%>">
	
		<table class="table table-hover table-bordered">
		
			<tbody>
				<tr>
				    <td><label for="input">Apellido:</label></td>
         			<td><input type="text" class="form-control" name="apellido" placeholder="Apellido" value="<%=maestro!=null? maestro.getApellido() : ""%>"></td>
         		</tr>
         		
         		<tr>
				    <td><label for="input">Nombre:</label></td>
         			<td><input type="text" class="form-control" name="nombre" placeholder="Nombre" value="<%=maestro!=null ? maestro.getNombre() : ""%>"></td>
         		</tr>					
							
				<tr>
					<% if(maestro != null){%>
					<td><label for="input">D.N.I.:</label></td>					
					<td><input readonly type="text" class="form-control" name="dni" placeholder="Dni" value="<%=maestro.getDni()%>"></td>
					<%}else{%>					
					<td><label for="input">D.N.I.:</label></td>
         			<td><input type="text" class="form-control" name="dni" placeholder="Dni" value=""></td>
					<%}%>
				</tr>

				<tr>
				    <td><label for="input">Domicilio:</label></td>
         			<td><input type="text" class="form-control" name="domicilio" placeholder="Domicilio"  value="<%=maestro!=null ? maestro.getDomicilio() : ""%>"></td>
         		</tr>				
					
				<tr>
				    <td><label for="input">Teléfono:</label></td>
         			<td><input type="text" class="form-control"  name="telefono" placeholder="Teléfono" value="<%=maestro!=null ? maestro.getTelefono() : ""%>"></td>
         		</tr>				
			</tbody>
		</table>
		<center>
		<%
		String mensaje= "return confirm('Esta seguro que desea realizar el alta?');"; 
		  
		if (maestro != null){
			
			mensaje = "return confirm('Esta seguro que desea modificar?');"; 
		}
		 
		%>
		<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave" onclick="<%=mensaje%>">Guardar</button>
		<button type="reset" class="btn btn-primary"  value="Cancelar" name="btnCancel">Cancelar</button>
		</center>		
	</form> 
	</div>
 <br>
 <br>
<div class="form-group">
<form action="maestroList" method="post">
<button type="submit" class="btn btn-primary"  value="Volver al Listado">Volver al Listado</button>
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