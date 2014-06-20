package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.StringUtils;

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
			    
			
			//get the cod of the request
			Integer codigo = null;
			if(request.getParameter("codigo") != null)
				codigo = Integer.valueOf(request.getParameter("codigo"));
			
			//add / edit
			if(accion.equals("alta")){
				
				//get the request dispatcher
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/materia_edit.jsp");
				
				//forward to the jsp file to display the materia list
				dispatcher.forward(request, response);	
			
			}  else if(accion.equals("modificar")){
				
				//get the materia from simulated DB
				Materia materia = new Materia();
				if(codigo != null){
					materia = AccionesMateria.getOne(codigo.intValue());
				}
								
				//set the materia object in the request
				request.setAttribute("materia", materia);
				
				//get the request dispatcher
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/materia_edit.jsp?");
				
				//forward to the jsp file to display the maestro list
				dispatcher.forward(request, response);	
				
			
			//delete
			} else if(accion.equals("baja")){
				
				//delete materia by cod
				AccionesMateria.deleteOne(codigo.intValue());
				
				//redirect to the materia list servlet 
				response.sendRedirect(request.getContextPath() + "/materiaList?from=materiaEdit");

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
			
			//get materia properties from the request
			int codigo = 0;
			
			try {
				
				codigo = Integer.parseInt(request.getParameter("codigo"));
				
				} catch(NumberFormatException e){
					e.printStackTrace();
				}
			
			String nombre = request.getParameter("nombre");
					
			//create a new materia object
			Materia materia = new Materia(codigo, nombre);
						
			//save the materia to DB
			if (codigo == 0){
				//insert
				AccionesMateria.insertOne(materia);
			} else {
				//update
				AccionesMateria.updateOne(codigo, nombre);
			}
			
			//redirect to the materia list servlet 
			response.sendRedirect(request.getContextPath() + "/materiaList?from=materiaEdit");	
		} catch (Exception e) {
			sesion.setAttribute("error", e);
			response.sendRedirect("materia_edit.jsp");
		}
	}

}
