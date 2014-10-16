package controlador;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesEntrevista;
import datos.Entrevistas;

/**
 * Servlet implementation class for Servlet: EntrevistaList
 *
 */
 public class EntrevistaList extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public EntrevistaList() {
		super();
	}   	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();		
		if(sesion.getAttribute("login")!=null){
			
		Entrevistas entrevistas=null;
		if(!sesion.getAttribute("login").equals("admin")){
			int dni_maestro = (int)sesion.getAttribute("dni_maestro");
			try {
				entrevistas = AccionesEntrevista.getAllEntrevistas_Maestro(dni_maestro);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			entrevistas = AccionesEntrevista.getAll();
		}
					
		sesion.setAttribute("entrevistas",  entrevistas);	
		
		response.sendRedirect("entrevista_list.jsp");
		}else{
			response.sendRedirect("login.jsp");
		}
		
	}  	
	   	  	    
}