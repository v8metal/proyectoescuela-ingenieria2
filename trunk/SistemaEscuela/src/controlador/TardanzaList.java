package controlador;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesAlumno;
import datos.Alumnos_Grados;

/**
 * Servlet implementation class TardanzaList
 */
public class TardanzaList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TardanzaList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		if(sesion.getAttribute("login")!=null){
				sesion.setAttribute("activador", "activador");
				Alumnos_Grados alumnos=null;
				if(sesion.getAttribute("alta")!=null){
					String grado = (String)sesion.getAttribute("grado");
					String turno = (String)sesion.getAttribute("turno");
					try {
						alumnos = AccionesAlumno.getAllAlumnos_Grado(grado, turno);
						sesion.setAttribute("alumnos_grado", alumnos);
						sesion.setAttribute("alta", null);
						response.sendRedirect("tardanza_list.jsp");
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
				}else if(sesion.getAttribute("borrar")!=null || sesion.getAttribute("modificar")!=null){
					String grado = (String)sesion.getAttribute("grado");
					String turno = (String)sesion.getAttribute("turno");
					if(sesion.getAttribute("año")==null){
						try {
							alumnos = AccionesAlumno.getAllAlumnos_Grado(grado, turno);
							sesion.setAttribute("alumnos_grado", alumnos);
							sesion.setAttribute("borrar", null);
							sesion.setAttribute("modificar", null);
							response.sendRedirect("tardanza_list.jsp");
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						
					}else{
						int año = (int)sesion.getAttribute("año");
						try {
							alumnos = AccionesAlumno.getAllAlumnos_GradoAño(grado, turno,año);
							sesion.setAttribute("alumnos_grado", alumnos);
							sesion.setAttribute("borrar", null);
							sesion.setAttribute("modificar", null);
							response.sendRedirect("tardanza_list.jsp");
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						
					}
					
				}else{
					String grado = request.getParameter("grado");
					String turno = request.getParameter("turno");
					int año = Integer.parseInt(request.getParameter("año"));
					sesion.setAttribute("grado", grado);
					sesion.setAttribute("turno", turno);
					sesion.setAttribute("año", año);
					try {
						alumnos = AccionesAlumno.getAllAlumnos_GradoAño(grado,turno,año);
						sesion.setAttribute("alumnos_grado", alumnos);
						response.sendRedirect("tardanza_list.jsp");
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
				}
		}else{
			response.sendRedirect("login.jsp");
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
				response.sendRedirect("tardanza_edit.jsp");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}else{
			response.sendRedirect("login.jsp");
		}
	}

}
