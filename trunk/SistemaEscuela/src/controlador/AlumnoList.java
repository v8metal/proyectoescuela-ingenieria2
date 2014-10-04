package controlador;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesAlumno;
import datos.Alumnos;

/**
 * Servlet implementation class AlumnoList
 */
public class AlumnoList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AlumnoList() {
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
		
		String from = request.getParameter("from"); 	// nombre de la pagina que llamo al servlet(este param solo se manda desde "nota_menu")	
		if (from == null) {	
			from = 	"otro_lado";
		}
		
		String grado = request.getParameter("grado");
		if (grado == null) { //llega de alumno_edit (alta/modificar)			
			grado = (String)sesion.getAttribute("grado");
		} else { //llega de menu_listado_alum
			sesion.setAttribute("grado", grado);
		}
		
		String turno = request.getParameter("turno");
		if (turno == null) { //llega de alumno_edit (alta/modificar)		
			turno = (String)sesion.getAttribute("turno");
		} else { //llega de menu_listado_alum
			sesion.setAttribute("turno", turno);
		}
		
		String año = request.getParameter("año");
		if (año == null) { //llega de alumno_edit (alta/modificar)	
			año = (String)sesion.getAttribute("año");
		} else { //llega de menu_listado_alum
			sesion.setAttribute("año", año);
		}
		
			if (grado.equals("todos")) {
				Alumnos alumno_list = AccionesAlumno.getAllByTurnoYAño(turno, Integer.parseInt(año));
				sesion.setAttribute("alumnos", alumno_list);
				sesion.setAttribute("titulo", "TURNO " + turno + " - " + año);
			} else {
				Alumnos alumno_list = AccionesAlumno.getAllByGradoTurnoYAño(grado, turno, Integer.parseInt(año));
				
				sesion.setAttribute("alumnos", alumno_list);
				
				if (turno.equals("MAÑANA")) {
					turno = "TM";
				} else {
					turno = "TT";
				}
				sesion.setAttribute("titulo",  grado + " " + turno + " - " + año);
			}			
		
		if (from.equals("nota_menu")) {		
			response.sendRedirect("nota_lista_alum.jsp");
		} else if (from.equals("otro_lado")){
			response.sendRedirect("alumno_list.jsp");
		}
	
	}

}
