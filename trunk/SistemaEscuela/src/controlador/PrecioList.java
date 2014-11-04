package controlador;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesPrecio;
import conexion.AccionesUsuario;
import datos.PreciosInscrip;
import datos.PreciosMes;

/**
 * Servlet implementation class PrecioList
 */
public class PrecioList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PrecioList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		
		//sesion.removeAttribute("añoPrecios");
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "PrecioList") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
			
		//modificación
		sesion.removeAttribute("ultimoMes");
		sesion.removeAttribute("mesModific");
		sesion.removeAttribute("precioInscrip");			
		//modificación
			
		int año=0;
						
		if(request.getParameter("año") == null){				
			año = (Integer)sesion.getAttribute("añoPrecios");
		}else{
			sesion.removeAttribute("añoPrecios");
			año = Integer.parseInt(request.getParameter("año"));
		}
			
		sesion.setAttribute("añoPrecios", año);
									
		PreciosMes preciosMes;
		PreciosInscrip preciosInscrip;
			
		try {
			
			if (AccionesUsuario.validarAcceso(tipo, "AccionesPrecio") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			preciosMes = AccionesPrecio.getAllMes(año);
			preciosInscrip = AccionesPrecio.getAllInscrip(año);
				
			sesion.setAttribute("preciosMes", preciosMes);				
			sesion.setAttribute("preciosInscrip", preciosInscrip);
			
			if (AccionesUsuario.validarAcceso(tipo, "precio_list.jsp") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			response.sendRedirect("precio_list.jsp");
				
		} catch (Exception e) {

			e.printStackTrace();
		}			

	}
	

}
