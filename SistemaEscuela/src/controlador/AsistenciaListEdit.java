package controlador;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesAlumno;
import conexion.AccionesMaestro;
import datos.Alumnos_Grados;
import datos.Maestros_Grados;

/**
 * Servlet implementation class AsistenciaListEdit
 */
public class AsistenciaListEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AsistenciaListEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		int cod_maest = (int)sesion.getAttribute("cod_maest");
		Maestros_Grados maestros_grados;
		try {
			maestros_grados = AccionesMaestro.getAll_Maestros_Grados(cod_maest);
			sesion.setAttribute("maestros_grados", maestros_grados);
			response.sendRedirect("asistencia_edit.jsp");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		if(sesion.getAttribute("login")!=null){
			sesion.setAttribute("activador", "activador");
			String grado = request.getParameter("grado");
			String turno = request.getParameter("turno");
			sesion.setAttribute("grado", grado);
			sesion.setAttribute("turno", turno);
			Alumnos_Grados alumnos=null;
			try {
				alumnos = AccionesAlumno.getAllAlumnos_Grado(grado,turno);
				sesion.setAttribute("alumnos_grado", alumnos);
				response.sendRedirect("asistencia_edit.jsp");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}else{
			response.sendRedirect("login.jsp");
		}
	}

}
