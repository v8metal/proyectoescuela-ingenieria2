<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Sistema Alumnado</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</head>
<body>  
<%if (session.getAttribute("admin") != null) { %>
<center>
  <h1>Precios de Cuotas/Inscripciones</h1>
    <form action="PrecioList" method="post">
      <table>
        <tr>
          <th>Seleccionar a�o:</th>
          <td>
            <select name="a�o"><%
            	int a�o = (Integer)session.getAttribute("a�o");
                                        for(int i=a�o;i>a�o-20;i--){
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
  <strong><a href="menu_admin.jsp">Volver al Men� Principal</a></strong>
  <br>
  <br>
  <strong><a href="CerrarSesion">Cerrar Sesi�n</a></strong>
  </center>
</body>
   <%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</html>