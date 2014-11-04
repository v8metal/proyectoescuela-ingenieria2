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
import conexion.AccionesUsuario;

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
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		
		if (AccionesUsuario.validarAcceso(tipo, "EntrevistaEdit") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
			
		if(sesion.getAttribute("dni_maestro") != null){
				
			String accion = request.getParameter("do");
			String fecha = request.getParameter("fecha");
			String hora = request.getParameter("hora");
				
			int dni_maestro= (int)sesion.getAttribute("dni_maestro");
				
			//System.out.println("doGet accion= " + accion);
			
			sesion.setAttribute("accion", accion);
			
			if(accion.equals("modificar")){
				
				if (AccionesUsuario.validarAcceso(tipo, "entrevista_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				Entrevista e=null;
		
				try {
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesEntrevista") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					e = AccionesEntrevista.getOneEntrevista(fecha, hora, dni_maestro);
					sesion.setAttribute("entrevista", e);
					response.sendRedirect("entrevista_edit.jsp");
						
				} catch (Exception e1) {
					e1.printStackTrace();
				}
						
			}else if(accion.equals("borrar")){
				
				if (AccionesUsuario.validarAcceso(tipo, "EntrevistaList") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				try {
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesEntrevista") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
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
						
						if (AccionesUsuario.validarAcceso(tipo, "entrevista_edit.jsp") != 1){							
							response.sendRedirect("Login"); //redirecciona al login, sin acceso						
						}
						
						if (AccionesUsuario.validarAcceso(tipo, "AccionesMaestro") != 1){							
							response.sendRedirect("Login"); //redirecciona al login, sin acceso						
						}
						
						sesion.setAttribute("maestros_ent_alta", AccionesMaestro.getAllActivos());
						
						//forward to the jsp file to display the grado list
						RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/entrevista_edit.jsp");
						
						dispatcher.forward(request, response);	
					
					}  else if(accion.equals("modificar")){
						
						if (AccionesUsuario.validarAcceso(tipo, "entrevista_edit.jsp") != 1){							
							response.sendRedirect("Login"); //redirecciona al login, sin acceso						
						}
						
						String fecha = request.getParameter("fecha");
						String nombre = request.getParameter("nombre");
						
						if (AccionesUsuario.validarAcceso(tipo, "AccionesEntrevista") != 1){							
							response.sendRedirect("Login"); //redirecciona al login, sin acceso						
						}
						
						Entrevista entrevista = AccionesEntrevista.getOne(fecha, nombre);
														
						//set the tutor object in the request
						
						sesion.setAttribute("entrevista_edit", entrevista);											
										
						//get the request dispatcher
						RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/entrevista_edit.jsp");
						
						//forward to the jsp file to display the alumno list
						dispatcher.forward(request, response);	
						
					//delete
					} else if(accion.equals("borrar")){
						
						if (AccionesUsuario.validarAcceso(tipo, "EntrevistaList") != 1){							
							response.sendRedirect("Login"); //redirecciona al login, sin acceso						
						}
						
						String fecha = request.getParameter("fecha");
						String nombre = request.getParameter("nombre");
						
						if (AccionesUsuario.validarAcceso(tipo, "AccionesEntrevista") != 1){							
							response.sendRedirect("Login"); //redirecciona al login, sin acceso						
						}
						
						AccionesEntrevista.deleteOne(fecha, nombre);
						
						//redirect to the maestro list servlet 
						response.sendRedirect(request.getContextPath() + "/EntrevistaList");

					}		
										
				} catch (Exception e) {
					
					if (AccionesUsuario.validarAcceso(tipo, "entrevista_edit.jsp") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					e.printStackTrace();
					sesion.setAttribute("error", e);										
					response.sendRedirect("entrevista_edit.jsp");
				}  
		}		

	}  	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "EntrevistaEdit") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
			
		if(sesion.getAttribute("dni_maestro") != null){
			
			if (AccionesUsuario.validarAcceso(tipo, "EntrevistaList") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			//String nombre_alum = request.getParameter("nombre_alum");			
			//String accion = (String)sesion.getAttribute("accion");
			//int dni_maestro=(int)sesion.getAttribute("dni_maestro");
			//Entrevista e = new Entrevista("","",dni_maestro,nombre_alum,desc);
			String desc = request.getParameter("desc");
			Entrevista e = (Entrevista)sesion.getAttribute("entrevista");
			
			e.setDescripcion(desc);
				
			try {
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesEntrevista") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				AccionesEntrevista.modificarEntrevista(e);
				response.sendRedirect("EntrevistaList");
			} catch (Exception e1) {
				e1.printStackTrace();
			}
				
			}else{
				
				String accion = request.getParameter("action");
				
				//System.out.println("doPost accion= " + accion);
				
				if(accion.equals("alta")){
					
					if (AccionesUsuario.validarAcceso(tipo, "EntrevistaList") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					//System.out.println("alta");
				
					String dia = (String) request.getParameter("dia_entrevista");					
					String mes = (String) request.getParameter("mes_entrevista");			
					String año = (String) sesion.getAttribute("año_sys");			
					String hora = (String) request.getParameter("hora_entrevista");
					int maestro = Integer.valueOf(request.getParameter("maestro_entrevista"));
					String nombre = (String) request.getParameter("nombre_entrevista");
											
					Entrevista ent = new Entrevista(año +"-"+ mes +"-"+ dia, hora, maestro, nombre, "");
							
					try {
					
						if (AccionesUsuario.validarAcceso(tipo, "AccionesEntrevista") != 1){							
							response.sendRedirect("Login"); //redirecciona al login, sin acceso						
						}
						
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
					
					if (AccionesUsuario.validarAcceso(tipo, "EntrevistaList") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					Entrevista et = (Entrevista) sesion.getAttribute("entrevista_edit");		

					String dia = request.getParameter("dia_entrevista");
					String mes = request.getParameter("mes_entrevista");
					String año = request.getParameter("año_entrevista");
					String hora = request.getParameter("hora_entrevista");
					
					try {
						
						if (AccionesUsuario.validarAcceso(tipo, "AccionesEntrevista") != 1){							
							response.sendRedirect("Login"); //redirecciona al login, sin acceso						
						}
												
						AccionesEntrevista.updateOne(año +"-"+ mes +"-"+ dia, hora, et.getFecha(), et.getHora(), et.getdniMaestro());
						
						response.sendRedirect("EntrevistaList");
					
					} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
						
						if (AccionesUsuario.validarAcceso(tipo, "entrevista_edit.jsp") != 1){							
							response.sendRedirect("Login"); //redirecciona al login, sin acceso						
						}
						
						sesion.setAttribute("error", "Ya existe una entrevista para el mismo dia y horario");
						response.sendRedirect("entrevista_edit.jsp");
						
					} catch (Exception e) {
						e.printStackTrace();
					}			
					
				}
			}
			
	}   	  	    
}	