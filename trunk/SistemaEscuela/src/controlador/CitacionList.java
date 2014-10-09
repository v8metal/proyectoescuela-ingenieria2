package controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesCitacion;
import datos.Maestro;

/**
 * Servlet implementation class for Servlet: CitacionList
 *
 */
 public class CitacionList extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public CitacionList() {
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
		
		String acceso = "segundo";
		
		if (request.getParameter("acceso") != null){
			acceso = request.getParameter("acceso");
		}	
		
		int año;		
		
		if (acceso.equals("primero")){
			//Primer acceso. Se obtiene el parametro 'año_sancion_selected' y se setea el atributo 'año_sancion'		
				año = Integer.valueOf(request.getParameter("año_sancion_selected"));
				sesion.setAttribute("año_citacion", año);
		}else{			
			//Segundo acceso. Se utiliza el atributo 'año_citacion', seteado previamente en el primer acceso			
			año = (Integer) sesion.getAttribute("año_citacion");			
		}	
				
		Maestro maestro = (Maestro) sesion.getAttribute("maestro");
		
		sesion.setAttribute("citaciones_list", AccionesCitacion.getAll(año, maestro.getDni()));		
						
		response.sendRedirect("citaciones_list.jsp");
		
	}   	  	    
}