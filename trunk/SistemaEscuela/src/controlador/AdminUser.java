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
			
			String contrase�a = request.getParameter("contrase�a_actual");
			String contrase�a_nueva = request.getParameter("contrase�a_nueva");
			String contrase�a_nueva_r = request.getParameter("contrase�a_nueva_r");
			
			if (!contrase�a.equals("") && !contrase�a_nueva.equals("")&& !contrase�a_nueva_r.equals("")) {
								
				
				String usuario = (String) sesion.getAttribute("login");				
				Integer cod_maest = AccionesUsuario.validarUsuario(usuario, contrase�a);
				
				if (contrase�a_nueva.equals(contrase�a_nueva_r)){
					
					if (cod_maest > 0){
					
						AccionesUsuario.updateUser(usuario,contrase�a_nueva);
						sesion.setAttribute("error", "Contrase�a actualizada correctamente");						
				
					}else{
						
						sesion.setAttribute("error", "Error al loguearse, contrase�a inv�lida");
						
					}
					
				}else {	
						if (cod_maest == -1){
							
							sesion.setAttribute("error", "Error al loguearse, contrase�a inv�lida");
							
						}else{
							
							sesion.setAttribute("error", "La confirmaci�n no coincide con la nueva contrase�a");
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