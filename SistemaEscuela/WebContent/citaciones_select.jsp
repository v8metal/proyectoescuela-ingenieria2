<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Selección de año</title>
</head>
<body>
<%
	if (session.getAttribute("login") != null) {
	 	
	String action = "";
		
	if (request.getParameter("action") != null){			
		action = request.getParameter("action");			
	}		
%>
<center><h1>Citaciones - Selección de año</h1></center>
<%
	int cod_maestro = (Integer) session.getAttribute("cod_maestro");	
	int año_actual = Calendar.getInstance().get(Calendar.YEAR);
	int año_inicio = año_actual - 30;
%>
<form action="CitacionList" method="post">	
<input type="hidden" name="acceso" value="primero">
<table>	
	<tr>
		<td>Seleccione Año</td>
		<td>
			<select name="año_sancion_selected">   
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
<input type="submit" value="Aceptar">
<input type="reset" value="Cancelar">
</form>
<br>
<form action="menu_citaciones.jsp" method="post">
<input type="submit" value="Volver">
</form>
<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</body>
</html>