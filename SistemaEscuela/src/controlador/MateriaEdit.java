package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesMateria;
import conexion.AccionesUsuario;
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
		
		// modulo de seguridad
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "MateriaEdit") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
		
		String mat = "";
		
		try {
			
			String accion = request.getParameter("do");			    
			
			//String mat = null;
			
			if(request.getParameter("materia") != null){
				mat = (String) request.getParameter("materia");
			}	
			
			switch (accion){
			
			case "alta":
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "materia_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				//get the request dispatcher
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/materia_edit.jsp");
				
				//forward to the jsp file to display the materia list
				dispatcher.forward(request, response);	
				
				break;
			
			case "baja":
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "AccionesMateria") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				AccionesMateria.bajaLogicaMateria(mat);
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "MateriaList") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				response.sendRedirect(request.getContextPath() + "/materiaList?from=materiaEdit");
				
				break;
				
			case "activar":
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "AccionesMateria") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				AccionesMateria.activarMateria(mat);
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "MateriaList") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
								
				response.sendRedirect(request.getContextPath() + "/materiaList?from=materia_list");
				
				break;
				
				
			case "borrar":
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "AccionesMateria") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				AccionesMateria.deleteOne(mat);			
				
				// modulo de seguridad
				if (AccionesUsuario.validarAcceso(tipo, "MateriaList") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				 
				response.sendRedirect(request.getContextPath() + "/materiaList?from=materiaEdit");
				
				break;
				
			}			
	
		
		} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
			sesion.setAttribute("error", "Error al intentar borrar " + mat + ". Ya esta asignada a un curso");
			
			// modulo de seguridad
			if (AccionesUsuario.validarAcceso(tipo, "MateriaList") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			response.sendRedirect("materiaList?from=materiaEdit");
			
		} catch (CustomException e) {
			e.printStackTrace();
			sesion.setAttribute("error", "Error en la baja " + mat + ". Ya está asignada a un grado para el año en curso");
			
			// modulo de seguridad
			if (AccionesUsuario.validarAcceso(tipo, "MateriaList") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			response.sendRedirect("materiaList?from=materia_list"	);
			
		} catch (Exception e) {
			e.printStackTrace();
			sesion.setAttribute("error", e);
			
			// modulo de seguridad
			if (AccionesUsuario.validarAcceso(tipo, "materia_edit.jsp") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			response.sendRedirect("materia_edit.jsp");
		
		}	
    	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get session of the request
		HttpSession sesion = request.getSession();
		
		// modulo de seguridad
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "MateriaEdit") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
		
		try {
			
			String accion = (String) request.getParameter("accion");
			
			String materia = request.getParameter("materia");
						
			Materia m = new Materia(materia, 1);	

			if (accion.equals("alta")){
				
					// modulo de seguridad
					if (AccionesUsuario.validarAcceso(tipo, "AccionesMateria") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
				
					AccionesMateria.insertOne(m);
			}
			
			// modulo de seguridad
			if (AccionesUsuario.validarAcceso(tipo, "MateriaList") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
				
			response.sendRedirect(request.getContextPath() + "/materiaList?from=materiaEdit");
			
		} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
			
			sesion.setAttribute("error", "Error al insertar, la materia ya existe");	
			
			// modulo de seguridad
			if (AccionesUsuario.validarAcceso(tipo, "materia_edit.jsp") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			response.sendRedirect("materia_edit.jsp");
			
		} catch (Exception e) {
			sesion.setAttribute("error", e);	
			
			// modulo de seguridad
			if (AccionesUsuario.validarAcceso(tipo, "materia_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			response.sendRedirect("materia_edit.jsp");
		}
	}

}
