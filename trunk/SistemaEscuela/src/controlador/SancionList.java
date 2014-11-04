package controlador;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesSancion;
import conexion.AccionesUsuario;
import datos.Maestro;

/**
 * Servlet implementation class for Servlet: SancionList
 *
 */
 public class SancionList extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public SancionList() {
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
		
		// modulo de seguridad
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "SancionList") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
		
		String acceso = "segundo";
		
		if (request.getParameter("acceso") != null){
			acceso = request.getParameter("acceso");
		}	
		
		int a�o;		
		
		if (acceso.equals("primero")){
			//Primer acceso. Se obtiene el parametro 'a�o_sancion_selected' y se setea el atributo 'a�o_sancion'		
				a�o = Integer.valueOf(request.getParameter("a�o_sancion_selected"));
				sesion.setAttribute("a�o_sancion", a�o);
		}else{			
			//Segundo acceso. Se utiliza el atributo 'a�o_sancion', seteado previamente en el primer acceso
			
			if(sesion.getAttribute("a�o_sancion") != null){
				
				a�o = (Integer) sesion.getAttribute("a�o_sancion");
				
			}else{ //se ingresa al alta sin passar por el listado 
				
				a�o = Integer.valueOf((String) sesion.getAttribute("a�o_sys"));
			}
			
		}		
		
		Maestro maestro = (Maestro) sesion.getAttribute("maestro");	
		
		// modulo de seguridad
		if (AccionesUsuario.validarAcceso(tipo, "AccionesSancion") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
				
		sesion.setAttribute("sanciones_list", AccionesSancion.getAll(a�o, maestro.getDni()));		
		
		// modulo de seguridad
		if (AccionesUsuario.validarAcceso(tipo, "sanciones_list.jsp") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
						
		response.sendRedirect("sanciones_list.jsp");
		
	}   	  	    
}
 