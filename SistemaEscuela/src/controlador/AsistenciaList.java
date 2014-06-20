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
 * Servlet implementation class AsistenciaList
 */
public class AsistenciaList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AsistenciaList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		if(sesion.getAttribute("login")!=null){
			Alumnos_Grados alumnos=null;
			if(sesion.getAttribute("grado")!=null || request.getParameter("grado")!=null){
				if(sesion.getAttribute("editar")!=null || sesion.getAttribute("alta")!=null || sesion.getAttribute("borrar")!=null){
					sesion.setAttribute("alta", null);
					sesion.setAttribute("editar", null);
					if(sesion.getAttribute("año")==null){
						sesion.setAttribute("activador", "activador");
						String grado=(String)sesion.getAttribute("grado");
						String turno =(String)sesion.getAttribute("turno");
						try {
							alumnos = AccionesAlumno.getAllAlumnos_Grado(grado, turno);
							sesion.setAttribute("alumnos_grado", alumnos);
							response.sendRedirect("asistencia_list.jsp");
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						
					}else{
						sesion.setAttribute("activador", "activador");
						String grado = (String)sesion.getAttribute("grado");
						String turno =(String)sesion.getAttribute("turno");
						int año = (int)sesion.getAttribute("año");
						try {
							alumnos = AccionesAlumno.getAllAlumnos_GradoAño(grado,turno,año);
							sesion.setAttribute("alumnos_grado", alumnos);
							response.sendRedirect("asistencia_list.jsp");
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						
					}
				}else{
					int cod_maest = (int)sesion.getAttribute("cod_maest");
					Maestros_Grados maestros_grados;
					try {
						maestros_grados = AccionesMaestro.getAll_Maestros_Grados(cod_maest);
						sesion.setAttribute("maestros_grados", maestros_grados);
						response.sendRedirect("asistencia_list.jsp");
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
				}
				
			}else{
				int cod_maest = (int)sesion.getAttribute("cod_maest");
				Maestros_Grados maestros_grados;
				try {
					maestros_grados = AccionesMaestro.getAll_Maestros_Grados(cod_maest);
					sesion.setAttribute("maestros_grados", maestros_grados);
					response.sendRedirect("asistencia_list.jsp");
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
			Alumnos_Grados alumnos=null;
			sesion.setAttribute("activador", "activador");
			String grado = request.getParameter("grado");
			String turno = request.getParameter("turno");
			int año = Integer.parseInt(request.getParameter("año"));
			sesion.setAttribute("grado", grado);
			sesion.setAttribute("turno", turno);
			sesion.setAttribute("año", año);
			try {
				alumnos = AccionesAlumno.getAllAlumnos_GradoAño(grado,turno,año);
				sesion.setAttribute("alumnos_grado", alumnos);
				response.sendRedirect("asistencia_list.jsp");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}else{
			response.sendRedirect("login.jsp");
		}
	}

}
