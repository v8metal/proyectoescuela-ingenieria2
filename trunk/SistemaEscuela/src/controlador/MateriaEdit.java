package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesMateria;
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
		
		try {
			
			//get parameter do of the request
			String accion = request.getParameter("do");
			
			//System.out.println("doGet accion = " + accion);
			    
			
			//get the cod of the request
			String mat = null;
			if(request.getParameter("materia") != null)
				mat = (String) request.getParameter("materia");
			
			//add / edit
			//switch (accion){
			
			switch (accion){
			
			case "alta":
				
				//get the request dispatcher
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/materia_edit.jsp");
				
				//forward to the jsp file to display the materia list
				dispatcher.forward(request, response);	
				
				break;
			
			case "baja":
				
								
				//int i = AccionesMateria.bajaLogicaMateria(mat); 
				
				AccionesMateria.bajaLogicaMateria(mat);
				
				//i != 0 --agregar captura de excepcion cuando hay notas cargadas
				
				response.sendRedirect(request.getContextPath() + "/materiaList?from=materiaEdit");
				
				break;
				
			case "activar":
				
				
				AccionesMateria.activarMateria(mat); //agregar captura de excepcion cuando hay notas cargadas
				
				//request.setAttribute("from", "materia_list");
				
				response.sendRedirect(request.getContextPath() + "/materiaList?from=materia_list");
				
				break;
				
				
			case "borrar":
				
				AccionesMateria.deleteOne(mat);				
				//redirect to the materia list servlet 
				response.sendRedirect(request.getContextPath() + "/materiaList?from=materiaEdit");
				break;
				
			}			
	
		
		} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
			sesion.setAttribute("error", "Error al intentar borrar materia. Ya esta asignada a un curso");
			response.sendRedirect("materiaList?from=materiaEdit");
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
			
			String accion = "";
			String materia = "";
			//int estado;
			
			accion = (String) request.getParameter("accion");
			
			materia = request.getParameter("materia");
			
			//System.out.println("materia= " + materia);
			//System.out.println("accion Do Post= " + accion);
			
			//if (request.getParameter("estado") != null){
			//	int estado = Integer.parseInt(request.getParameter("estado"));
			
			//create a new materia object
			Materia m = new Materia(materia, 1);	
						
			//save the materia to DB
			if (accion.equals("alta")){
				//insert
				AccionesMateria.insertOne(m);
			} 
			//else {
				//update
			//	AccionesMateria.updateOne(materia, estado);
			//}
			
			//redirect to the materia list servlet 
			response.sendRedirect(request.getContextPath() + "/materiaList?from=materiaEdit");	
		} catch (Exception e) {
			sesion.setAttribute("error", e);
			response.sendRedirect("materia_edit.jsp");
		}
	}

}
