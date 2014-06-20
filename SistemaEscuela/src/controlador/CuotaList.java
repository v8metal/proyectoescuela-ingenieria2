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
 * Servlet implementation class CuotaList
 */
public class CuotaList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CuotaList() {
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
				if(sesion.getAttribute("modificar")!=null){
					String grado = (String)sesion.getAttribute("grado");
					String turno = (String)sesion.getAttribute("turno");
					if(sesion.getAttribute("a�o")==null){
						try {
							alumnos = AccionesAlumno.getAllAlumnos_Grado(grado, turno);
							sesion.setAttribute("alumnos_grado", alumnos);
							sesion.setAttribute("modificar", null);
							response.sendRedirect("cuota_list.jsp");
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						
					}else{
						int a�o = (int)sesion.getAttribute("a�o");
						try {
							alumnos = AccionesAlumno.getAllAlumnos_GradoA�o(grado, turno,a�o);
							sesion.setAttribute("alumnos_grado", alumnos);
							sesion.setAttribute("modificar", null);
							response.sendRedirect("cuota_list.jsp");
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						
					}
					
				}else{
					String grado = request.getParameter("grado");
					String turno = request.getParameter("turno");
					int a�o = Integer.parseInt(request.getParameter("a�o"));
					sesion.setAttribute("grado", grado);
					sesion.setAttribute("turno", turno);
					sesion.setAttribute("a�o", a�o);
					try {
						alumnos = AccionesAlumno.getAllAlumnos_GradoA�o(grado,turno,a�o);
						sesion.setAttribute("alumnos_grado", alumnos);
						response.sendRedirect("cuota_list.jsp");
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
				response.sendRedirect("cuota_edit.jsp");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}else{
			response.sendRedirect("login.jsp");
		}
	}

}
