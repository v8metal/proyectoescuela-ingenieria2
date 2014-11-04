package controlador;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesGrado;
import conexion.AccionesUsuario;
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
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "GradoList") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}

		
		if ((Grado) sesion.getAttribute("grado_edit") != null){		
			sesion.removeAttribute("grado_edit");
		}
		
		if (AccionesUsuario.validarAcceso(tipo, "AccionesGrado") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
		
		Grados grados = new Grados();
		grados= AccionesGrado.getAll();
					
		sesion.setAttribute("grados_alta",  grados);
		
		grados = new Grados();		
					
		String listar = "";
				
		if (request.getParameter("listar") != null){
			
			listar = request.getParameter("listar");
			sesion.setAttribute("listar", listar);
			
		}else{
			
			listar = (String) sesion.getAttribute("listar");
			
		}
		
		if (listar.equals("mañana")){
			
			if (AccionesUsuario.validarAcceso(tipo, "grados_mañana_list.jsp") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			grados = AccionesGrado.getPendingMañana();
			sesion.setAttribute("grados_pendientes",  grados);
			response.sendRedirect("grados_mañana_list.jsp");
		}
		
		if (listar.equals("tarde")){
			
			if (AccionesUsuario.validarAcceso(tipo, "grado_tarde_list.jsp") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			grados = AccionesGrado.getPendingTarde();
			sesion.setAttribute("grados_pendientes",  grados);
			response.sendRedirect("grado_tarde_list.jsp");
		}
		
	}
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}
	
}