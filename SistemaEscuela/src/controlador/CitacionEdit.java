package controlador;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesCitacion;
import conexion.AccionesUsuario;
import datos.Citacion;
import datos.Maestro;

/**
 * Servlet implementation class for Servlet: CitacionEdit
 *
 */
 public class CitacionEdit extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public CitacionEdit() {
		super();
	}   	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		// modulo de seguridad
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "CitacionEdit") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
		
		String accion = request.getParameter("do");
		
		if (accion == null){			
			if (request.getParameter("accion") != null){				
				accion = request.getParameter("accion");
			}						
		}		
		
		if(accion.equals("alta")){			
			
			Maestro maestro = (Maestro) sesion.getAttribute("maestro");
	    	
			int a�o = Integer.valueOf((String) sesion.getAttribute("a�o_sys"));
			
			// modulo de seguridad
			if (AccionesUsuario.validarAcceso(tipo, "AccionesCitacion") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			sesion.setAttribute("alumnos_citacion", AccionesCitacion.getAlumnos(a�o, maestro.getDni()));
			
			// modulo de seguridad
			if (AccionesUsuario.validarAcceso(tipo, "citacion_edit.jsp") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/citacion_edit.jsp");
			
			dispatcher.forward(request, response);
				
			}else if (accion.equals("modificar")){
							
				int dni = Integer.valueOf(request.getParameter("dni_citacion"));
				String fecha = request.getParameter("fecha_citacion");
				String hora = request.getParameter("hora_citacion");
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "AccionesCitacion") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
							
				Citacion c = AccionesCitacion.getOne(dni, fecha, hora);			
				
				sesion.setAttribute("citacion_edit", c);		
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "citacion_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/citacion_edit.jsp");				
				
				dispatcher.forward(request, response);
				
				}else if (accion.equals("baja")){				
				
					int dni = Integer.valueOf(request.getParameter("dni_citacion"));
					String fecha = request.getParameter("fecha_citacion");
					String hora = request.getParameter("hora_citacion");	
					
					// modulo de seguridad
					if (AccionesUsuario.validarAcceso(tipo, "AccionesCitacion") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					AccionesCitacion.deleteOne(dni, fecha, hora);	
					
					// modulo de seguridad
					if (AccionesUsuario.validarAcceso(tipo, "citacion_edit.jsp") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
									
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/CitacionList");				
				
					dispatcher.forward(request, response);								
		
				}
		}  	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		// modulo de seguridad
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "CitacionEdit") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
	
		String accion = request.getParameter("action");
							
		if(accion.equals("alta")){		
			
			int dni = Integer.valueOf(request.getParameter("alumno_citacion"));
			
			String dia = (String) request.getParameter("dia_citacion");
			String mes = (String) request.getParameter("mes_citacion");
			String a�o = (String) sesion.getAttribute("a�o_sys");
			String hora = request.getParameter("hora_citacion");
			String descripcion = request.getParameter("descripcion_citacion");
						
			Citacion s = new Citacion(dni, a�o +"-"+ mes +"-"+ dia, hora, descripcion);		
			
			try {			
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "AccionesCitacion") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				AccionesCitacion.insertOne(s);
				
				sesion.setAttribute("exit_alta", "exit");	
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "CitacionList") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}

				response.sendRedirect("CitacionList");
				
			} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
				sesion.setAttribute("error", "Ya existe una citacion para el mismo dia y horario");
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "citacion_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				response.sendRedirect("citacion_edit.jsp");			
				
			} catch (Exception e) {				
				sesion.setAttribute("error", e);
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "citacion_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				response.sendRedirect("citacion_edit.jsp");
			}						
		}
		else if (accion.equals("update")){
			
			Citacion c = (Citacion) sesion.getAttribute("citacion_edit");			
						
			String dia_citacion = request.getParameter("dia_citacion");
			String mes_citacion = request.getParameter("mes_citacion");
			String a�o_citacion = request.getParameter("a�o_citacion");
			String hora_update = request.getParameter("hora_citacion");			
			String descripcion_update = request.getParameter("descripcion_citacion");			
			
			try {
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "AccionesCitacion") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				AccionesCitacion.updateOne(c.getDni(), c.getFecha(), c.getHora(), a�o_citacion+"-"+mes_citacion+"-"+dia_citacion, hora_update, descripcion_update);										
				response.sendRedirect("CitacionList");
			
			} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
				sesion.setAttribute("error", "Ya existe una citacion para el mismo dia y horario");
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "citacion_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				response.sendRedirect("citacion_edit.jsp");			
			} catch (Exception e) {				
				sesion.setAttribute("error", e);
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "citacion_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				response.sendRedirect("citacion_edit.jsp");
			}	
		
			
		}
	}   	  	    
  	    
}