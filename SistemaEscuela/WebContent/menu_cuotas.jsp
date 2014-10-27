<%@page import="datos.Cuota"%>
<%@page import="datos.Cuotas"%>
<%@page import="datos.Grado"%>
<%@page import="datos.Grados"%>
<%@page import="conexion.AccionesCuota"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>			
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Men� de Cuotas</title>

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
            <li><a href="menu_admin.jsp">Men�</a></li>
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
                  <li><a href="GradoList?listar=ma�ana">Turno ma�ana</a></li>                 
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
                  <li><a href="admin_pass.jsp">Cambiar contrase�a</a></li>          
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
<% 
if (session.getAttribute("admin") != null) {
	
	Integer a�oCuota = null;
	Grados grados = null;
			
	if (request.getAttribute("a�oCuota") != null){
		
		//System.out.println((Integer) request.getAttribute("a�oCuota"));
		a�oCuota = (Integer) request.getAttribute("a�oCuota");
		session.setAttribute("a�oPlan", a�oCuota);		
				
		grados = (Grados) request.getAttribute("gradosCuota");
		session.setAttribute("gradosPlan", grados);
	
	}
	
	if(session.getAttribute("a�oMenuCuota")!= null){		
		
		a�oCuota = (Integer) session.getAttribute("a�oMenuCuota");
		grados = (Grados) session.getAttribute("gradosMenuCuota");
		
		session.removeAttribute("a�oMenuCuota");
		session.removeAttribute("gradosMenuCuota");
	}
	 
	/*
	if (request.getAttribute("gradosCuota") != null){
		System.out.println((Grados) request.getAttribute("gradosCuota"));
		grados = (Grados) request.getAttribute("gradosCuota");
		session.setAttribute("gradosPlan", grados);
	}
	
	*/
	
	/*
	a�oCuota = (Integer) session.getAttribute("a�oCuota");
	session.setAttribute("a�oPlan", a�oCuota);	
				
	grados = (Grados) session.getAttribute("gradosCuota");
	*/
	
	
%>
	<div class="page-header">  	  
		<h1>Men� Cobro de Cuotas</h1>		
    </div>
    
    <div class="form-group">
	<form action="CuotaList" method="get">
	
	<table class="table table-hover table-bordered">
	
	<%if(a�oCuota == null){ %>
	  <tr>
	    <td><label for="input">Seleccionar a�o:</label></td>	    
	    <td>
	    	<select class="form-control" name="a�o_cuotas">
	      		<%
	      		    int a�o = (Integer)session.getAttribute("a�oc");
	      			for(int i=a�o; i>a�o-20;i--){
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
	    <td><label for="input">Seleccionar a�o:</label></td>	    
	     <td>
	     	<input class="form-control" type="text" size=4 readonly name="anio" value="<%=a�oCuota%>">
	     </td> 
	  </tr>
	  <%if (grados.getLista().isEmpty()) { %>
	  <tr>	  	
	  	<td><label for="input">Seleccionar grado-turno:</label></td>
	  	<td><label for="input">No hay grados para el a�o seleccionado</label></td>	  	
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
	     <tr>
	      <td>
	     	<input type="hidden" name="accion" value="listarGrado">
	      </td>      
	    </tr>	        
	  </table>
	  
			<button type="submit" class="btn btn-primary"  value="Guardar" name="btnSave">Aceptar</button>
			<button type="reset" class="btn btn-primary"  value="Cancelar" name="btnSave">Cancelar</button>
		
	</form>
	</div>	
	<br>
	<br>
	<%if(a�oCuota == null){ %>

<!-- 		
	<div class="form-group">
	<form action="menu_admin.jsp">
	<button type="submit" class="btn btn-primary"  value="Volver al Men� Principal">Volver al Men� Principal</button>
	</form>
	</div>
 -->
 
	<%}else{ %>	
	
	<a href="pagos_dia.jsp">Ver Total de Pagos por d�a</a>
	<br>
	<br>
	<br>
	<br>
		
	<table>
		<tr>
		<td><div class="form-group"> <form action="menu_cuotas.jsp"> <input class="btn btn-primary" type="submit" value="Seleccionar otro a�o"> </form></div></td>
<!-- 		<td><div class="form-group"> <form action="menu_admin.jsp"> <input class="btn btn-primary" type="submit" value="Volver al Men� Principal"> </form></div></td>		 -->
		</tr>
	</table>
	
	<%}%>
	<br>
	<br>

<!-- 		
	<div class="form-group">
	<form action="CerrarSesion">
	<button type="submit" class="btn btn-primary"  value="Cerrar Sesi�n">Cerrar Sesi�n</button>
	</form>
	</div>
 -->	
	
	<%
	} else {
		response.sendRedirect("login.jsp");
	}
%>
</div>
</body>
</html>