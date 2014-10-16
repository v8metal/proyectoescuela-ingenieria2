<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0"> 
<title>Sistema de alumnado</title>
<link href="style/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<body>
  <div class="container">
  <div class="page-header">
       <h1>Login</h1>
  </div>	
<%	String error = "";
	if (session.getAttribute("error") != null) {
		error = (String)session.getAttribute("error");
		session.setAttribute("error", "");		
	} 
 %>
<form action="login" method="post">
     <div class="form-group">
         <label for="inputEmail">Usuario</label>
         <input type="text" class="form-control" name=usuario placeholder="Usuario"> <%=error%>
     </div>
     <div class="form-group">
         <label for="inputPassword">Contraseņa</label>
         <input type="password" name="contraseņa" class="form-control" placeholder="Contraseņa">
     </div>     
     <button type="submit" class="btn btn-primary">Entrar</button>
</form>
</div> 
</body>
</html>
