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
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "CitacionEdit") != 1){							
			response.sendRedirect("Login");						
		}
		
		String accion = request.getParameter("do");
		
		if (accion == null){			
			if (request.getParameter("accion") != null){				
				accion = request.getParameter("accion");
			}						
		}		
		
		if(accion.equals("alta")){			
			
			Maestro maestro = (Maestro) sesion.getAttribute("maestro");
	    	
			int año = Integer.valueOf((String) sesion.getAttribute("año_sys"));
			
			if (AccionesUsuario.validarAcceso(tipo, "AccionesCitacion") != 1){							
				response.sendRedirect("Login");						
			}
			
			sesion.setAttribute("alumnos_citacion", AccionesCitacion.getAlumnos(año, maestro.getDni()));
			
			if (AccionesUsuario.validarAcceso(tipo, "citacion_edit.jsp") != 1){							
				response.sendRedirect("Login");						
			}
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/citacion_edit.jsp");
			
			dispatcher.forward(request, response);
				
			}else if (accion.equals("modificar")){
							
				int dni = Integer.valueOf(request.getParameter("dni_citacion"));
				String fecha = request.getParameter("fecha_citacion");
				String hora = request.getParameter("hora_citacion");
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesCitacion") != 1){							
					response.sendRedirect("Login");						
				}
							
				Citacion c = AccionesCitacion.getOne(dni, fecha, hora);			
				
				sesion.setAttribute("citacion_edit", c);		
				
				if (AccionesUsuario.validarAcceso(tipo, "citacion_edit.jsp") != 1){							
					response.sendRedirect("Login");						
				}
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/citacion_edit.jsp");				
				
				dispatcher.forward(request, response);
				
				}else if (accion.equals("baja")){				
				
					int dni = Integer.valueOf(request.getParameter("dni_citacion"));
					String fecha = request.getParameter("fecha_citacion");
					String hora = request.getParameter("hora_citacion");	
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesCitacion") != 1){							
						response.sendRedirect("Login");						
					}
					
					AccionesCitacion.deleteOne(dni, fecha, hora);	
					
					if (AccionesUsuario.validarAcceso(tipo, "citacion_edit.jsp") != 1){							
						response.sendRedirect("Login");						
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
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "CitacionEdit") != 1){							
			response.sendRedirect("Login");						
		}
	
		String accion = request.getParameter("action");
		
		String fecha = request.getParameter("fecha_citacion");	
		fecha = fecha.substring(6,10) +"-"+ fecha.substring(3,5) +"-"+ fecha.substring(0,2);
							
		if(accion.equals("alta")){		
			
			int dni = Integer.valueOf(request.getParameter("alumno_citacion"));			
			String hora = request.getParameter("hora_citacion");
			String descripcion = request.getParameter("descripcion_citacion");
						
			Citacion s = new Citacion(dni, fecha, hora, descripcion);		
			
			try {			
				if (AccionesUsuario.validarAcceso(tipo, "AccionesCitacion") != 1){							
					response.sendRedirect("Login");						
				}
				
				AccionesCitacion.insertOne(s);
				
				sesion.setAttribute("exit_alta", "exit");	
				
				if (AccionesUsuario.validarAcceso(tipo, "CitacionList") != 1){							
					response.sendRedirect("Login");						
				}

				response.sendRedirect("CitacionList");
				
			} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
				sesion.setAttribute("error", "Ya existe una citacion para el mismo dia y horario");
				
				if (AccionesUsuario.validarAcceso(tipo, "citacion_edit.jsp") != 1){							
					response.sendRedirect("Login");						
				}
				
				response.sendRedirect("citacion_edit.jsp");			
				
			} catch (Exception e) {				
				sesion.setAttribute("error", e);
				
				if (AccionesUsuario.validarAcceso(tipo, "citacion_edit.jsp") != 1){							
					response.sendRedirect("Login");						
				}
				
				response.sendRedirect("citacion_edit.jsp");
			}						
		}
		else if (accion.equals("update")){
			
			Citacion c = (Citacion) sesion.getAttribute("citacion_edit");			
				
			String hora_update = request.getParameter("hora_citacion");			
			String descripcion_update = request.getParameter("descripcion_citacion");			
			
			try {
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesCitacion") != 1){							
					response.sendRedirect("Login");						
				}
				
				AccionesCitacion.updateOne(c.getDni(), c.getFecha(), c.getHora(), fecha, hora_update, descripcion_update);										
				response.sendRedirect("CitacionList");
			
			} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
				sesion.setAttribute("error", "Ya existe una citacion para el mismo dia y horario");
				
				if (AccionesUsuario.validarAcceso(tipo, "citacion_edit.jsp") != 1){							
					response.sendRedirect("Login");						
				}
				
				response.sendRedirect("citacion_edit.jsp");			
			} catch (Exception e) {				
				sesion.setAttribute("error", e);
								
				if (AccionesUsuario.validarAcceso(tipo, "citacion_edit.jsp") != 1){							
					response.sendRedirect("Login");						
				}
				
				response.sendRedirect("citacion_edit.jsp");
			}	
		
			
		}
	}   	  	    
  	    
}