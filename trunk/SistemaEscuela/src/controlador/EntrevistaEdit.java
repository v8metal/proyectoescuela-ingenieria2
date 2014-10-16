package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import datos.Entrevista;
import conexion.AccionesEntrevista;
import conexion.AccionesMaestro;

/**
 * Servlet implementation class for Servlet: EntrevistaEdit
 *
 */
 public class EntrevistaEdit extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public EntrevistaEdit() {
		super();
	}   	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		if(sesion.getAttribute("login")!=null){
			
			if(!sesion.getAttribute("login").equals("admin")){
				
				String accion = request.getParameter("do");
				String fecha = request.getParameter("fecha");
				String hora = request.getParameter("hora");
				
				int dni_maestro= (int)sesion.getAttribute("dni_maestro");
				
				sesion.setAttribute("accion", accion);
				
				if(accion.equals("modificar")){
					Entrevista e=null;
					try {
						e = AccionesEntrevista.getOneEntrevista(fecha, hora, dni_maestro);
						sesion.setAttribute("entrevista", e);
						response.sendRedirect("entrevista_edit.jsp");
						
					} catch (Exception e1) {
						e1.printStackTrace();
					}
						
				}else if(accion.equals("borrar")){
					try {
						AccionesEntrevista.borrarEntrevista(fecha, dni_maestro, hora);
						response.sendRedirect("EntrevistaList");
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}else{
				try {
					
					//get parameter do of the request
					String accion = request.getParameter("do");
					
					if(accion.equals("alta")){
						
						sesion.setAttribute("maestros_ent_alta", AccionesMaestro.getAllActivos());
						
						//forward to the jsp file to display the grado list
						RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/entrevista_edit.jsp");
						
						dispatcher.forward(request, response);	
					
					}  else if(accion.equals("modificar")){
						
						String fecha = request.getParameter("fecha");
						String nombre = request.getParameter("nombre");
						
						Entrevista entrevista = AccionesEntrevista.getOne(fecha, nombre);
														
						//set the tutor object in the request
						
						sesion.setAttribute("entrevista_edit", entrevista);											
										
						//get the request dispatcher
						RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/entrevista_edit.jsp");
						
						//forward to the jsp file to display the alumno list
						dispatcher.forward(request, response);	
						
					//delete
					} else if(accion.equals("borrar")){
						
						String fecha = request.getParameter("fecha");
						String nombre = request.getParameter("nombre");
														
						AccionesEntrevista.deleteOne(fecha, nombre);
						
						//redirect to the maestro list servlet 
						response.sendRedirect(request.getContextPath() + "/EntrevistaList");

					}		
										
				} catch (Exception e) {
					e.printStackTrace();

					sesion.setAttribute("error", e);
					response.sendRedirect("entrevista_edit.jsp");
				}  
			}
			
		}else{
			response.sendRedirect("login.jsp");
		}

	}  	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		if(sesion.getAttribute("login")!=null){
			
			if(!sesion.getAttribute("login").equals("admin")){
				
				String nombre_alum = request.getParameter("nombre_alum");				
				String desc = request.getParameter("desc");
				//String accion = (String)sesion.getAttribute("accion");
				int dni_maestro=(int)sesion.getAttribute("dni_maestro");
				Entrevista x = (Entrevista)sesion.getAttribute("entrevista");
				Entrevista e = new Entrevista("","",dni_maestro,nombre_alum,desc);
				
				try {
					AccionesEntrevista.modificarEntrevista(e, x.getFecha(), x.getdniMaestro(), x.getHora());
					response.sendRedirect("EntrevistaList");
				} catch (Exception e1) {
					e1.printStackTrace();
				}
				
			}else{
				
				String accion = request.getParameter("action");
				
				System.out.println("accion= " + accion);
				
				if(accion.equals("alta")){
					
					System.out.println("alta");
				
					String dia = (String) request.getParameter("dia_entrevista");					
					String mes = (String) request.getParameter("mes_entrevista");			
					String año = (String) sesion.getAttribute("año_sys");			
					String hora = (String) request.getParameter("hora_entrevista");
					int maestro = Integer.valueOf(request.getParameter("maestro_entrevista"));
					String nombre = (String) request.getParameter("nombre_entrevista");			
							
					Entrevista ent = new Entrevista(año +"-"+ mes +"-"+ dia, hora, maestro, nombre, "");
							
					try {
					
						AccionesEntrevista.insertOne(ent);
					
						response.sendRedirect("EntrevistaList");
						
					} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
						sesion.setAttribute("error", "<br>"+ "Ya existe una entrevista para el mismo dia y horario"+"<br>");
						response.sendRedirect("entrevista_edit.jsp");		
					
					} catch (Exception e) {				
						sesion.setAttribute("error", e);
						response.sendRedirect("entrevista_edit.jsp");
					}
					
				}else if(accion.equals("modificar")){			

					Entrevista et = (Entrevista) sesion.getAttribute("entrevista_edit");		

					String dia = request.getParameter("dia_entrevista");
					String mes = request.getParameter("mes_entrevista");
					String año = request.getParameter("año_entrevista");
					String hora = request.getParameter("hora_entrevista");
					
					try {
						
						AccionesEntrevista.updateOne(año +"-"+ mes +"-"+ dia, hora, et.getFecha(), et.getHora(), et.getdniMaestro());
						
						response.sendRedirect("EntrevistaList");
					
					} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
						sesion.setAttribute("error", "<br>"+ "Ya existe una entrevista para el mismo dia y horario"+"<br>");
						response.sendRedirect("entrevista_edit.jsp");
						
					} catch (Exception e) {
						e.printStackTrace();
					}			
					
				}
			}
			
		}else{
			response.sendRedirect("login.jsp");
		}
		
	}   	  	    
}