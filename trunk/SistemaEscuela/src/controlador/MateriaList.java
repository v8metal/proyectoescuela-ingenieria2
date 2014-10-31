package controlador;

import java.io.IOException;

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
		
		sesion.removeAttribute("error");
		
		try {

			String from = request.getParameter("from"); 	// nombre de la pagina que llamo al servlet 	
			if (from == null) {	
				from = 	"otro_lado";
			}
			
			if (from.equals("menu_admin") || from.equals("materiaEdit") || from.equals("materia_list") || from.equals("materia_inactiva_list")){
				
				if(from.equals("menu_admin") || from.equals("materiaEdit") || from.equals("materia_list")){
				
					Materias materia_list = AccionesMateria.getAllActivas();
					sesion.setAttribute("materias", materia_list);
					
					materia_list = AccionesMateria.getAllInactivas();
					sesion.setAttribute("materiasbaja", materia_list);
					
					response.sendRedirect("materia_list.jsp");
					
				}else{
					
					Materias materia_list = AccionesMateria.getAllInactivas();
					sesion.setAttribute("materiasbaja", materia_list);
					response.sendRedirect("materia_inactiva_list.jsp");
				}						
				
				
				
			} else {
				
				//get parameter do of the request
				String grado = null;
			
				String accion = request.getParameter("do");
				
				//get the grado from simulated DB
				
				if(accion.equals("listar")){				
				
					if(request.getParameter("grado_list") != null) {
						grado = String.valueOf(request.getParameter("grado_list"));					
					}			
				
				
					String dni_alum = request.getParameter("dni");
					sesion.setAttribute("dni_alum", dni_alum);
					String periodo = request.getParameter("periodo");
					sesion.setAttribute("periodo", periodo);
				
					String turno = (String)sesion.getAttribute("turno");
					int a�o = Integer.parseInt((String)sesion.getAttribute("a�o"));
					MateriasGrado mat_grado = AccionesGrado.getMateriasByGradoTurnoYA�o(grado, turno, a�o);
									
					sesion.setAttribute("grado", grado);			
					sesion.setAttribute("materias_grado", mat_grado);				
					sesion.setAttribute("materias", AccionesMateria.getAllActivas());
				
					} 
				
					if (from.equals("nota_lista_alum")) {
					
						//get the request dispatcher
						RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/nota_lista_mat.jsp");
					
						//forward to the jsp file to display the list
						dispatcher.forward(request, response);
					
					} else {
					
						//get the request dispatcher
						RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/materias_list.jsp");
						
						//	forward to the jsp file to display the list
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
