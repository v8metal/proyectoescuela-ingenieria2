package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesAlumno;
import conexion.AccionesMensaje;
import conexion.AccionesTardanza;
import conexion.AccionesUsuario;
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
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");		
		if (AccionesUsuario.validarAcceso(tipo, "TardanzaEdit") != 1){							
			response.sendRedirect("Login");						
		}
		
		String accion = (String) request.getParameter("do");			
		
		switch(accion){
			
			case "alta":
				
				if (AccionesUsuario.validarAcceso(tipo, "tardanza_edit.jsp") != 1){							
					response.sendRedirect("Login");						
				}
				
				int año = (Integer) sesion.getAttribute("añoTardanza");
				Grado grado = (Grado) sesion.getAttribute("gradoAltaTardanza");
				
				try {
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesAlumno") != 1){							
						response.sendRedirect("Login");						
					}
					
					Alumnos alumnos = AccionesAlumno.getAllByGradoTurnoYAño(grado.getGrado(), grado.getTurno(), año);
					
					sesion.setAttribute("alumnosAltaTardanza", alumnos);										
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/tardanza_edit.jsp");
					dispatcher.forward(request, response);				
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				break;
				
			case "modificar":
				
				if (AccionesUsuario.validarAcceso(tipo, "tardanza_edit.jsp") != 1){							
					response.sendRedirect("Login");						
				}
				
				int dni = Integer.parseInt(request.getParameter("dni"));
				String fecha = (String) (request.getParameter("fecha"));										
			
				try {
								
					if (AccionesUsuario.validarAcceso(tipo, "AccionesTardanza") != 1){							
						response.sendRedirect("Login");						
					}
					
					Tardanza t = AccionesTardanza.getOneTardanza(dni, fecha);					
					request.setAttribute("tardanza", t);
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/tardanza_edit.jsp");
					dispatcher.forward(request, response);
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				break;
				
			case "borrar":			
			
				if (AccionesUsuario.validarAcceso(tipo, "TardanzaList") != 1){							
					response.sendRedirect("Login");						
				}
			
				dni = Integer.parseInt(request.getParameter("dni"));
				fecha = (String) (request.getParameter("fecha"));			
									
				try {
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesTardanza") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					AccionesTardanza.bajaTardanza(dni, fecha);
				
					request.setAttribute("accion","listarTardanzas");
				
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/TardanzaList");
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
		if (AccionesUsuario.validarAcceso(tipo, "TardanzaEdit") != 1){							
			response.sendRedirect("Login");						
		}

		String accion = (String) request.getParameter("do");
			
				
		int dni = Integer.parseInt(request.getParameter("alumno_tardanza"));				
		String obs = (String) request.getParameter("observaciones");		
		String fecha = (String) request.getParameter("fecha");		
		String fecha_update = (String) request.getParameter("fecha_tardanza");		
		fecha_update = fecha_update.substring(6,10) +"-"+ fecha_update.substring(3,5) +"-"+ fecha_update.substring(0,2);
														
		switch(accion){
			
			case "alta":				
				
				if (AccionesUsuario.validarAcceso(tipo, "TardanzaList") != 1){							
					response.sendRedirect("Login");						
				}
				
				try {
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesTardanza") != 1){							
						response.sendRedirect("Login");						
					}
					
					Tardanza t = new Tardanza(dni, fecha_update, obs, "T", "");
					
					AccionesTardanza.altaTardanza(t);												
					
					request.setAttribute("accion","listarTardanzas");
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/TardanzaList");
					dispatcher.forward(request, response);				
				
				} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
					
					sesion.setAttribute("mensaje",AccionesMensaje.getOne(43));
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/tardanza_edit.jsp");
					dispatcher.forward(request, response);		
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				
				break;
				
			case "modificar":
				
				if (AccionesUsuario.validarAcceso(tipo, "TardanzaList") != 1){							
					response.sendRedirect("Login");						
				}
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesTardanza") != 1){							
					response.sendRedirect("Login");						
				}
					
				Tardanza t = new Tardanza(dni, fecha, obs, "T", "");
				
				try {
					
					AccionesTardanza.modificarTardanza(t, fecha_update);												
														
					request.setAttribute("accion","listarTardanzas");
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/TardanzaList");
					dispatcher.forward(request, response);				
				
				} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
										
					sesion.setAttribute("mensaje",AccionesMensaje.getOne(43));
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/tardanza_edit.jsp");
					dispatcher.forward(request, response);		
										
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				break;			
			
			}// fin del case
			
	}

}
