package controlador;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import conexion.AccionesUsuario;
import conexion.AccionesMensaje;

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
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "AdminUser") != 1){							
			response.sendRedirect("Login");
		}
		
		String accion = request.getParameter("do");
		
		//System.out.println("accion= " + accion);			
		
		String contraseña = request.getParameter("contraseña_actual");
		
		switch(accion){
		
		case "pass":
			
			if (AccionesUsuario.validarAcceso(tipo, "admin_pass.jsp") != 1){							
				response.sendRedirect("Login");
			}
			
			String contraseña_nueva = request.getParameter("contraseña_nueva");
			String contraseña_nueva_r = request.getParameter("contraseña_nueva_r");
			
			if (!contraseña.equals("") && !contraseña_nueva.equals("")&& !contraseña_nueva_r.equals("")) {
								
				String usuario = "";
				
				if (sesion.getAttribute("user") != null){
					
					usuario = (String) sesion.getAttribute("user"); 
					
				}
								
				if (AccionesUsuario.validarAcceso(tipo, "AccionesUsuario") != 1){							
					response.sendRedirect("Login");
				}
								
				Integer dni = AccionesUsuario.getDniUsuario(usuario, contraseña);
				
				
				//System.out.println("dni= " + dni);
				
				if (contraseña_nueva.equals(contraseña_nueva_r)){
					
					if (dni > 0){
						
						try {
					
						AccionesUsuario.updatePass(usuario,contraseña_nueva);
						sesion.setAttribute("mensaje",AccionesMensaje.getOne(8));
						
						
						} catch (Exception e) {
							e.printStackTrace();
						}
				
				
					}else{
						
						sesion.setAttribute("mensaje",AccionesMensaje.getOne(4));
						
					}
				
					
				}else {	
						if (dni == 0){
							
							sesion.setAttribute("mensaje",AccionesMensaje.getOne(4));
							
						}else{
														
							sesion.setAttribute("mensaje",AccionesMensaje.getOne(5));
						}
						
				}				
				
				response.sendRedirect("admin_pass.jsp");
				
			} else {
				
				sesion.setAttribute("mensaje",AccionesMensaje.getOne(6));
				response.sendRedirect("admin_pass.jsp");
			}
			
			break;
			
		case "user":
			
			if (AccionesUsuario.validarAcceso(tipo, "admin_user.jsp") != 1){							
				response.sendRedirect("Login");
			}
			
			String usuario_nuevo = request.getParameter("usuario_nuevo");
			String usuario_nuevo_r = request.getParameter("usuario_nuevo_r");
			
			if (!contraseña.equals("") && !usuario_nuevo.equals("")&& !usuario_nuevo_r.equals("")) {
				
				String usuario = "";				
				
				if (sesion.getAttribute("user") != null){					
					
					usuario = (String) sesion.getAttribute("user");
				}
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesUsuario") != 1){							
					response.sendRedirect("Login");
				}
				
				Integer dni = AccionesUsuario.getDniUsuario(usuario, contraseña);
				
				//System.out.println("dni= " + dni);
				
				if (usuario_nuevo.equals(usuario_nuevo_r)){					
					
					if (dni > 0){
						
						try {
					
						AccionesUsuario.updateUser(usuario, usuario_nuevo_r);
						
						sesion.setAttribute("mensaje",AccionesMensaje.getOne(9));						
						sesion.setAttribute("user", usuario_nuevo_r);						

						
						} catch (Exception e) {
							e.printStackTrace();
						}
				
					}else{
					
						sesion.setAttribute("mensaje",AccionesMensaje.getOne(4));
						
					}
					
				}else {	
						if (dni == 0){
							
							sesion.setAttribute("mensaje",AccionesMensaje.getOne(4));
							
						}else{
							
							sesion.setAttribute("mensaje",AccionesMensaje.getOne(7));
						}
						
				}				
				
				response.sendRedirect("admin_user.jsp");
				
			} else {

				sesion.setAttribute("mensaje",AccionesMensaje.getOne(6));
				response.sendRedirect("admin_user.jsp");
			}	
	
		 	 
		}
	}
	
 }