package controlador;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesGrado;
import conexion.AccionesMateria;
import datos.Materias;
import datos.MateriasGrado;

/**
 * Servlet implementation class MateriaList
 */
public class MateriaList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MateriaList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		try {

			String from = request.getParameter("from"); 	// nombre de la pagina que llamo al servlet 	
			if (from == null) {	
				from = 	"otro_lado";
			}
			
			if (from.equals("menu_admin") || from.equals("materiaEdit")) {
						
				Materias materia_list = AccionesMateria.getAll();
				sesion.setAttribute("materias", materia_list);
				
				response.sendRedirect("materia_list.jsp");
				
			} else {
				
				//get parameter do of the request
				String grado = null;
			
				String accion = request.getParameter("do");
				
				//get the grado from simulated DB
				
				if(accion.equals("listar")){				
				
				if(request.getParameter("grado_list") != null) {
						grado = String.valueOf(request.getParameter("grado_list"));					
				}			
				
		//		MateriasGrado mat_grado = AccionesGrado.getMaterias(grado);
				
				String dni_alum = request.getParameter("dni");
				sesion.setAttribute("dni_alum", dni_alum);
				String periodo = request.getParameter("periodo");
				sesion.setAttribute("periodo", periodo);
				
				String turno = (String)sesion.getAttribute("turno");
				int año = Integer.parseInt((String)sesion.getAttribute("año"));
				MateriasGrado mat_grado = AccionesGrado.getMateriasByGradoTurnoYAño(grado, turno, año);
				
				Materias materias = new Materias();
				
				for (Integer m : mat_grado.getLista()) {
					
					materias.agregarMateria(AccionesMateria.getOne(m));
						
				}
				
				sesion.setAttribute("grado", grado);			
				sesion.setAttribute("materias_grado", materias);				
				sesion.setAttribute("materias", AccionesMateria.getAll());
				
				} /* else if(accion.equals("desasignar")){
					
					grado = request.getParameter("grado_modif");				
					int materia = Integer.valueOf(request.getParameter("cod_materia"));
					
					AccionesGrado.deleteMateria(grado,materia);
				
					// se puede evitar esto?
					MateriasGrado mat_grado = AccionesGrado.getMaterias(grado);
					
					Materias materias = new Materias();
					
					for (Integer m : mat_grado.getLista()) {
						
						materias.agregarMateria(AccionesMateria.getOne(m));
							
					}
					
					sesion.setAttribute("materias_grado", materias);		
					
					sesion.setAttribute("materias", AccionesMateria.getAll());
					
					//get the request dispatcher
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/materias_list.jsp");
						
					//forward to the jsp file to display the alumno list
					dispatcher.forward(request, response);				
					// se puede evitar esto?	
				}
				 		*/
				
				if (from.equals("nota_lista_alum")) {
					
					//get the request dispatcher
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/nota_lista_mat.jsp");
						
					//forward to the jsp file to display the list
					dispatcher.forward(request, response);
					
				} else {
					
					//get the request dispatcher
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/materias_list.jsp");
						
					//forward to the jsp file to display the list
					dispatcher.forward(request, response);
					
				}
				
			}
							
		} catch (Exception e) {
			e.printStackTrace();

			sesion.setAttribute("error", e);
			response.sendRedirect("grado_list.jsp");
		}  
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
