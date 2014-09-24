package controlador;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesGrado;
import datos.Grado;
import datos.Grados;

/**
 * Servlet implementation class for Servlet: GradoList
 *
 */
 public class GradoList extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public GradoList() {
		super();
	}   	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		
			
		HttpSession sesion = request.getSession();
		
		if ((Grado) sesion.getAttribute("grado_edit") != null){		
			sesion.removeAttribute("grado_edit");
		}
		
		Grados grados = AccionesGrado.getAll();
					
		sesion.setAttribute("grados_alta",  grados);
		
		grados = AccionesGrado.getPendingAll();
		
		sesion.setAttribute("grados_pendientes",  grados);
		
		response.sendRedirect("grado_list.jsp");
	}
		
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}
	
}