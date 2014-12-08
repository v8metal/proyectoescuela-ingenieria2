package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesMensaje;
import conexion.AccionesSancion;
import conexion.AccionesUsuario;
import datos.Maestro;
import datos.Sancion;

/**
 * Servlet implementation class for Servlet: SancionEdit
 *
 */
 public class SancionEdit extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public SancionEdit() {
		super();
	}   	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		// modulo de seguridad
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "SancionEdit") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
		
		String accion = request.getParameter("do");
		
		if (accion == null){			
			
			if (request.getParameter("accion") != null){				
				accion = request.getParameter("accion");
			}
			
		}		
		
		switch(accion){
		
			
		case "alta":				
			
			Maestro maestro = (Maestro) sesion.getAttribute("maestro");			
			
			int año = Integer.valueOf((String) sesion.getAttribute("año_sys"));
			
			if (AccionesUsuario.validarAcceso(tipo, "AccionesSancion") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
								
			sesion.setAttribute("alumnos_sancion", AccionesSancion.getAlumnos(año, maestro.getDni()));	
			
			if (AccionesUsuario.validarAcceso(tipo, "sancion_edit.jsp") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/sancion_edit.jsp");
			
			dispatcher.forward(request, response);

			break;
			
		case "modificar":			
			
				int dni = Integer.valueOf(request.getParameter("dni_sancion"));
				String fecha = request.getParameter("fecha_sancion");
				String hora = request.getParameter("hora_sancion");	
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesSancion") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
							
				Sancion s = AccionesSancion.getOne(dni, fecha, hora);
				
				sesion.setAttribute("sancion_edit", s);
				
				if (AccionesUsuario.validarAcceso(tipo, "sancion_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				dispatcher = getServletContext().getRequestDispatcher("/sancion_edit.jsp");				
				
				dispatcher.forward(request, response);
				
				break;
				
		case "baja":								
				
				dni = Integer.valueOf(request.getParameter("dni_sancion"));
				fecha = request.getParameter("fecha_sancion");
				hora = request.getParameter("hora_sancion");	
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesSancion") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				AccionesSancion.deleteOne(dni, fecha, hora);		
				
				if (AccionesUsuario.validarAcceso(tipo, "SancionList") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
									
				dispatcher = getServletContext().getRequestDispatcher("/SancionList");				
				
				dispatcher.forward(request, response);								
		
				break;
				
	
		}
	}  	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		// modulo de seguridad
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "SancionEdit") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
	
		String accion = request.getParameter("action");		
		String fecha = request.getParameter("fecha_sancion");
		fecha = fecha.substring(6,10) +"-"+ fecha.substring(3,5) +"-"+ fecha.substring(0,2);
		
		switch(accion){
		
		case "alta":		
			
			int dni = Integer.valueOf(request.getParameter("alumno_sancion"));
			
			String hora = request.getParameter("hora_sancion");
			String motivo = request.getParameter("motivo_sancion");
			
			Sancion s = new Sancion(dni, fecha, hora, motivo);
			
			try {
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "AccionesSancion") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				AccionesSancion.insertOne(s);
				
				sesion.setAttribute("exit_alta", "exit");
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "SancionList") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				response.sendRedirect("SancionList");
				
			} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
				sesion.setAttribute("mensaje", AccionesMensaje.getOne(56));
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "sancion_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				response.sendRedirect("sancion_edit.jsp");				
				
			} catch (Exception e) {				
				//sesion.setAttribute("error", e);
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "sancion_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				response.sendRedirect("sancion_edit.jsp");
			}		
			
			break;
		
		case "update":		
			
			s = (Sancion) sesion.getAttribute("sancion_edit");
			
			String hora_update = request.getParameter("hora_sancion");
			String motivo_update = request.getParameter("motivo_sancion");
						
			try {
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "AccionesSancion") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				AccionesSancion.updateOne(s.getDni(), s.getFecha(), s.getHora(), fecha, hora_update, motivo_update);
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "SancionList") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
										
				response.sendRedirect("SancionList");
				
			} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
				sesion.setAttribute("mensaje", AccionesMensaje.getOne(56));
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "sancion_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				response.sendRedirect("sancion_edit.jsp");
				
			} catch (Exception e) {				
				//sesion.setAttribute("error", e);				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "sancion_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				response.sendRedirect("sancion_edit.jsp");
			}	
		
			break;
		}
	}   	  	    

 
 }
