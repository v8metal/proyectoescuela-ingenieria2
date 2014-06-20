package controlador;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesAlumno;
import datos.Alumno_Grado;
import conexion.AccionesCuota;
import datos.Cuota;

/**
 * Servlet implementation class CuotaEdit
 */
public class CuotaEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CuotaEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		if(sesion.getAttribute("login")!=null){
			int dni = Integer.parseInt(request.getParameter("dni"));
			int año = Integer.parseInt(request.getParameter("año"));
			String periodo = request.getParameter("periodo");
			Cuota c;
			try {
				c = AccionesCuota.getOneCuota(dni, año, periodo);
				sesion.setAttribute("cuota", c);
				sesion.setAttribute("modificar", "modificar");
				sesion.setAttribute("activador", "activador");
				response.sendRedirect("cuota_edit.jsp");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
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
			String modificar=(String)sesion.getAttribute("modificar");
			int dni = Integer.parseInt(request.getParameter("dni"));
			int año = Integer.parseInt(request.getParameter("año"));
			String periodo = request.getParameter("periodo");
			int reinsc=0;
			if(request.getParameter("reinsc")!=null){
				reinsc=1;
			}
			int reinsc_ant=0;
			if(request.getParameter("reinsc_ant")!=null){
				reinsc_ant=1;
			}
			if(modificar==null){
				Cuota cuota = new Cuota(dni,año,periodo,reinsc,reinsc_ant);
				try {	
					AccionesCuota.altaCuota(cuota);
					Alumno_Grado alumno=AccionesAlumno.getOneAlumno_Grado(dni);
					sesion.setAttribute("grado", alumno.getGrado());
					sesion.setAttribute("turno", alumno.getTurno());
					sesion.setAttribute("modificar", "modificar");
					response.sendRedirect("CuotaList");
				} catch (SQLException e) {
					System.out.println(e);
					String error = request.getParameter("error");
					sesion.setAttribute("error", error);
					response.sendRedirect("cuota_edit.jsp");
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}else{
				Cuota c = new Cuota(dni,año,periodo,reinsc,reinsc_ant);
				Cuota x = (Cuota)sesion.getAttribute("cuota");

				try {
					AccionesCuota.modificar(c, x.getDni(),x.getAño(),x.getPeriodo());
					response.sendRedirect("CuotaList");
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				
			}
	
			
		}else{
			response.sendRedirect("login.jsp");
		}
	}

}
