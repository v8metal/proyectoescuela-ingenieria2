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
import conexion.AccionesMensaje;
import conexion.AccionesUsuario;
import datos.Grado;
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
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "MateriaGradoList") != 1){							
			response.sendRedirect("Login");
		}
		
		if (AccionesUsuario.validarAcceso(tipo, "materias_list.jsp") != 1){							
			response.sendRedirect("Login");
		}
		
		try {
			
			//get parameter do of the request
			
			String accion = request.getParameter("do");
			
			String grado = null;
			String turno = null;
			int año;
			
			switch(accion){
			
			case "listar":
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesGrado") != 1){							
					response.sendRedirect("Login");
				}
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesMateria") != 1){							
					response.sendRedirect("Login");
				}
				sesion.removeAttribute("grado_materias");
				
				grado = request.getParameter("grado_list");
				turno = request.getParameter("grado_turno");
				año = Integer.valueOf(request.getParameter("grado_año"));
				
				Grado g = AccionesGrado.getOne(grado,turno, año);
				
				MateriasGrado mat_grado = AccionesGrado.getMaterias(grado, turno, año);		
						
				sesion.setAttribute("grado_materias", g);				
				
				sesion.setAttribute("materias_grado", mat_grado);		
			
				sesion.setAttribute("materias", AccionesMateria.getAllActivas());
								
				break;
				
			case "desasignar":
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesGrado") != 1){							
					response.sendRedirect("Login");
				}
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesMateria") != 1){							
					response.sendRedirect("Login");
				}
				
				g = (Grado) sesion.getAttribute("grado_materias");
				
				String materia = (String) request.getParameter("materia");
				
				AccionesGrado.deleteMateria(g.getGrado(), g.getTurno(), g.getAño(), materia);

				mat_grado = AccionesGrado.getMaterias(g.getGrado(), g.getTurno(), g.getAño());
							
				sesion.setAttribute("materias_grado", mat_grado);		
				
				sesion.setAttribute("materias", AccionesMateria.getAllActivas());
				
				break;
	
			}
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/materias_list.jsp");
			dispatcher.forward(request, response);
			
		} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
			sesion.setAttribute("mensaje", AccionesMensaje.getOne(30));
			response.sendRedirect("materias_list.jsp");	
		
		} catch (Exception e) {
			
			String listar = (String) sesion.getAttribute("listar");
			
			e.printStackTrace();
			sesion.setAttribute("error", e);
			
			if (listar.equals("mañana")){
				
				if (AccionesUsuario.validarAcceso(tipo, "grados_mañana_list.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}

				response.sendRedirect("grados_mañana_list.jsp");
			}
			
			if (listar.equals("tarde")){
				
				if (AccionesUsuario.validarAcceso(tipo, "grado_tarde_list.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}

				response.sendRedirect("grado_tarde_list.jsp");
			}
		}  
	}  	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");		
		if (AccionesUsuario.validarAcceso(tipo, "MateriaGradoList") != 1){							
			response.sendRedirect("Login");
		}
		
		Grado g = (Grado) sesion.getAttribute("grado_materias");
		
		String materia = (String) request.getParameter("materia_asignar");
		
		//System.out.println("materia_asignar= " + materia);		
		
		try {
			
			if (AccionesUsuario.validarAcceso(tipo, "materias_list.jsp") != 1){							
				response.sendRedirect("Login");
			}
			
			if (AccionesUsuario.validarAcceso(tipo, "AccionesGrado") != 1){							
				response.sendRedirect("Login");
			}
			
			if (AccionesUsuario.validarAcceso(tipo, "AccionesMateria") != 1){							
				response.sendRedirect("Login");
			}
			
			AccionesGrado.asignarMateria(g.getGrado(), g.getTurno(), g.getAño(), materia);
			
			MateriasGrado mat_grado = AccionesGrado.getMaterias(g.getGrado(), g.getTurno(), g.getAño());
			
			sesion.setAttribute("materias_grado", mat_grado);		
			
			sesion.setAttribute("materias", AccionesMateria.getAllActivas());			
			
			response.sendRedirect("materias_list.jsp");
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} catch (Exception e) {			
			e.printStackTrace();
		}
	
	}   
   	  	    
}