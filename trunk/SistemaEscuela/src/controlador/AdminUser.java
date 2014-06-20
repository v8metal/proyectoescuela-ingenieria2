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
		
		try {
			
			String contraseña = request.getParameter("contraseña_actual");
			String contraseña_nueva = request.getParameter("contraseña_nueva");
			String contraseña_nueva_r = request.getParameter("contraseña_nueva_r");
			
			if (!contraseña.equals("") && !contraseña_nueva.equals("")&& !contraseña_nueva_r.equals("")) {
								
				
				String usuario = (String) sesion.getAttribute("login");				
				Integer cod_maest = AccionesUsuario.validarUsuario(usuario, contraseña);
				
				if (contraseña_nueva.equals(contraseña_nueva_r)){
					
					if (cod_maest > 0){
					
						AccionesUsuario.updateUser(usuario,contraseña_nueva);
						sesion.setAttribute("error", "Contraseña actualizada correctamente");						
				
					}else{
						
						sesion.setAttribute("error", "Error al loguearse, contraseña inválida");
						
					}
					
				}else {	
						if (cod_maest == -1){
							
							sesion.setAttribute("error", "Error al loguearse, contraseña inválida");
							
						}else{
							
							sesion.setAttribute("error", "La confirmación no coincide con la nueva contraseña");
						}
						
				}				
				
				response.sendRedirect("admin_user.jsp");
				
			} else {
				sesion.setAttribute("error", "Debe completar los campos para continuar");
				response.sendRedirect("admin_user.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		 	 
	}
	
 }