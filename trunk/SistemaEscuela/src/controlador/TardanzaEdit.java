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
 * Servlet implementation class TardanzaEdit
 */
public class TardanzaEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TardanzaEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession sesion = request.getSession();
		
		if(sesion.getAttribute("admin") != null){

			//System.out.println("Tardanza doGet");
			
			String accion = (String) request.getParameter("do");
			
			//System.out.println("accion= " + accion);			
			
			switch(accion){
			
			case "alta":
				
				int año = (Integer) sesion.getAttribute("añoTardanza");
				Grado grado = (Grado) sesion.getAttribute("gradoAltaTardanza");
				
				try {
					
					Alumnos alumnos = AccionesAlumno.getAllByGradoTurnoYAño(grado.getGrado(), grado.getTurno(), año);
					
					sesion.setAttribute("alumnosAltaTardanza", alumnos);										
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/tardanza_edit.jsp");
					dispatcher.forward(request, response);				
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				break;
				
			case "modificar":
				
				int dni = Integer.parseInt(request.getParameter("dni"));
				String fecha = (String) (request.getParameter("fecha"));										
			
				try {
								
					Tardanza t = AccionesTardanza.getOneTardanza(dni, fecha);					
					request.setAttribute("tardanza", t);
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/tardanza_edit.jsp");
					dispatcher.forward(request, response);
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				break;
				
			case "borrar":			
			
			
				dni = Integer.parseInt(request.getParameter("dni"));
				fecha = (String) (request.getParameter("fecha"));			
									
				try {
					
					AccionesTardanza.bajaTardanza(dni, fecha);
				
					request.setAttribute("accion","listarTardanzas");
				
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/TardanzaList");
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
		
		if(sesion.getAttribute("admin") != null){

			//System.out.println("Tardanza doGet");
			
			String accion = (String) request.getParameter("do");
			
			//System.out.println("accion= " + accion);
			
			int dia = Integer.parseInt(request.getParameter("dia_tardanza"));
			String mes = (String) request.getParameter("mes_tardanza");
			int año = (Integer) sesion.getAttribute("añoTardanza");
			int dni = Integer.parseInt(request.getParameter("alumno_tardanza"));				
			String obs = (String) request.getParameter("observaciones");
								
			String relleno = "";
			
			if (dia < 10) relleno = "0";
			
			Tardanza t = new Tardanza(dni, año + "-" + mes + "-" + relleno + dia, obs, "T", "");				
											
			switch(accion){
			
			case "alta":				
				
				
				try {
					
					AccionesTardanza.altaTardanza(t);												
					
					request.setAttribute("accion","listarTardanzas");
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/TardanzaList");
					dispatcher.forward(request, response);				
				
				} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
					sesion.setAttribute("error", "<br>"+ "Ya existe una tardanza para el alumno, en el mismo dia"+"<br>");
					response.sendRedirect("tardanza_edit.jsp");		
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				
				break;
				
			case "modificar":
			
				String fecha = (String) request.getParameter("fecha_tardanza");
				
				try {
					
					AccionesTardanza.modificarTardanza(t, fecha);												
					
					request.setAttribute("accion","listarTardanzas");
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/TardanzaList");
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
