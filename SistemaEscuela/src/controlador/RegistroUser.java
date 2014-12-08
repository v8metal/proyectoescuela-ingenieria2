package controlador;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesMensaje;
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
		HttpSession sesion = request.getSession();
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");						
		if (AccionesUsuario.validarAcceso(tipo, "RegistroUser") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
		
		try {
			
			String accion = request.getParameter("do");
			int dni = Integer.parseInt(request.getParameter("dni"));
			
			if (AccionesUsuario.validarAcceso(tipo, "AccionesUsuario") != 1){							
				response.sendRedirect("Login");						
			}
			
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
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");						
		if (AccionesUsuario.validarAcceso(tipo, "RegistroUser") != 1){							
			response.sendRedirect("Login");						
		}
		
		try {
			
			if (AccionesUsuario.validarAcceso(tipo, "AccionesUsuario") != 1){							
				response.sendRedirect("Login");						
			}
			
			if (AccionesUsuario.validarAcceso(tipo, "registro_user.jsp") != 1){							
				response.sendRedirect("Login");						
			}
			
			int dni = Integer.parseInt(request.getParameter("maestro"));
			String usuario = request.getParameter("usuario");
			String contraseña = request.getParameter("contraseña");
			String contraseña_conf = request.getParameter("contraseña_conf");
			
			if (contraseña.equals(contraseña_conf)) {
				
				if(AccionesUsuario.checkUsuario(usuario)){
					
					sesion.setAttribute("mensaje", AccionesMensaje.getOne(51));
					response.sendRedirect("registro_user.jsp");
					
				}else{
					
					if (AccionesUsuario.validarAcceso(tipo, "UsuarioList") != 1){							
						response.sendRedirect("Login");						
					}
					
					AccionesUsuario.registrar(dni, usuario, contraseña_conf);
					response.sendRedirect("UsuarioList");
				}				
						
			} else {
				
				sesion.setAttribute("mensaje", AccionesMensaje.getOne(5));
				response.sendRedirect("registro_user.jsp");
				
			}		
					
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
