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
import conexion.AccionesUsuario;
import datos.Alumno;
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
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "AsistenciaEdit") != 1){							
			response.sendRedirect("Login");
		}

		//System.out.println("AsistenciaEdit doGet");
			
		String accion = (String) request.getParameter("do");
			
		//System.out.println("accion= " + accion);			
		
		int dni = Integer.parseInt(request.getParameter("dni"));
		
		switch(accion){
			
			case "Alta":
				
				if (AccionesUsuario.validarAcceso(tipo, "asistencia_edit.jsp") != 1){							
					response.sendRedirect("Login");
				}
				
				try {
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesAlumno") != 1){							
						response.sendRedirect("Login");
					}
					
					Alumno alumno = AccionesAlumno.getOne(dni);
					
					sesion.setAttribute("alumnoAltaAsistencia", alumno);										
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/asistencia_edit.jsp");
					dispatcher.forward(request, response);				
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				break;
				
			case "Modificar":
				
				if (AccionesUsuario.validarAcceso(tipo, "asistencia_edit.jsp") != 1){							
					response.sendRedirect("Login");
				}
				
				String fecha = (String) (request.getParameter("fecha"));										
			
				try {
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesTardanza") != 1){							
						response.sendRedirect("Login");
					}
					
					Tardanza t = AccionesTardanza.getOneAsistencia(dni, fecha);					
					request.setAttribute("asistencia", t);
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/asistencia_edit.jsp");
					dispatcher.forward(request, response);
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				break;
				
			case "borrar":			
				
				if (AccionesUsuario.validarAcceso(tipo, "AsistenciaList") != 1){							
					response.sendRedirect("Login");
				}
							
				fecha = (String) (request.getParameter("fecha"));			
									
				try {
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesTardanza") != 1){							
						response.sendRedirect("Login");
					}
					
					AccionesTardanza.bajaAsistencia(dni, fecha);
				
					request.setAttribute("accion","listarAsistencias");
				
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/AsistenciaList");
					dispatcher.forward(request, response);				
							
				
				} catch (Exception e) {				
					e.printStackTrace();
				}
			
				break;
					
				}// fin del case
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "AsistenciaEdit") != 1){							
			response.sendRedirect("Login");
		}

		//System.out.println("Asistencia doPost");
			
		String accion = (String) request.getParameter("do");
			
		//System.out.println("accion= " + accion);
											
		if (AccionesUsuario.validarAcceso(tipo, "AsistenciaList") != 1){							
			response.sendRedirect("Login");
		}
		
		String fecha = (String) sesion.getAttribute("fechaAsistencia");
		int dni = Integer.parseInt(request.getParameter("alumno_asistencia"));
		String obs = (String) request.getParameter("observaciones");
		String condicion = (String) request.getParameter("condicion");
		
		Tardanza a = new Tardanza(dni, fecha, obs, "A", condicion);
		
		switch(accion){
			
			case "Alta":				
				
				try {
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesTardanza") != 1){							
						response.sendRedirect("Login");
					}
					
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
				
			case "Modificar":
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesTardanza") != 1){							
					response.sendRedirect("Login");
				}
				
								
				try {
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesTardanza") != 1){							
						response.sendRedirect("Login");
					}
					
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
	}
	
}
