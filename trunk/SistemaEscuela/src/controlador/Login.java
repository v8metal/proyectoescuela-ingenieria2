package controlador;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesMaestro;
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
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		Calendar calendar = Calendar.getInstance();
		int año = calendar.get(Calendar.YEAR);
		int mes = calendar.get(Calendar.MONTH);
		try {
			
			sesion.setAttribute("año", año);
			sesion.setAttribute("añoc", año);
			sesion.setAttribute("mes", mes);
			//recupero la fecha del sistema
			Calendar c = Calendar.getInstance();
			String año_sys = Integer.toString(c.get(Calendar.YEAR));
			String mes_sys = Integer.toString(c.get(Calendar.MONTH)+1);
			String dia_sys = Integer.toString(c.get(Calendar.DAY_OF_MONTH));
			
			//la seteo en la sesion
			sesion.setAttribute("año_sys", año_sys);
			sesion.setAttribute("mes_sys", mes_sys);
			sesion.setAttribute("dia_sys", dia_sys);
			
			String usuario = request.getParameter("usuario");
			String contraseña = request.getParameter("contraseña");
			
			if (!usuario.equals("") && !contraseña.equals("")) {
				
				Integer tipo = AccionesUsuario.validarUsuario(usuario, contraseña);
				
				if (tipo == 0) { // quiere decir que el usuario es administrador
					
					sesion.setAttribute("admin", usuario);
					response.sendRedirect("menu_admin.jsp");
					
				} else if (tipo == 1){ // quiere decir que el usuario es maestro
					
					int dni = AccionesUsuario.getDniUsuario(usuario, contraseña);					
					Maestro m = AccionesMaestro.getOne(dni);
					
					if (m.getEstado() == 0){
						
						sesion.setAttribute("error", "El usuario está inhabilitado");
						response.sendRedirect("login.jsp"); 
					
					}else{					
	
						sesion.setAttribute("usuario", usuario);

						Maestro maestro = AccionesMaestro.getOne(dni);
						sesion.setAttribute("maestro", maestro);
						sesion.setAttribute("dni_maestro", dni);
						response.sendRedirect("menu_user.jsp");
					}
					
				} else {
					sesion.setAttribute("error", "Nombre de usuario y/o contraseña no válidos");
					response.sendRedirect("login.jsp");} 
				
			} else {
				sesion.setAttribute("error", "Debe completar el usuario y la contraseña para poder ingresar");
				response.sendRedirect("login.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
