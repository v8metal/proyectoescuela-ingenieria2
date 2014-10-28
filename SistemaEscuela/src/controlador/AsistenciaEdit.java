package controlador;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesAlumno;
import conexion.AccionesTardanza;
import datos.Alumnos;
import datos.Grado;
import datos.Tardanza;

/**
 * Servlet implementation class AsistenciaEdit
 */
public class AsistenciaEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AsistenciaEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession sesion = request.getSession();
		
		if(sesion.getAttribute("usuario") != null){

			System.out.println("AsistenciaEdit doGet");
			
			String accion = (String) request.getParameter("do");
			
			System.out.println("accion= " + accion);			
			
			switch(accion){
			
			case "alta":
				
				int año = (Integer) sesion.getAttribute("añoAsistencia");
				Grado grado = (Grado) sesion.getAttribute("gradoAltaAsistencia");
				
				try {
					
					Alumnos alumnos = AccionesAlumno.getAllByGradoTurnoYAño(grado.getGrado(), grado.getTurno(), año);
					
					sesion.setAttribute("alumnosAltaAsistencia", alumnos);										
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/asistencia_edit.jsp");
					dispatcher.forward(request, response);				
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				break;
				
			case "modificar":
				
				int dni = Integer.parseInt(request.getParameter("dni"));
				String fecha = (String) (request.getParameter("fecha"));										
			
				try {
								
					Tardanza t = AccionesTardanza.getOneAsistencia(dni, fecha);					
					request.setAttribute("asistencia", t);
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/asistencia_edit.jsp");
					dispatcher.forward(request, response);
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				break;
				
			case "borrar":			
			
			
				dni = Integer.parseInt(request.getParameter("dni"));
				fecha = (String) (request.getParameter("fecha"));			
									
				try {
					
					AccionesTardanza.bajaAsistencia(dni, fecha);
				
					request.setAttribute("accion","listarAsistencias");
				
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/AsistenciaList");
					dispatcher.forward(request, response);				
							
				
				} catch (Exception e) {				
					e.printStackTrace();
				}
			
				break;
					
				}// fin del case
			
		}else{
			response.sendRedirect("login.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		if(sesion.getAttribute("usuario") != null){

			System.out.println("Asistencia doPost");
			
			String accion = (String) request.getParameter("do");
			
			System.out.println("accion= " + accion);
			
			int año = (Integer) sesion.getAttribute("añoAsistencia");
								
			String obs = (String) request.getParameter("observaciones");
			String condicion = (String) request.getParameter("condicion");
								
			Tardanza a = null;
			
			switch(accion){
			
			case "alta":
				
				int dia = Integer.parseInt(request.getParameter("dia_asistencia"));
				String mes = (String) request.getParameter("mes_asistencia");				
				int dni = Integer.parseInt(request.getParameter("alumno_asistencia"));
				
				String relleno = "";
				
				if (dia < 10) relleno = "0";
								
				a = new Tardanza(dni, año + "-" + mes + "-" + relleno + dia, obs, "A", condicion);
				
				try {
					
					AccionesTardanza.altaTardanza(a);												
					
					request.setAttribute("accion","listarAsistencias");
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/AsistenciaList");
					dispatcher.forward(request, response);				
				
				} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
					sesion.setAttribute("error", "<br>"+ "Ya existe una tardanza para el alumno, en el mismo dia"+"<br>");
					response.sendRedirect("tardanza_edit.jsp");		
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				
				break;
				
			case "modificar":
			
				String fecha = (String) sesion.getAttribute("fechaAsistencia");
				dni = Integer.parseInt(request.getParameter("alumno_asistencia"));
				
				a = new Tardanza(dni, fecha, obs, "A", condicion);
				
				try {
					
					AccionesTardanza.modificarAsistencia(a);												
					
					request.setAttribute("accion","listarAsistencias");
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/AsistenciaList");
					dispatcher.forward(request, response);				
				
				} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
					sesion.setAttribute("error", "<br>"+ "Ya existe una tardanza para el alumno, en el mismo dia"+"<br>");
					response.sendRedirect("tardanza_edit.jsp");		
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				break;			
			
			}// fin del case
			
		}else{
			response.sendRedirect("login.jsp");
		}
	}
	
}
