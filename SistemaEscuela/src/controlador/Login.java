package controlador;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesMaestro;
import conexion.AccionesMensaje;
import conexion.AccionesUsuario;
import datos.*;

/**
 * Servlet implementation class servletLogin
 */
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//doPost(request, response);
		HttpSession sesion = request.getSession();		
		sesion.setAttribute("mensaje",AccionesMensaje.getOne(10));
		response.sendRedirect("login.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		Calendar calendar = Calendar.getInstance();
		int a�o = calendar.get(Calendar.YEAR);
		int mes = calendar.get(Calendar.MONTH);
		try {
			
			sesion.setAttribute("a�o", a�o);
			sesion.setAttribute("a�oc", a�o);
			sesion.setAttribute("mes", mes);
			//recupero la fecha del sistema
			Calendar c = Calendar.getInstance();
			String a�o_sys = Integer.toString(c.get(Calendar.YEAR));
			String mes_sys = Integer.toString(c.get(Calendar.MONTH)+1);
			String dia_sys = Integer.toString(c.get(Calendar.DAY_OF_MONTH));
			
			//la seteo en la sesion
			sesion.setAttribute("a�o_sys", a�o_sys);
			sesion.setAttribute("mes_sys", mes_sys);
			sesion.setAttribute("dia_sys", dia_sys);
			
			String usuario = request.getParameter("usuario");
			String contrase�a = request.getParameter("contrase�a");
			
			String objeto = "";
			
			if (!usuario.equals("") && !contrase�a.equals("")) {
				
				Integer tipo = AccionesUsuario.validarUsuario(usuario, contrase�a);
				
			 if (tipo != null){
					
				
				sesion.setAttribute("tipoUsuario", tipo);
				sesion.setAttribute("user", usuario);
				
				if (tipo == 0) { // quiere decir que el usuario es administrador
					
					objeto = "menu_admin.jsp";							
					if (AccionesUsuario.validarAcceso(tipo, objeto) != 1){						
						response.sendRedirect("Login"); //redirecciona al login, sin acceso												
					}
					
					response.sendRedirect(objeto);
					
				} else if (tipo == 1){ // quiere decir que el usuario es maestro
					
					int dni = AccionesUsuario.getDniUsuario(usuario, contrase�a);					
					Maestro m = AccionesMaestro.getOne(dni);
					
					if (m.getEstado() == 0){
						
						sesion.setAttribute("mensaje",AccionesMensaje.getOne(11));
						response.sendRedirect("login.jsp"); 
					
					}else{					
						
													
						Maestro maestro = AccionesMaestro.getOne(dni);
						sesion.setAttribute("maestro", maestro);
						sesion.setAttribute("dni_maestro", dni);
						
						objeto = "menu_user.jsp";						
						if (AccionesUsuario.validarAcceso(tipo, objeto ) != 1){													
							response.sendRedirect("Login"); //redirecciona al login, sin acceso						
						}
						
						response.sendRedirect(objeto);
					
					}
					
				}
								
				} else {
					sesion.setAttribute("mensaje",AccionesMensaje.getOne(12));
					response.sendRedirect("login.jsp");
				
				}
			 
			 // else obsoleto, con el atributo "required" en el imput text no se puede enviar un form sin el campo completado	
			} else {
				sesion.setAttribute("mensaje",AccionesMensaje.getOne(13));
				response.sendRedirect("login.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
