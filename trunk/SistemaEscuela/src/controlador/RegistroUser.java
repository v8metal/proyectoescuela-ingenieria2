package controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesUsuario;

/**
 * Servlet implementation class RegistroUser
 */
public class RegistroUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistroUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//HttpSession sesion = request.getSession();
		
		try {
			
			String accion = request.getParameter("do");
			int dni = Integer.parseInt(request.getParameter("dni"));
			
			if (accion.equals("baja")) {
				AccionesUsuario.deleteOne(dni);
				response.sendRedirect("UsuarioList");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		
		try {
			
			int dni = Integer.parseInt(request.getParameter("maestro"));
			String usuario = request.getParameter("usuario");
			String contraseña = request.getParameter("contraseña");
			String contraseña_conf = request.getParameter("contraseña_conf");
			
			if (!usuario.equals("") && !contraseña.equals("") && !contraseña_conf.equals("")) {
				
					
					if (contraseña.equals(contraseña_conf)) {
						
					AccionesUsuario.registrar(dni, usuario, contraseña_conf);	
						
				} else {
					sesion.setAttribute("error", "Error al confirmar contraseña");
					response.sendRedirect("registro_user.jsp");
				}
				
			} else {
				sesion.setAttribute("error", "Debe completar todos los campos para registrarse");
				response.sendRedirect("registro_user.jsp");
			}
			
			response.sendRedirect("UsuarioList");
					
		} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
			
			sesion.setAttribute("error", "El usuario ingresado ya ha sido utilizado");
			response.sendRedirect("registro_user.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
