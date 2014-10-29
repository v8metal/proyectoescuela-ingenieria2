<%@page import="datos.Maestro"%>
<%@page import="datos.Tardanza"%>
<%@page import="datos.Tardanza"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="conexion.AccionesTardanza"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>			
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Menú de Asistencias</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</head>
<body>
<div class="container">
<% 
if (session.getAttribute("usuario") != null) {
	
	Maestro maestro = (Maestro)session.getAttribute("maestro");
	String nombre = maestro.getNombre();
	String apellido = maestro.getApellido();
	
	Integer añoAsistencia = null;
	Grados grados = null;
			
	if (request.getAttribute("añoAsistencia") != null){
		
		añoAsistencia = (Integer) request.getAttribute("añoAsistencia");				
		grados = (Grados) request.getAttribute("gradosAsistencia");
		
		session.setAttribute("añoAsistencia", añoAsistencia);
		session.setAttribute("gradosAsistencia", grados);		
	}
	
	if (request.getParameter("volver") != null){
		
		añoAsistencia = (Integer) session.getAttribute("añoAsistencia");				
		grados = (Grados) session.getAttribute("gradosAsistencia");
		
		
	}
	
	int dia_asistencia = Integer.valueOf((String)session.getAttribute("dia_sys"));
	int mes= Integer.parseInt((String) session.getAttribute("mes_sys"));
	String mes_asistencia = "";
	
	if (mes < 10){
		mes_asistencia = "0" + mes;	
	}else{
		mes_asistencia = "" + mes;
	}
	
%>

<!-- Fixed navbar -->
    <div class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Sistema</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
              <li><a href="menu_user.jsp">Menú</a></li>
              <li class="active"> <a href="menu_asistencias.jsp">Asistencias</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Citaciones <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="citaciones_select.jsp?action=listar">Listado</a></li>                 
                  <li><a href="CitacionEdit?do=alta">Nueva citación</a></li>          
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Sanciones <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="sanciones_select.jsp?action=listar">Listado</a></li>
                  <li><a href="SancionEdit?do=alta">Nueva sanción</a></li>          
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Entrevistas <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="EntrevistaList">Listado</a></li>
                </ul>
              </li>
              <li><a href="nota_menu.jsp">Notas</a></li>
               <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Cuenta <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="admin_user.jsp">Cambiar usuario</a></li>
                  <li><a href="admin_pass.jsp">Cambiar contraseña</a></li>          
                </ul>
              </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
            <li>
            	<div class="navbar-collapse collapse">
        		  <form action="cerrarSesion" method="post" class="navbar-form navbar-right" role="form">
           		 	<button type="submit" class="btn btn-primary">Salir</button>
        		  </form>
        		  <p class="navbar-text navbar-right"><strong><%= nombre + " " + apellido %></strong></p>
        		</div>
			</li>
          </ul>
        </div>
      </div>
    </div>
  
  
  <br>
  <br>

	<div class="page-header">  	  
		<h1>Menú de Asistencias</h1>		
    </div>
    
    <div class="form-group">
	<form action="AsistenciaList" method="get">
	<%if(añoAsistencia == null){ %>
    	<input type="hidden" name="accion" value="solicitarGrados">
	<%}else{%>      
		<input type="hidden" name="accion" value="listarAsistencias">
	<%}%>

	<table class="table table-hover table-bordered">
	
	<%if(añoAsistencia == null){ %>
	  <tr>
	    <td><label for="input">Seleccionar año:</label></td>	    
	    <td><select class="form-control" name="año_asistencia">
	      		<%
	      		    int año = (Integer)session.getAttribute("añoc");
	      			for(int i=año; i>año-20;i--){
	      		%>	
	      	  <option value="<%=i %>"><%=i %></option>
	      		<%
	      			}
	      		%>
	        </select>
	     </td>         	     
	     <td>
	     	<input type="hidden" name="accion" value="solicitarGrados">
	     </td> 	     
	  </tr>
	<%}else{ %>
	  <tr>
	    <td><label for="input">Año Seleccionado:</label></td>	    
	     <td>
	     	<input class="form-control" type="text" size=4 readonly name="anio" value="<%=añoAsistencia%>">
	     </td> 
	  </tr>
	  <tr>
	  <td><label for="input">Fecha: </label></td>	  
	  <td><select name="dia_asistencia" class="form-control" >   
			<%  
				for (int i = 1; i <= 31; i++){			  	
		 		%>
			<option <%=dia_asistencia==i ? "selected" : ""%>><%=i%></option>		 	
		   	<%
			}	
			%>
		 	</select>
		  		 <select id="mes" name="mes_asistencia" class="form-control">		  		 
				 <option value="03" <%=mes_asistencia.equals("03") ? "selected" : ""%>>Marzo</option>
				 <option value="04" <%=mes_asistencia.equals("04") ? "selected" : ""%>>Abril</option>
				 <option value="05" <%=mes_asistencia.equals("05") ? "selected" : ""%>>Mayo</option>
				 <option value="06" <%=mes_asistencia.equals("06") ? "selected" : ""%>>Junio</option>
				 <option value="07" <%=mes_asistencia.equals("07") ? "selected" : ""%>>Julio</option>
				 <option value="08" <%=mes_asistencia.equals("08") ? "selected" : ""%>>Agosto</option>
				 <option value="09" <%=mes_asistencia.equals("09") ? "selected" : ""%>>Septiembre</option>
				 <option value="10" <%=mes_asistencia.equals("10") ? "selected" : ""%>>Octubre</option>
				 <option value="11" <%=mes_asistencia.equals("11") ? "selected" : ""%>>Noviembre</option>
				 <option value="12" <%=mes_asistencia.equals("12") ? "selected" : ""%>>Diciembre</option>	   			 		
		 		 </select>
		</td>
		</tr> 	
	  <%if (grados.getLista().isEmpty()) { %>
	  <tr>	  	
	  	<td><label for="input">Seleccionar grado-turno:</label></td>
	  	<td><label for="input">No hay grados para el año seleccionado</label></td>	  	
	  </tr>	  
	  <%}else{%>
	  <tr>
	      <td><label for="input">Seleccionar grado-turno:</label></td>
	      <td>
	      	<select class="form-control" name="grado_anio">
	      	<%for (Grado g : grados.getLista()) { %>	            
	            <option value="<%=g.getGrado() + " - " + g.getTurno()%>"><%=g.getGrado() + " - " + g.getTurno()%></option>            
	          
	      	<%}%>
	      	</select>
	      </td>
	    </tr>
	   <%}%>
	<%}%>   
	        
	  </table>  	
		<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave">Aceptar</button>
		<button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave">Cancelar</button>		
 </form>
 <br>
 	<%if(añoAsistencia != null){ %>		
		<div class="form-group">
		<form action="menu_asistencias.jsp">
		<input class="btn btn-primary" type="submit" value="Seleccionar otro año"> </form>
		</div>
	<%}%>
	<br>
	<br>	
	<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</div>
</body>
</html>