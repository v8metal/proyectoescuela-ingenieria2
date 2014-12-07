package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesMaestro;
import conexion.AccionesMensaje;
import conexion.AccionesUsuario;
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
		
		int type = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(type, "MaestroEdit") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
		
		Maestro maestro = new Maestro();
		
		try {
			
			//get parameter do of the request
			String accion = request.getParameter("accion");
			
			Integer dni = null;
			
			if(request.getParameter("dni") != null){
				dni = Integer.valueOf(request.getParameter("dni"));
				
				if (AccionesUsuario.validarAcceso(type, "AccionesMaestro") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				maestro = AccionesMaestro.getOne(dni.intValue());				
			}
			
			//System.out.println("accion= " + accion + "dni= " + dni);
			
			switch(accion){
			
			case "alta":
				
				if (AccionesUsuario.validarAcceso(type, "maestro_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/maestro_edit.jsp");				
				dispatcher.forward(request, response);	
				
				break;
			
			case "baja":
					
				maestro.setEstado(0);
				
				if (AccionesUsuario.validarAcceso(type, "AccionesMaestro") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				AccionesMaestro.updateOne(maestro);	
				
				if (AccionesUsuario.validarAcceso(type, "MaestroList") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				response.sendRedirect(request.getContextPath() + "/maestroList");				
								
				break;				
			
			case "activar":
				
				maestro.setEstado(1);
				
				if (AccionesUsuario.validarAcceso(type, "AccionesMaestro") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				AccionesMaestro.updateOne(maestro);
				
				if (AccionesUsuario.validarAcceso(type, "MaestroList") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				
				response.sendRedirect(request.getContextPath() + "/maestroList?tipo=inactivos");
				
				break;
				
			case "modificar":
				
				request.setAttribute("maestro", maestro);
				
				if (AccionesUsuario.validarAcceso(type, "maestro_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				dispatcher = getServletContext().getRequestDispatcher("/maestro_edit.jsp");				
				dispatcher.forward(request, response);	
				
				break;

			case "borrar":
				
				if (AccionesUsuario.validarAcceso(type, "MaestroList") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				AccionesMaestro.deleteOne(dni.intValue());
				response.sendRedirect(request.getContextPath() + "/maestroList");
				
				break;

			}		

		} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
			
			sesion.setAttribute("mensaje", AccionesMensaje.getOne(33));
			
			if (AccionesUsuario.validarAcceso(type, "MaestroList") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			response.sendRedirect("maestroList");
		
		} catch (CustomException e) {
			
			sesion.setAttribute("mensaje", AccionesMensaje.getOne(34));			
			
			if (AccionesUsuario.validarAcceso(type, "MaestroList") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			response.sendRedirect("maestroList");
		
		} catch (Exception e) {
			e.printStackTrace();
			
			if (AccionesUsuario.validarAcceso(type, "maestro_edit.jsp") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			response.sendRedirect("maestro_edit.jsp");
		}  
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get session of the request
		HttpSession sesion = request.getSession();
		
		int type = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(type, "MaestroEdit") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
		
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
				
				if (AccionesUsuario.validarAcceso(type, "AccionesMaestro") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				AccionesMaestro.insertOne(maestro);
				
				break;
			
			case "modificar":
				
				if (AccionesUsuario.validarAcceso(type, "AccionesMaestro") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				AccionesMaestro.updateOne(maestro);
			
				sesion.setAttribute("mensaje", AccionesMensaje.getOne(18));
				
				break;
			}
			
			if (AccionesUsuario.validarAcceso(type, "MaestroList") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			//redirect to the maestro list servlet 
			response.sendRedirect(request.getContextPath() + "/maestroList");	
			
		/*	
		} catch (java.lang.NumberFormatException e) {
			e.printStackTrace();
			sesion.setAttribute("error", "Se ha producido un error. Debe completar todos los campos. Exception: " + e.toString());
			
			if (AccionesUsuario.validarAcceso(type, "maestro_edit.jsp") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			response.sendRedirect("maestro_edit.jsp");
			
		*/
			
		} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
			
			if (AccionesUsuario.validarAcceso(type, "maestro_edit.jsp") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			sesion.setAttribute("mensaje", AccionesMensaje.getOne(35));			
			response.sendRedirect("maestro_edit.jsp");	
		
		} catch (Exception e) {

			//sesion.setAttribute("error", e);
			
			if (AccionesUsuario.validarAcceso(type, "maestro_edit.jsp") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			response.sendRedirect("maestro_edit.jsp");		
		}		
	}

}
