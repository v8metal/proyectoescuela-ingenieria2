package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesMaestro;
import datos.Maestro;

/**
 * Servlet implementation class ServletModificarMaestro
 */
public class MaestroEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MaestroEdit() {
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
			Integer dni = null;
			if(request.getParameter("dni") != null)
				dni = Integer.valueOf(request.getParameter("dni"));
			
			//add / edit
			if(accion.equals("alta")){
				
				//get the request dispatcher
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/maestro_edit.jsp");
				
				//forward to the jsp file to display the maestro list
				dispatcher.forward(request, response);	
			
			}  else if(accion.equals("modificar")){
				
				//get the maestro from simulated DB
				Maestro maestro = new Maestro();
				if(dni != null){
					maestro = AccionesMaestro.getOne(dni.intValue());
				}
								
				//set the maestro object in the request
				request.setAttribute("maestro", maestro);
				
				//get the request dispatcher
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/maestro_edit.jsp");
				
				//forward to the jsp file to display the maestro list
				dispatcher.forward(request, response);	
				
			
			//delete
			} else if(accion.equals("baja")){
				
				//delete maestro by cod
				AccionesMaestro.deleteOne(dni.intValue());
				
				//redirect to the maestro list servlet 
				response.sendRedirect(request.getContextPath() + "/maestroList");

			} 
		} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
			sesion.setAttribute("error", "Error al intentar borrar maestro. Ya esta asignado a un curso");
			response.sendRedirect("maestroList");
			
		} catch (Exception e) {
			e.printStackTrace();

			sesion.setAttribute("error", e);
			response.sendRedirect("maestro_edit.jsp");
		}  
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get session of the request
		HttpSession sesion = request.getSession();
		
		try {
			
			//get maestro properties from the request
			
			int dni = 0;
			
			try {
				
				dni = Integer.parseInt(request.getParameter("dni"));
				
				} catch(NumberFormatException e){
					e.printStackTrace();
				}
			
			
			String apellido = request.getParameter("apellido");
			String nombre = request.getParameter("nombre");
			//int dni = Integer.parseInt(request.getParameter("dni"));
			String domicilio = request.getParameter("domicilio");
			String telefono = request.getParameter("telefono");
					
			//create a new maestro object
			Maestro maestro = new Maestro(dni, apellido, nombre, dni, domicilio, telefono);
						
			//save the maestro to DB
			if (dni == 0){
				//insert
				AccionesMaestro.insertOne(maestro);
			} else {
				//update
				AccionesMaestro.updateOne(dni, apellido, nombre, domicilio, telefono);
			}
			
			//redirect to the maestro list servlet 
			response.sendRedirect(request.getContextPath() + "/maestroList");	
			
		} catch (java.lang.NumberFormatException e) {
			e.printStackTrace();
			sesion.setAttribute("error", "Se ha producido un error. Debe completar todos los campos. Exception: " + e.toString());
			response.sendRedirect("maestro_edit.jsp");
		
		} catch (Exception e) {

			sesion.setAttribute("error", e);
			response.sendRedirect("maestro_edit.jsp");
		}
	}

}
