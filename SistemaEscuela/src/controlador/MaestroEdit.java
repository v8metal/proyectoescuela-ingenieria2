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
import datos.CustomException;

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
		
		Maestro maestro = new Maestro();
		
		try {
			
			//get parameter do of the request
			String accion = request.getParameter("accion");
			
			Integer dni = null;
			
			if(request.getParameter("dni") != null){
				dni = Integer.valueOf(request.getParameter("dni"));
				maestro = AccionesMaestro.getOne(dni.intValue());				
			}
			
			//System.out.println("accion= " + accion + "dni= " + dni);
			
			switch(accion){
			
			case "alta":	
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/maestro_edit.jsp");				
				dispatcher.forward(request, response);	
				
				break;
			
			case "baja":	
				
				maestro.setEstado(0);
				
				AccionesMaestro.updateOne(maestro);				
				
				response.sendRedirect(request.getContextPath() + "/maestroList");				
								
				break;				
			
			case "activar":	
				
				maestro.setEstado(1);
				
				AccionesMaestro.updateOne(maestro);				
				
				response.sendRedirect(request.getContextPath() + "/maestroList?tipo=inactivos");
				
				break;
				
			case "modificar":

				request.setAttribute("maestro", maestro);
				
				dispatcher = getServletContext().getRequestDispatcher("/maestro_edit.jsp");				
				dispatcher.forward(request, response);	
				
				break;

			case "borrar":
				
				AccionesMaestro.deleteOne(dni.intValue());				
				response.sendRedirect(request.getContextPath() + "/maestroList");
				
				break;

			}		

		} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
			sesion.setAttribute("error", "Error al intentar borrar " + maestro.getNombre() + " " + maestro.getApellido() + ". Ya esta asignado/a a un curso");
			response.sendRedirect("maestroList");
		
		} catch (CustomException e) {
			e.printStackTrace();
			sesion.setAttribute("error", "Error en la baja " + maestro.getNombre() + " " + maestro.getApellido() + ". Ya está asignado/a a un grado para el año en curso");
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
			
			String accion = request.getParameter("accion");			
			String apellido = request.getParameter("apellido");			
			String nombre = request.getParameter("nombre");			
			int dni = Integer.parseInt((String) request.getParameter("dni"));			
			String domicilio = request.getParameter("domicilio");			
			String telefono = request.getParameter("telefono");			
			
			Maestro maestro = new Maestro(dni, apellido, nombre, domicilio, telefono, 1);
			
			switch(accion){
			
			case "alta":
				
				//System.out.println("alta de maestro");
				
				AccionesMaestro.insertOne(maestro);
				
				break;
			
			case "modificar":
				
				AccionesMaestro.updateOne(maestro);
				
				break;
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
