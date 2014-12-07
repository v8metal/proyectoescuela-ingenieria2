package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesAlumno;
import conexion.AccionesEstado;
import conexion.AccionesGrado;
import conexion.AccionesPadre;
import conexion.AccionesUsuario;
import datos.Alumno;
import datos.EstadoAlumnos;
import datos.Grados;
import datos.Padre;

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
		

		int tipo = (Integer) sesion.getAttribute("tipoUsuario");						
		if (AccionesUsuario.validarAcceso(tipo, "AlumnoInactivo") != 1){							
			response.sendRedirect("Login");						
		}	

		
		try {
			
			String accion = request.getParameter("do");
			
			if (accion.equals("listar")) {
				
				EstadoAlumnos alumnos_inactivos = AccionesEstado.getInactivos();
				sesion.setAttribute("alumnos_inactivos", alumnos_inactivos);
				
				response.sendRedirect("alumno_list_inactivos.jsp");
				
			} else if (accion.equals("activar")) {
				
				int dni_alum = Integer.parseInt(request.getParameter("dni_alum"));
				Alumno alumno = AccionesAlumno.getOne(dni_alum);
				Padre tutor = AccionesPadre.getOne(alumno.getDni_tutor());								
				Padre madre = AccionesPadre.getOne(alumno.getDni_madre());

				//AccionesEstado.activarAlumno(dni_alum, fecha_sys);							
				request.setAttribute("alumno", alumno);
				request.setAttribute("tutor", tutor);				
				request.setAttribute("madre", madre);
				sesion.setAttribute("reingreso", "reingreso");
				
				Grados grados = AccionesGrado.getAll();				
				sesion.setAttribute("grados_alta", grados);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/alumno_edit.jsp");				
				dispatcher.forward(request, response);
				
				//sesion.setAttribute("error", "El alumno se activó correctamente");				
				//response.sendRedirect("alumnoInactivo?do=listar");
				
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
