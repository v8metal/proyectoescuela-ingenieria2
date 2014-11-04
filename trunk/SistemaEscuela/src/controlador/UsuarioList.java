package controlador;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesMaestro;
import conexion.AccionesUsuario;
import datos.Maestros;
import datos.Usuarios;

/**
 * Servlet implementation class UsuarioList
 */
public class UsuarioList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UsuarioList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "UsuarioList") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
		
		if (AccionesUsuario.validarAcceso(tipo, "AccionesUsuario") != 1){							
			response.sendRedirect("Login");						
		}
		
		Usuarios usuario_list = AccionesUsuario.getAll();
		sesion.setAttribute("usuarios", usuario_list);
		
		Maestros maestros = AccionesMaestro.getAllActivos();
		
		sesion.setAttribute("activos", maestros);		
		
		if (AccionesUsuario.validarAcceso(tipo, "gest_user_menu.jsp") != 1){							
			response.sendRedirect("Login");						
		}
		
		response.sendRedirect("gest_user_menu.jsp");
	}

}
