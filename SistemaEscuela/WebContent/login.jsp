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
<link rel="icon" href="icono/favicon.ico">

<!-- Bootstrap core CSS -->
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">

<!-- Custom styles for this template -->
<link href="style/signin.css" rel="stylesheet">

<!-- Custom styles for this template -->
 <link href="style/sticky-footer.css" rel="stylesheet">
 
<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<title>Sistema de alumnado</title>
</head>
<body>

 <div class="container">

<form class="form-signin" role="form" action="login" method="post">
   	<h2 class="form-signin-heading">Por favor regístrese</h2>
         
         <input type="text" class="form-control" name=usuario placeholder="Usuario" required autofocus>    <!-- required que nos permite comprobar que el campo ha sido rellenado antes incluso de pulsar ese botón de envío -->
         <input type="password" name="contraseña" class="form-control" placeholder="Contraseña" required>	<!-- autofocus es un atributo booleano para los campos de un formulario que hace que el foco del explorador esté fijado sobre uno de ellos cuando se carga la web -->

     <button type="submit" class="btn btn-primary">Ingresar</button>
</form>

<br>

 <%	String error = "";
	
	if (session.getAttribute("error") != null) {
		error = (String)session.getAttribute("error");
		session.setAttribute("error", "");		
	
 %>
 	 <div class="alert alert-danger" role="alert">
        <strong>Ups!</strong> <%= error %>
      </div>
 	
 <% } %>

</div>

</body>
</html>
