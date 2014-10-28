package controlador;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesSancion;
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
								
			sesion.setAttribute("alumnos_sancion", AccionesSancion.getAlumnos(año, maestro.getDni()));			
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/sancion_edit.jsp");
			
			dispatcher.forward(request, response);

			break;
			
		case "modificar":			
			
				int dni = Integer.valueOf(request.getParameter("dni_sancion"));
				String fecha = request.getParameter("fecha_sancion");
				String hora = request.getParameter("hora_sancion");				
							
				Sancion s = AccionesSancion.getOne(dni, fecha, hora);
				
				sesion.setAttribute("sancion_edit", s);
				
				dispatcher = getServletContext().getRequestDispatcher("/sancion_edit.jsp");				
				
				dispatcher.forward(request, response);
				
				break;
				
		case "baja":								
				
				dni = Integer.valueOf(request.getParameter("dni_sancion"));
				fecha = request.getParameter("fecha_sancion");
				hora = request.getParameter("hora_sancion");				
				
				AccionesSancion.deleteOne(dni, fecha, hora);										
									
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
	
		String accion = request.getParameter("action");
		
		switch(accion){
		
		case "alta":		
			
			int dni = Integer.valueOf(request.getParameter("alumno_sancion"));
			String dia = request.getParameter("dia_sancion");
			String mes = request.getParameter("mes_sancion");
			String año = (String) sesion.getAttribute("año_sys");
			String hora = request.getParameter("hora_sancion");
			String motivo = request.getParameter("motivo_sancion");
			
			Sancion s = new Sancion(dni, año +"-"+ mes +"-"+ dia, hora, motivo);
			
			try {
				
				AccionesSancion.insertOne(s);
				
				sesion.setAttribute("exit_alta", "exit");				
				response.sendRedirect("SancionList");
				
			} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
				sesion.setAttribute("error", "<br>"+ "Ya existe una sanción para el mismo dia y horario"+"<br>");
				response.sendRedirect("sancion_edit.jsp");				
				
			} catch (Exception e) {				
				sesion.setAttribute("error", e);
				response.sendRedirect("sancion_edit.jsp");
			}		
			
			break;
		
		case "update":		
			
			s = (Sancion) sesion.getAttribute("sancion_edit");
			
			String dia_sancion = request.getParameter("dia_sancion");
			String mes_sancion = request.getParameter("mes_sancion");
			String año_sancion = request.getParameter("año_sancion");
			String hora_update = request.getParameter("hora_sancion");
			String motivo_update = request.getParameter("motivo_sancion");
						
			try {
				
				AccionesSancion.updateOne(s.getDni(), s.getFecha(), s.getHora(), año_sancion+"-"+mes_sancion+"-"+dia_sancion, hora_update, motivo_update);
										
				response.sendRedirect("SancionList");
				
			} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
				sesion.setAttribute("error", "<br>"+ "Ya existe una sanción para el mismo dia y horario"+"<br>");
				response.sendRedirect("sancion_edit.jsp");
				
			} catch (Exception e) {				
				sesion.setAttribute("error", e);
				response.sendRedirect("sancion_edit.jsp");
			}	
		
			break;
		}
	}   	  	    

 
 }
