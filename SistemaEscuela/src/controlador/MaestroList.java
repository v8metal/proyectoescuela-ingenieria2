package controlador;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesMaestro;
import datos.Maestros;

/**
 * Servlet implementation class MaestroList
 */
public class MaestroList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MaestroList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		
		String tipo = "";
		
		if (request.getParameter("tipo") != null) {
			tipo = request.getParameter("tipo");
		}
		
		//System.out.println("tipo = " + tipo);
		
		Maestros maestro_list = null;
		Maestros maestro_list_inac = AccionesMaestro.getAllInactivos();
		
		if(tipo.equals("inactivos")){			
			maestro_list = AccionesMaestro.getAllInactivos();
			sesion.setAttribute("maestros", maestro_list);			
			response.sendRedirect("maestro_inactivo_list.jsp");
		}else{
			
			maestro_list = AccionesMaestro.getAllActivos();
						
			sesion.setAttribute("maestros", maestro_list);
			sesion.setAttribute("maestros_inac", maestro_list_inac);			
			response.sendRedirect("maestro_list.jsp");
		}
		
		
	}

}
