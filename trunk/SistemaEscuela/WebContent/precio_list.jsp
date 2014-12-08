<%@page import="datos.PrecioMes"%>
<%@page import="datos.PreciosMes"%>
<%@page import="datos.PrecioInscrip"%>
<%@page import="datos.PreciosInscrip"%>
<%@page import="datos.Mensaje"%>
<%@page import="conexion.AccionesUsuario"%>
<%@page import="conexion.AccionesMensaje"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%session.setAttribute("modulo", "cuotas");%>
<meta name="viewport" content="width=device-width; initial-scale=1.0">
<%
	int tipo = (Integer) session.getAttribute("tipoUsuario");						
	if (AccionesUsuario.validarAcceso(tipo, "precio_list.jsp") != 1){							
		response.sendRedirect("Login"); //redirecciona al login, sin acceso						
	}
	
	PreciosMes preciosMes = (PreciosMes) session.getAttribute("preciosMes");
 	PreciosInscrip preciosInscrip = (PreciosInscrip) session.getAttribute("preciosInscrip"); 
 	int a�o = (Integer) session.getAttribute("a�oPrecios");
 %>
<title>Listado de Precios - A�o <%=a�o%></title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

</head>
<body>
<div class="container">

  <div id="divmenu">
  	<!-- sirve para visualizar el men� superior -->
  </div>
  
  <div class="page-header">  	  
	<h1>Precios de Cuotas - <%=a�o%></h1>		
  </div>    
  
<% if (preciosMes == null || (preciosMes.getPrecios().size() == 0)){
	
		Mensaje m = AccionesMensaje.getOne(46);
%>

		<!-- MENSAJE INFORMATIVO -->
    	 <div class="alert <%=m.getTipo()%> fade in" role="alert">
     	 	<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 	<%=m.getMensaje()%> <a href="PrecioEdit?accion=altaMes" class="alert-link">Dar de alta</a>
  	  	 </div>
<%}else{%>
  <table class="table table-hover">
  		  <thead>
          <tr class="active">
            <th>A�O</th>
            <th>MES</th>
            <th>PRECIO REGULAR</th>
            <th>PRECIO DE GRUPO</th>
            <th>PRECIO DE HIJOS</th>
            <th>RECARGO</th>
            <th>&nbsp;</th>
            <th>&nbsp;</th>     
          </tr>
          </thead>
          <%
          	for(PrecioMes precioM: preciosMes.getPrecios()){
          %>
          <tbody>
            	<tr>
            	  <td><%=precioM.getA�o() %></td>
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
            	  <td><strong><a href="PrecioEdit?accion=modificarMes&&a�o=<%=precioM.getA�o()%>&&mes=<%=precioM.getMes()%>"><i class="glyphicon glyphicon-pencil"></i> Editar</a></strong></td>
            	  <td><strong><a href="PrecioEdit?accion=bajaMes&&a�o=<%=precioM.getA�o() %>&&mes=<%=precioM.getMes() %>" onclick="return confirm('Esta seguro que desea borrar?');"><i class="glyphicon glyphicon-trash"></i> Borrar</a></strong></td>
            	</tr>
            </tbody>	
            	<% 
            }
            %>         
        </table>
	<br>	
   <%if (preciosMes.getPrecios().size() < 10){%>
	<br>
 	<strong><a href="PrecioEdit?accion=altaMes">Alta de Cuota</a></strong>
 	<%}%> 	
 
<%}%> 
	<div class="page-header">  	  
		<h1>Precios de Inscripciones - <%=a�o%></h1>		
    </div>   	
<% if (preciosInscrip == null || (preciosInscrip.getPrecios().size() == 0)){ 
	
		Mensaje m = AccionesMensaje.getOne(46);
%>

		<!-- MENSAJE INFORMATIVO -->
    	 <div class="alert <%=m.getTipo()%> fade in" role="alert">
     	 	<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 	<%=m.getMensaje()%> <a href="PrecioEdit?accion=altaInscrip" class="alert-link">Dar de alta</a>
  	  	 </div>
<%}else{%>  
  <table class="table table-hover">
  		  <thead>	
          <tr class="active">
            <th>A�O</th>
            <th>FECHA MAXIMA</th>
            <th>PRECIO</th>
            <th>RECARGO</th>
            <th>&nbsp;</th>
            <th>&nbsp;</th>            
          </tr>
          </thead>
          <%
          	for(PrecioInscrip precioI: preciosInscrip.getPrecios()){
          %>
          	<tbody>
            	<tr>
            	  <td><%=precioI.getA�o() %></td>            	
            	  <td><%= precioI.getFecha_max().substring(8, 10)  + "/" + precioI.getFecha_max().substring(5, 7) + "/" + precioI.getFecha_max().substring(0, 4)%></td>
            	  <td><%=precioI.getPrecio() %></td>
            	  <td><%=precioI.getRecargo() %></td>            	  
            	  <td><strong><a href="PrecioEdit?accion=modificarInscrip&&a�o=<%=precioI.getA�o()%>"><i class="glyphicon glyphicon-pencil"></i> Editar</a></strong></td>
            	  <td><strong><a href="PrecioEdit?accion=bajaInscrip&&a�o=<%=precioI.getA�o() %>" onclick=<%=AccionesMensaje.getOne(22).getMensaje()%>><i class="glyphicon glyphicon-trash"></i> Borrar</a></strong></td>
            	</tr>
            </tbody>	
           <%}%>            	         
        </table>   
  <%}%>  
  <br>
  <br>  
  <div class="form-group">
	<form action="CuotaList" method="get">
	<input name="accion" type="hidden" value="listarGrado">
	<button type="submit" class="btn btn-primary"  value="Volver atr�s"><i class="glyphicon glyphicon-share-alt"></i> Volver atr�s</button>
	</form>
  </div>
</div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

	<!-- men� superior -->
	<script src="js/menu_admin.js"></script> 
</body>
</html>