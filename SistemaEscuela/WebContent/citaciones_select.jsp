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
<title>Selecci�n de a�o</title>
</head>
<body>
<%
	if (session.getAttribute("login") != null) {
	 	
	String action = "";
		
	if (request.getParameter("action") != null){			
		action = request.getParameter("action");			
	}		
%>
<center><h1>Citaciones - Selecci�n de a�o</h1></center>
<%
	int cod_maestro = (Integer) session.getAttribute("cod_maestro");	
	int a�o_actual = Calendar.getInstance().get(Calendar.YEAR);
	int a�o_inicio = a�o_actual - 30;
%>
<form action="CitacionList" method="post">	
<input type="hidden" name="acceso" value="primero">
<table>	
	<tr>
		<td>Seleccione A�o</td>
		<td>
			<select name="a�o_sancion_selected">   
			<%  			
				for (int i = a�o_inicio; i <= a�o_actual; i++){					 
 			 %>
			 <option <%=a�o_actual==i ? "selected" : ""%>><%=i%></option>		 	
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