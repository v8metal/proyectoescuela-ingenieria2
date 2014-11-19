<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<title>Sistema de alumnado</title>

<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
	
<!-- Custom styles for this template -->
<link href="style/signin-style.css" rel="stylesheet" media="screen">
	
</head>
<body>
<div class="container">

<div class="header">
        <ul class="nav nav-pills pull-right">
          <li class="active"><a href="#">Inicio</a></li>
          <li><a href="acercade.html">Acerca de</a></li>
          <li><a href="contacto.html">Contacto</a></li>
        </ul>
        <h3 class="text-muted">Sistema Escuela "Príncipe de Paz"</h3>  
</div>
<br>
    <div class="row">
        <div class="col-sm-6 col-md-4 col-md-offset-4">
            <h1 class="text-center login-title">Registrarse para continuar</h1>	
            <div class="account-wall">
                <img class="profile-img" src="imagenes/photo.png?sz=120"
                    alt="">
                <form class="form-signin" role="form" action="login" method="post">
                <input type="text" class="form-control" name=usuario placeholder="Usuario" required autofocus>	<!-- required que nos permite comprobar que el campo ha sido rellenado antes incluso de pulsar ese botón de envío -->
                <input type="password" class="form-control" name="contraseña" placeholder="Contraseña" required>		<!-- autofocus es un atributo booleano para los campos de un formulario que hace que el foco del explorador esté fijado sobre uno de ellos cuando se carga la web -->
                <button class="btn btn-lg btn-primary btn-block" type="submit"><i class="glyphicon glyphicon-log-in"></i> Ingresar</button>
                <label class="checkbox pull-left">
                    <input type="checkbox" value="remember-me">Recordarme</label>
                	<a href="#" class="pull-right need-help" data-toggle="modal" data-target=".bs-example-modal-sm">¿Necesita ayuda? </a><span class="clearfix"></span>
                
  						<!--  Modal content for the above example -->
  						<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
    						<div class="modal-dialog modal-sm">
      							<div class="modal-content">

        						<div class="modal-header">
          							<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
          							<h4 class="modal-title" id="mySmallModalLabel">Información</h4>
        						</div>
        						<div class="modal-body">
          						Para obtener un usuario y contraseña comuniquese con el administrador
        						</div>
      							</div><!-- /.modal-content -->
    						</div><!-- /.modal-dialog -->
  						</div><!-- /.modal -->
                					
                </form>
            </div>
  <!--            <a href="#" class="text-center new-account">Create an account </a>  -->
        </div>
    </div>
<br>
<br>    
 <!-- MENSAJE DE ERROR -->
 <%	String error = "";
	
	if (session.getAttribute("error") != null) {
		error = (String)session.getAttribute("error");
		session.setAttribute("error", null);		
	
 %>
   <div class="bs-example">
    	 <div class="alert alert-danger fade in" role="alert">
     	 	<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     	 	<strong>Ups!</strong> <%= error %>
  	  	</div>
  </div><!-- /example -->
 	
 <% } %>   
    
</div>
	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>