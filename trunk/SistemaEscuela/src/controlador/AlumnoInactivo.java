package controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesEstado;
import datos.EstadoAlumnos;

/**
 * Servlet implementation class AlumnoInactivo
 */
public class AlumnoInactivo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AlumnoInactivo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		
		try {
			
			String accion = request.getParameter("do");
			
			if (accion.equals("listar")) {
				
				EstadoAlumnos alumnos_inactivos = AccionesEstado.getInactivos();
				sesion.setAttribute("alumnos_inactivos", alumnos_inactivos);
				
				response.sendRedirect("alumno_list_inactivos.jsp");
				
			} else if (accion.equals("activar")) {
				
				//recupero de la sesion la fecha del sistema
				String a�o_sys = (String)sesion.getAttribute("a�o_sys");
				String mes_sys = (String)sesion.getAttribute("mes_sys");
				String dia_sys = (String)sesion.getAttribute("dia_sys");
				String fecha_sys = a�o_sys + "-" + mes_sys + "-" + dia_sys;
				
				int dni_alum = Integer.parseInt(request.getParameter("dni_alum"));
				
				AccionesEstado.activarAlumno(dni_alum, fecha_sys);
				
				sesion.setAttribute("error", "El alumno se activo correctamente");
				
				response.sendRedirect("alumnoInactivo?do=listar");
				
			}
			
		} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
			sesion.setAttribute("error", "Se ha producido un error. No se puede dar de baja y activar a un alumno el mismo dia." + "<br><br>" + "Exception:" + "<br>" + e.toString());
			response.sendRedirect("alumnoInactivo?do=listar");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}