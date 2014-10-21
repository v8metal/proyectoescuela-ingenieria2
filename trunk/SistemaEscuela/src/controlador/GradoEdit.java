package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import datos.Grado;
import datos.Grados; //alta de grados
import conexion.AccionesGrado;
import datos.Maestro;
import datos.Maestros;
import datos.Alumno;
import datos.Alumnos;
import conexion.AccionesMaestro;

/**
 * Servlet implementation class for Servlet: GradoEdit
 *
 */
 public class GradoEdit extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public GradoEdit() {
		super();
	}   	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		try {
			
			//get parameter do of the request
			String accion = request.getParameter("do");
			    
			//get the cod of the request			
						
			//add / edit						
			if(accion.equals("alta")){
								
				Maestros maestros = AccionesMaestro.getAllActivos();												
				request.setAttribute("maestros_list",  maestros);
				
				String listar = (String) sesion.getAttribute("listar");
				
				Grados grados = null;
				
				if (listar.equals("mañana")){
					
					grados = AccionesGrado.getPendingMañana();
					sesion.setAttribute("grados_pendientes",  grados);					
				}
				
				if (listar.equals("tarde")){
					
					grados = AccionesGrado.getPendingTarde();
					sesion.setAttribute("grados_pendientes",  grados);				
				}
																				
				request.setAttribute("grados_alta",  grados);				

				//get the request dispatcher
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/grado_edit.jsp");
				
				//forward to the jsp file to display the grado list
				dispatcher.forward(request, response);	
			
			}else if(accion.equals("modificar")){
				
				String grado = request.getParameter("grado_modif");
				String turno = request.getParameter("grado_turno");
				
				int año = AccionesGrado.getCurrentYear(grado, turno);
				
				Grado g = null;
				
				if (año == 0){
					
					g = AccionesGrado.getOne(grado,turno);				
					
					sesion.setAttribute("grado_edit", g);
					
				}else{
					
					g = AccionesGrado.getOne(grado,turno, año);					
					
					if (g.getGrado() == null){
						
						g = AccionesGrado.getOne(grado, turno);
						
				}
				
				//set the tutor object in the request
				sesion.setAttribute("grado_edit", g);
					
				Maestros maestros = AccionesMaestro.getAll();				
								
				Maestro tit = AccionesMaestro.getOne(g.getMaestrotit());
				request.setAttribute("maestro_tit", tit);
					
				Maestro par = AccionesMaestro.getOne(g.getMaestropar());
				request.setAttribute("maestro_par", par);
					
				request.setAttribute("maestros_list",  maestros);				
				
				}
				
				//get the request dispatcher
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/grado_edit.jsp");
				
				//forward to the jsp file to display the alumno list
				dispatcher.forward(request, response);	
				
			
			//delete
			} else if(accion.equals("baja")){
				
				Grado grado = (Grado) sesion.getAttribute("grado_edit");
				sesion.removeAttribute("grado_edit");

				AccionesGrado.deleteOne(grado);
				
				//redirect to the maestro list servlet 
				response.sendRedirect(request.getContextPath() + "/GradoList");

			}else if(accion.equals("promocion")){
				
				String grado = request.getParameter("grado_modif");
				String turno = request.getParameter("grado_turno");
				int año = Integer.parseInt(request.getParameter("año"));
				
				
				String grado_prom = null;
				
				if (grado.equals("Sala 4")){					
					grado_prom ="Sala 5";
				}else if(grado.equals("Sala 5")){
					grado_prom ="1° Grado";				
				}else if(grado.equals("1° Grado")){
					grado_prom ="2° Grado";
				}else if(grado.equals("2° Grado")){
					grado_prom ="3° Grado";
				}else if(grado.equals("3° Grado")){
					grado_prom ="4° Grado";
				}else if(grado.equals("4° Grado")){
					grado_prom ="5° Grado";
				}else if(grado.equals("5° Grado")){
					grado_prom ="6° Grado";
				}else if(grado.equals("6° Grado")){
					grado_prom ="7° Grado";
				}
				
				Integer titular = null;
				Integer paralelo = null;
								
				Alumnos alumnos = AccionesGrado.getAlumnosGrado(grado, turno, año);				
				
				for (Alumno  a: alumnos.getLista()){	
					
					AccionesGrado.promAlumnoGrado(grado_prom, turno, a.getDni(), año+1);
					
				}			
				
				titular = AccionesGrado.getTitular(grado_prom, turno, año);
				paralelo = AccionesGrado.getParalelo(grado_prom, turno, año);
				
				if (titular == 0 && paralelo == 0){
										
					titular = AccionesGrado.getTitular(grado, turno, año);
					paralelo = AccionesGrado.getParalelo(grado, turno, año);
					
					AccionesGrado.insertMaestroGrado(grado_prom, turno, año+1, titular, paralelo);
					
				}else{
					
					AccionesGrado.insertMaestroGrado(grado_prom, turno, año+1, titular, paralelo);
				}				
				
				
				response.sendRedirect(request.getContextPath() + "/GradoList");				
			}
					
		} catch (Exception e) {
			e.printStackTrace();

			sesion.setAttribute("error", e);
			response.sendRedirect("grado_edit.jsp");
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get session of the request
		HttpSession sesion = request.getSession();
		
		try {
											
			String action = null;
			
			action = (String) request.getParameter("action");
			
			int evaluacion = Integer.parseInt(request.getParameter("evaluacion"));
			String bimestral = request.getParameter("bimestral");
			String salon = request.getParameter("salon_grado");
			int maestro_tit = 0;
			int maestro_par = 0;
						
			if (action.equals("insert")){
								
				String string = request.getParameter("anio_grado_turno");				
				String[] parts = string.split("-");
				
				String grado = parts[0];
				String turno = parts[1];			
								
				Grado g = new Grado(grado, turno, evaluacion, bimestral.equals("si"), salon);
				AccionesGrado.insertOne(g);
			
			
			}else if (action.equals("update")){
					
					//Update para grados con maestro asignado
														
					Grado g = (Grado) sesion.getAttribute("grado_edit");
					sesion.removeAttribute("grado_edit");

					if (request.getParameter("maestro_tit_grado") != null){
						maestro_tit = Integer.parseInt(request.getParameter("maestro_tit_grado"));
					}
					
					if (request.getParameter("maestro_par_grado") != null) { 
						maestro_par = Integer.parseInt(request.getParameter("maestro_par_grado"));
					}
					
					
					AccionesGrado.updateOne(g.getGrado(), g.getTurno(), evaluacion ,bimestral.equals("si"), salon);
						
					if (g.getAño() != 0){
							
						if (g.getMaestrotit() == 0 && g.getMaestropar() == 0){
							
							AccionesGrado.insertMaestroGrado(g.getGrado(), g.getTurno(), g.getAño(), maestro_tit, maestro_par);
							
						}else{
							
							AccionesGrado.UpdateMaestroGrado(g.getGrado(), g.getTurno(), g.getAño(), maestro_tit, maestro_par);							
						}
					}										
					
			}			
			
			response.sendRedirect(request.getContextPath() + "/GradoList");			
	
		} catch (Exception e) {

			sesion.setAttribute("error", e);
			response.sendRedirect("grado_edit.jsp");
		}
			
	}
	
 }