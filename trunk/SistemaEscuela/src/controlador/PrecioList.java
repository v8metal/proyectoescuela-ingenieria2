package controlador;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesPrecio;
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
		
		if(sesion.getAttribute("login")!=null){
			
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
				preciosMes = AccionesPrecio.getAllMes(año);
				preciosInscrip = AccionesPrecio.getAllInscrip(año);
				
				sesion.setAttribute("preciosMes", preciosMes);				
				sesion.setAttribute("preciosInscrip", preciosInscrip);
				
				response.sendRedirect("precio_list.jsp");
				
			} catch (Exception e) {

				e.printStackTrace();
			}
			
		}else{
			response.sendRedirect("login.jsp");
		}
	}
	

}
