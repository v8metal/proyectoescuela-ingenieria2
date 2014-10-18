<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/style.css" />
<title>Sistema Alumnado</title>
</head>
<body>  
<%if (session.getAttribute("admin") != null) { %>
<center>
  <h1>Precios de Cuotas/Inscripciones</h1>
    <form action="PrecioList" method="post">
      <table>
        <tr>
          <th>Seleccionar año:</th>
          <td>
            <select name="año"><%
            	int año = (Integer)session.getAttribute("año");
                                        for(int i=año;i>año-20;i--){
            %>
              <option value="<%=i%>"><%=i%></option>
                <%
                	}
                %>
            </select>
          </td>
        </tr>   
      </table>
   <br>
  <br>
	<input type="submit" value="Aceptar">
	<input type="reset" value="Cancelar">
    </form>     
  <br>
  <br>
  <strong><a href="menu_admin.jsp">Volver al Menú Principal</a></strong>
  <br>
  <br>
  <strong><a href="CerrarSesion">Cerrar Sesión</a></strong>
  </center>
</body>
   <%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</html>