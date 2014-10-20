<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Selección de año</title>
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<body>
<div class="container">
<%
	if (session.getAttribute("usuario") != null) {
	 	
	String action = "";
		
	if (request.getParameter("action") != null){			
		action = request.getParameter("action");			
	}		
%>
<div class="page-header">
<center><h1>Sanciones - Selección de año</h1></center>
</div>
<%
	int cod_maestro = (Integer) session.getAttribute("cod_maestro");	
	int año_actual = Calendar.getInstance().get(Calendar.YEAR);
	int año_inicio = año_actual - 30;
%>
<div class="form-group">
<form action="SancionList" method="post">	
<input type="hidden" name="acceso" value="primero">
<table class="table table-hover table-bordered">	
	<tr>
		<td><label for="input">Seleccionar año:</label></td>
		<td>
			<select class="form-control" name="año_sancion_selected">   
			<%  			
				for (int i = año_inicio; i <= año_actual; i++){					 
 			 %>
			 <option <%=año_actual==i ? "selected" : ""%>><%=i%></option>		 	
   			<%
				}			
			 %>
			</select>			
 		</td>
	</tr>
	</table>
<br>
<button type="submit" class="btn btn-primary"  value="Aceptar" name="btnAcept">Aceptar</button>
<button type="reset" class="btn btn-primary"  value="Cancelar" name="btnCancel">Cancelar</button>
</form>
</div>
<br>
<div class="form-group">
<form action="menu_user.jsp" method="post">
<button type="submit" class="btn btn-primary"  value="Volver al menú">Volver al menú</button>
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