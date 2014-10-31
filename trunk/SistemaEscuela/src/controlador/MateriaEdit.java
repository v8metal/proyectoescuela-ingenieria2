package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesMateria;
import datos.CustomException;
import datos.Materia;

/**
 * Servlet implementation class MateriaEdit
 */
public class MateriaEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MateriaEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get session of the request
		HttpSession sesion = request.getSession();
		
		String mat = "";
		
		try {
			
			String accion = request.getParameter("do");			    
			
			//String mat = null;
			
			if(request.getParameter("materia") != null){
				mat = (String) request.getParameter("materia");
			}	
			
			switch (accion){
			
			case "alta":
				
				//get the request dispatcher
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/materia_edit.jsp");
				
				//forward to the jsp file to display the materia list
				dispatcher.forward(request, response);	
				
				break;
			
			case "baja":
				
				AccionesMateria.bajaLogicaMateria(mat);
				
				response.sendRedirect(request.getContextPath() + "/materiaList?from=materiaEdit");
				
				break;
				
			case "activar":
				
				
				AccionesMateria.activarMateria(mat);
								
				response.sendRedirect(request.getContextPath() + "/materiaList?from=materia_list");
				
				break;
				
				
			case "borrar":
				
				AccionesMateria.deleteOne(mat);				
				 
				response.sendRedirect(request.getContextPath() + "/materiaList?from=materiaEdit");
				
				break;
				
			}			
	
		
		} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
			sesion.setAttribute("error", "Error al intentar borrar " + mat + ". Ya esta asignada a un curso");
			response.sendRedirect("materiaList?from=materiaEdit");
			
		} catch (CustomException e) {
			e.printStackTrace();
			sesion.setAttribute("error", "Error en la baja " + mat + ". Ya está asignada a un grado para el año en curso");
			response.sendRedirect("materiaList?from=materia_list"	);
			
		} catch (Exception e) {
			e.printStackTrace();
			sesion.setAttribute("error", e);
			response.sendRedirect("materia_edit.jsp");
		
		}	
    	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get session of the request
		HttpSession sesion = request.getSession();
		
		try {
			
			String accion = (String) request.getParameter("accion");
			
			String materia = request.getParameter("materia");
						
			Materia m = new Materia(materia, 1);	

			if (accion.equals("alta")){
					AccionesMateria.insertOne(m);
			} 
				
			response.sendRedirect(request.getContextPath() + "/materiaList?from=materiaEdit");
			
		} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
			
			sesion.setAttribute("error", "Error al insertar. Ya esta asignada a un curso");			
			response.sendRedirect("materia_edit.jsp");
			
		} catch (Exception e) {
			sesion.setAttribute("error", e);			
			response.sendRedirect("materia_edit.jsp");
		}
	}

}
