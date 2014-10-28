<%@page import="datos.PrecioMes"%>
<%@page import="datos.PreciosMes"%>
<%@page import="datos.PrecioInscrip"%>
<%@page import="datos.PreciosInscrip"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0">
<%
if (session.getAttribute("admin") != null) {
	
	PreciosMes preciosMes = (PreciosMes) session.getAttribute("preciosMes");
 	PreciosInscrip preciosInscrip = (PreciosInscrip) session.getAttribute("preciosInscrip"); 
 	int año = (Integer) session.getAttribute("añoPrecios");
 %>
<title>Listado de Precios - Año <%=año%></title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

</head>
<body>
<div class="container">

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
            <li><a href="menu_admin.jsp">Menú</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Alumnos <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="menu_listado_alum.jsp">Listado</a></li>
                  <li><a href="alumno_edit.jsp">Nuevo alumno</a></li>          
                  <li class="divider"></li>
                  <li class="dropdown-header">Nav header</li>
                  <li><a href="alumnoInactivo?do=listar">Registro de bajas</a></li>
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Grados <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="GradoList?listar=mañana">Turno mañana</a></li>                 
                  <li><a href="GradoList?listar=tarde">Turno tarde</a></li>          
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Maestros <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="maestroList">Listado</a></li>
                  <li><a href="maestroEdit?accion=alta">Nuevo maestro</a></li>          
                  <li class="divider"></li>
                  <li><a href="MaestroList?tipo=inactivos">Registro de bajas</a></li>
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Materias <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="materiaList?from=menu_admin">Listado</a></li>
                  <li><a href="materiaEdit?do=alta">Nueva materia</a></li>          
                  <li class="divider"></li>
                  <li><a href="materiaList?from=materia_inactiva_list">Materias inactivas</a></li>
                </ul>
              </li>
              <li><a href="menu_tardanzas.jsp">Tardanzas</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Entrevistas <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="EntrevistaList">Listado</a></li>
                  <li><a href="EntrevistaEdit?do=alta">Nueva entrevista</a></li>          
                </ul>
              </li>
              <li class="active"><a href="menu_cuotas.jsp">Cuotas</a></li>
              <li><a href="UsuarioList">Usuarios</a></li>
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
        		</div>
			</li>
          </ul>
        </div>
      </div>
    </div>
  
  <br>
  <br>
	<div class="page-header">  	  
		<h1>Precios de Cuotas - <%=año%></h1>		
    </div>    
<% if (preciosMes == null || (preciosMes.getPrecios().size() == 0)){ %>
<a href="PrecioEdit?accion=altaMes">No hay precios asignados, dar de alta</a>
<%}else{%>
  <table class="table table-hover">
          <tr>
            <td>AÑO</td>
            <td>MES</td>
            <td>PRECIO REGULAR</td>
            <td>PRECIO DE GRUPO</td>
            <td>PRECIO DE HIJOS</td>
            <td>RECARGO</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>     
          </tr>
          <%
          	for(PrecioMes precioM: preciosMes.getPrecios()){
          %>
            	<tr>
            	  <td><%=precioM.getAño() %></td>
            	  <td><%
            	      String [] meses = new String[12];
            	      meses[0]="Enero";
            	      meses[1]="Febrero";
            	      meses[2]="Marzo";
            	      meses[3]="Abril";
            	      meses[4]="Mayo";
            	      meses[5]="Junio";
            	      meses[6]="Julio";
            	      meses[7]="Agosto";
            	      meses[8]="Septiembre";
            	      meses[9]="Octubre";
            	      meses[10]="Noviembre";
            	      meses[11]="Diciembre";
            	      for(int i=1;i<13;i++){
            	    	  if(precioM.getMes()==i){
            	    		  %>
            	    		  <%=meses[i-1]%>
            	    		  <%
            	    	  }
            	      }
            	      %>
            	  </td>
            	  <td><%=precioM.getRegular() %></td>
            	  <td><%=precioM.getGrupo()%></td>
            	  <td><%=precioM.getHijos() %></td>
            	  <td><%=precioM.getRecargo() %></td>
            	  <td><a href="PrecioEdit?accion=modificarMes&&año=<%=precioM.getAño()%>&&mes=<%=precioM.getMes()%>">Modificar</a></td>
            	  <td><a href="PrecioEdit?accion=bajaMes&&año=<%=precioM.getAño() %>&&mes=<%=precioM.getMes() %>" onclick="return confirm('Esta seguro que desea borrar?');">Borrar</a>
            	</tr>
            	<% 
            }
            %>         
        </table>
	<br>	
   <%if (preciosMes.getPrecios().size() < 10){%>
	<br>
 	<a href="PrecioEdit?accion=altaMes">Alta de Cuota</a>
 	<%}%> 	
 
<%}%> 
	<div class="page-header">  	  
		<h1>Precios de Inscripciones - <%=año%></h1>		
    </div>   	
<% if (preciosInscrip == null || (preciosInscrip.getPrecios().size() == 0)){ %>
	<a href="PrecioEdit?accion=altaInscrip">No hay precios asignados, dar de alta</a>
<%}else{%>  
  <table class="table table-hover">
          <tr>
            <td>AÑO</td>
            <td>FECHA MAXIMA</td>
            <td>PRECIO</td>
            <td>RECARGO</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>            
          </tr>
          <%
          	for(PrecioInscrip precioI: preciosInscrip.getPrecios()){
          %>
            	<tr>
            	  <td><%=precioI.getAño() %></td>            	
            	  <td><%=precioI.getFecha_max() %></td>
            	  <td><%=precioI.getPrecio() %></td>
            	  <td><%=precioI.getRecargo() %></td>            	  
            	  <td><a href="PrecioEdit?accion=modificarInscrip&&año=<%=precioI.getAño()%>">Modificar</a></td>
            	  <td><a href="PrecioEdit?accion=bajaInscrip&&año=<%=precioI.getAño() %>" onclick="return confirm('Esta seguro que desea borrar?');">Borrar</a>
            	</tr>
           <%}%>            	         
        </table>   
  <%}%>  
  <br>
  <br>  
  <div class="form-group">
	<form action="CuotaList" method="get">
	<input name="accion" type="hidden" value="listarGrado">
	<button type="submit" class="btn btn-primary"  value="Volver atrás">Volver atrás</button>
	</form>
  </div>
  <br>
  <br>  
  <div class="form-group">
	<form action="CerrarSesion" method="get">
	<button type="submit" class="btn btn-primary"  value="Cerrar Sesión">Cerrar Sesión</button>
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