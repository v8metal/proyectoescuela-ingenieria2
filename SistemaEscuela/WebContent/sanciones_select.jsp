<%@page import="datos.Maestro"%>
<%@page import="datos.Maestros"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "sanciones");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Selecci�n de a�o</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="style/bootstrap.min.css">

</head>
<body>

<%
		//modulo de seguridad
		int tipo = (Integer) session.getAttribute("tipoUsuario");						
		if (AccionesUsuario.validarAcceso(tipo, "sanciones_select.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}		

		//Recupero el maestro para mostrar su nombre y apellido en el men� superior	
		Maestro maestro = (Maestro)session.getAttribute("maestro");
		String nombre = maestro.getNombre();
		String apellido = maestro.getApellido();
		
%>

<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el men� superior -->
  </div>
  
  <%		
	String action = "";
		
	if (request.getParameter("action") != null){			
		action = request.getParameter("action");			
	}		
%>

<div class="page-header">
<h1>Sanciones - Selecci�n de a�o</h1>
</div>
<%
	int cod_maestro = (Integer) session.getAttribute("cod_maestro");	
	int a�o_actual = Calendar.getInstance().get(Calendar.YEAR);
	int a�o_inicio = a�o_actual - 30;
%>

<label class="control-label" for="input">Seleccionar a�o:</label>

<br>
<br>

     <form action="SancionList" method="post">
        <div class="row">
            <div class="col-xs-3">
                <div class="input-group">
                     <span class="input-group-btn">
                        <button type="submit" class="btn btn-primary"  value="Aceptar" name="btnAcept"><i class="glyphicon glyphicon-search"></i> Buscar</button>
                    </span>
                    <select class="form-control" name="a�o_sancion_selected" autofocus>
  						 <%  			
							int a�o = (Integer)session.getAttribute("a�oc");
  							for(int i=a�o; i>a�o-20;i--){					 
 						 %>	
 						  <option value="<%=i %>"><%=i %></option>		 	
   						<%
							}			
						 %>   			 		
 					 </select>					
                </div>
            </div>
        </div>
        <input type="hidden" name="acceso" value="primero">
    </form>

</div>
	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

	<!-- men� superior -->
	<script src="js/menu_user.js"></script> 
</body>
</html>