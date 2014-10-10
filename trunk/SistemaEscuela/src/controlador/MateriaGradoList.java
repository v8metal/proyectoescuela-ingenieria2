package controlador;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesGrado;
import conexion.AccionesMateria;
import datos.Grado;
import datos.Materias;
import datos.MateriasGrado;

/**
 * Servlet implementation class for Servlet: MateriaGradoList
 *
 */
 public class MateriaGradoList extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public MateriaGradoList() {
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
			
			String grado = null;
			String turno = null;
			int año;
			
			//get the grado from simulated DB
			
			if(accion.equals("listar")){				
				
				sesion.removeAttribute("grado_materias");
				
				grado = request.getParameter("grado_list");
				turno = request.getParameter("grado_turno");
				año = Integer.valueOf(request.getParameter("grado_año"));
				
				Grado g = AccionesGrado.getOne(grado,turno, año);
	
				MateriasGrado mat_grado = AccionesGrado.getMaterias(grado, turno, año);		
						
				Materias materias = null;				
				
				if (mat_grado.getLista().size() != 0){					
					
					materias = new Materias();
					
					for (String m : mat_grado.getLista()) {
						materias.agregarMateria(AccionesMateria.getOne(m));													
					}
										
				}
				
				sesion.setAttribute("grado_materias", g);				
				
				sesion.setAttribute("materias_grado", materias);		
			
				sesion.setAttribute("materias", AccionesMateria.getAllActivas());
								
				//get the request dispatcher
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/materias_list.jsp");
				
				//forward to the jsp file to display the alumno list
				dispatcher.forward(request, response);				
			
			}else if(accion.equals("desasignar")){
				
				Grado g = (Grado) sesion.getAttribute("grado_materias");
				
				String materia = (String) request.getParameter("materia");
				
				AccionesGrado.deleteMateria(g.getGrado(), g.getTurno(), g.getAño(), materia);
				
				// se puede evitar esto?
				MateriasGrado mat_grado = AccionesGrado.getMaterias(g.getGrado(), g.getTurno(), g.getAño());
				
				Materias materias = new Materias();
				
				for (String m : mat_grado.getLista()) {
					
					materias.agregarMateria(AccionesMateria.getOne(m));
						
				}
				
				sesion.setAttribute("materias_grado", materias);		
				
				sesion.setAttribute("materias", AccionesMateria.getAllActivas());
				
				//get the request dispatcher
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/materias_list.jsp");
					
				//forward to the jsp file to display the alumno list
				dispatcher.forward(request, response);				
				// se puede evitar esto?	
			}			
			
		} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
			//e.printStackTrace();
			sesion.setAttribute("error", "<br><br>"+ "La materia no se puede desasignar, tiene notas cargadas"+"<br><br>");
			response.sendRedirect("materias_list.jsp");	
		
		} catch (Exception e) {
			e.printStackTrace();

			sesion.setAttribute("error", e);
			response.sendRedirect("grado_list.jsp");
		}  
	}  	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();

		Grado g = (Grado) sesion.getAttribute("grado_materias");
		
		String materia = (String) request.getParameter("materia_asignar");
		
		System.out.println("materia_asignar= " + materia);		
		
		try {
			
			AccionesGrado.asignarMateria(g.getGrado(), g.getTurno(), g.getAño(), materia);
			
			MateriasGrado mat_grado = AccionesGrado.getMaterias(g.getGrado(), g.getTurno(), g.getAño());
			
			Materias materias = new Materias();
			
			for (String m : mat_grado.getLista()) {
				
				materias.agregarMateria(AccionesMateria.getOne(m));
					
			}
			
			sesion.setAttribute("materias_grado", materias);		
			
			sesion.setAttribute("materias", AccionesMateria.getAllActivas());			
			
			response.sendRedirect("materias_list.jsp");
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} catch (Exception e) {			
			e.printStackTrace();
		}
	
	}   
   	  	    
}