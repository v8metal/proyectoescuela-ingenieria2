package controlador;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import conexion.AccionesUsuario;

/**
 * Servlet implementation class for Servlet: AdminUser
 *
 */
 public class AdminUser extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public AdminUser() {
		super();
	}   	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}  	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		String accion = request.getParameter("do");
		
		//System.out.println("accion= " + accion);			
		
		String contrase�a = request.getParameter("contrase�a_actual");
		
		switch(accion){
		
		case "pass":
						
			String contrase�a_nueva = request.getParameter("contrase�a_nueva");
			String contrase�a_nueva_r = request.getParameter("contrase�a_nueva_r");
			
			if (!contrase�a.equals("") && !contrase�a_nueva.equals("")&& !contrase�a_nueva_r.equals("")) {
								
				String usuario = "";
				
				if (sesion.getAttribute("usuario") != null){
					
					usuario = (String) sesion.getAttribute("usuario"); 
					
				}
				
				if (sesion.getAttribute("admin") != null){					
					
					usuario = (String) sesion.getAttribute("admin");
				}
				
								
				Integer dni = AccionesUsuario.validarUsuario(usuario, contrase�a);
				
				
				//System.out.println("dni= " + dni);
				
				if (contrase�a_nueva.equals(contrase�a_nueva_r)){
					
					if (dni > 0){
						
						try {
					
						AccionesUsuario.updatePass(usuario,contrase�a_nueva);
						sesion.setAttribute("success", "Contrase�a actualizada correctamente");
						
						
						} catch (Exception e) {
							e.printStackTrace();
						}
				
				
					}else{
						
						sesion.setAttribute("error", "Error al loguearse, contrase�a inv�lida");
						
					}
				
					
				}else {	
						if (dni == 0){
							
							sesion.setAttribute("error", "Error al loguearse, contrase�a inv�lida");
							
						}else{
							
							sesion.setAttribute("error", "La confirmaci�n no coincide con la nueva contrase�a");
						}
						
				}				
				
				response.sendRedirect("admin_pass.jsp");
				
			} else {
				sesion.setAttribute("error", "Debe completar los campos para continuar");
				response.sendRedirect("admin_pass.jsp");
			}
			
			break;
			
		case "user":
			
			String usuario_nuevo = request.getParameter("usuario_nuevo");
			String usuario_nuevo_r = request.getParameter("usuario_nuevo_r");
			
			if (!contrase�a.equals("") && !usuario_nuevo.equals("")&& !usuario_nuevo_r.equals("")) {
					
				
				int ind = 0;
				
				String usuario = "";				
				
				if (sesion.getAttribute("usuario") != null){
					
					usuario = (String) sesion.getAttribute("usuario"); 
					
				}
				
				if (sesion.getAttribute("admin") != null){					
					
					ind = 1;
					
					usuario = (String) sesion.getAttribute("admin");
				}
				
				Integer dni = AccionesUsuario.validarUsuario(usuario, contrase�a);
				
				//System.out.println("dni= " + dni);
				
				if (usuario_nuevo.equals(usuario_nuevo_r)){					
					
					if (dni > 0){
						
						try {
					
						AccionesUsuario.updateUser(usuario, usuario_nuevo_r);
						sesion.setAttribute("success", "Usuario actualizado correctamente");
						
						if (ind == 0){
							sesion.setAttribute("usuario", usuario_nuevo_r);	
						}
						
						if (ind == 1){
							sesion.setAttribute("admin", usuario_nuevo_r);	
						}

						
						} catch (Exception e) {
							e.printStackTrace();
						}
				
					}else{
					
						sesion.setAttribute("error", "Error al loguearse, contrase�a inv�lida");
						
					}
					
				}else {	
						if (dni == 0){
							
							sesion.setAttribute("error", "Error al loguearse, contrase�a inv�lida");
							
						}else{
							
							sesion.setAttribute("error", "La confirmaci�n no coincide con el nuevo usuario");
						}
						
				}				
				
				response.sendRedirect("admin_user.jsp");
				
			} else {
				sesion.setAttribute("error", "Debe completar los campos para continuar");
				response.sendRedirect("admin_user.jsp");
			}	
	
		 	 
		}
	}
	
 }