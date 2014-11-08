package controlador;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesPrecio;
import conexion.AccionesUsuario;
import datos.PrecioInscrip;
import datos.PrecioMes;

/**
 * Servlet implementation class PrecioEdit
 */
public class PrecioEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PrecioEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "PrecioEdit") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
			
		String accion = request.getParameter("accion");
		int a�o = 0;
			
		//System.out.println("accion = " + accion);
			
		switch (accion){
			
			case ("altaMes"):				
				
				if (AccionesUsuario.validarAcceso(tipo, "precioMes_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
			
				a�o =  (Integer) sesion.getAttribute("a�oPrecios");
										
				sesion.setAttribute("control", "altaMes");
				
				try {					
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesPrecio") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
									
					sesion.setAttribute("ultimoMes", AccionesPrecio.getUltimoMes(a�o));			
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/precioMes_edit.jsp");
					dispatcher.forward(request, response);
								
				} catch (Exception e) {
				
					e.printStackTrace();
				}
			
				break;
			
				case ("modificarMes"):				
			
				if (AccionesUsuario.validarAcceso(tipo, "precioMes_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				sesion.setAttribute("control", "modificarMes");
				
				a�o = Integer.parseInt(request.getParameter("a�o"));			
				int mes = Integer.parseInt(request.getParameter("mes"));
				
				try {
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesPrecio") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					sesion.setAttribute("a�oModific", a�o);
					sesion.setAttribute("mesModific", AccionesPrecio.getOneMes(a�o, mes));
					
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/precioMes_edit.jsp");
					dispatcher.forward(request, response);
								
				} catch (Exception e) {
				
					e.printStackTrace();
				}
				
				break;
			
				case ("bajaMes"):							
				
				if (AccionesUsuario.validarAcceso(tipo, "PrecioList") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				a�o = Integer.parseInt(request.getParameter("a�o"));			
				mes = Integer.parseInt(request.getParameter("mes"));
				
				try {
				
					if (AccionesUsuario.validarAcceso(tipo, "AccionesPrecio") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					AccionesPrecio.borrarMes(a�o, mes);
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/PrecioList");
					dispatcher.forward(request, response);
								
				} catch (Exception e) {
				
					e.printStackTrace();
				}
			
				break;
				
				case ("altaInscrip"):				
				
				if (AccionesUsuario.validarAcceso(tipo, "precioInscrip_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				a�o =  (Integer) sesion.getAttribute("a�oPrecios");
				
				sesion.setAttribute("control", "altaInscrip");
				
				try {					
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/precioInscrip_edit.jsp");
					dispatcher.forward(request, response);
								
				} catch (Exception e) {
				
					e.printStackTrace();
				}
			
				break;
			
				case ("modificarInscrip"):
				
				if (AccionesUsuario.validarAcceso(tipo, "precioInscrip_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				sesion.setAttribute("control", "modificarInscrip");
				
				a�o = Integer.parseInt(request.getParameter("a�o"));				
				
				try {
					
					sesion.setAttribute("a�oModific", a�o);
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesPrecio") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
										
					PrecioInscrip precioI = AccionesPrecio.getOneInscrip(a�o);
					
					sesion.setAttribute("precioInscrip", precioI);					
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/precioInscrip_edit.jsp");
					dispatcher.forward(request, response);
								
				} catch (Exception e) {
				
					e.printStackTrace();
				}
				
				break;
			
				case ("bajaInscrip"):							
				
				if (AccionesUsuario.validarAcceso(tipo, "PrecioList") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				//sesion.setAttribute("control", "modificarInscrip");
				
				a�o = Integer.parseInt(request.getParameter("a�o"));			
			
				try {
				
					AccionesPrecio.borrarInscrip(a�o);
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/PrecioList");
					dispatcher.forward(request, response);
								
				} catch (Exception e) {
				
					e.printStackTrace();
				}
			
				break;				
				
			}			

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "PrecioEdit") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
		
		if (AccionesUsuario.validarAcceso(tipo, "PrecioList") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
		
		if (AccionesUsuario.validarAcceso(tipo, "AccionesPrecio") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
			
		String control =(String)sesion.getAttribute("control");
		sesion.removeAttribute("control");
		sesion.removeAttribute("ultimoMes");
			
		//String dia = (String) request.getParameter("dia_inscrip");			
			
		String mes = "";
			
		if (request.getParameter("mes") !=  null){
			mes = request.getParameter("mes");
		}
		//}else{
		//	mes = request.getParameter("mes_inscrip");
		//}
		
		String fecha = "";
		
		if (request.getParameter("fecha_inscrip") != null){
			fecha = request.getParameter("fecha_inscrip");
			fecha = fecha.substring(6,10) +"-"+ fecha.substring(3,5) +"-"+ fecha.substring(0,2);			
		}
		
						
		int grupo = 0, hijos = 0;
		
		if (request.getParameter("grupo") != null){			
			grupo = Integer.parseInt(request.getParameter("grupo"));
			hijos = Integer.parseInt(request.getParameter("hijos"));
		}
			
		//compartidas por mes e inscripciones
		int regular =Integer.parseInt(request.getParameter("regular"));
		int recargo  = Integer.parseInt(request.getParameter("recargo"));
						
		int a�o = 0;
		int i = 0;
			
		switch (mes){
			
			case "Enero":
				i = 1;
				break;
				
			case "Febrero":
				i = 2;
				break;
				
			case "Marzo":
				i = 3;
				break;
			case "Abril":
				i = 4;
				break;
				
			case "Mayo":
				i = 5;
				break;
				
			case "Junio":
				i = 6;
				break;
				
			case "Julio":
				i = 7;
				break;
				
			case "Agosto":
				i = 8;
				break;
				
			case "Septiembre":
				i = 9;
				break;
				
			case "Octubre":
				i = 10;
				break;
				
			case "Noviembre":
				i = 11;
				break;
				
			case "Diciembre":
				i = 12;
				break;
			
			case "otro":
				i = 13;
				break;
			}
			
		switch (control){
			
			
			case "altaMes":			
		
				a�o =  (Integer) sesion.getAttribute("a�oPrecios");
				
				try {
					
					for(;i<13;i++){						
						PrecioMes precio =new PrecioMes(a�o,i,regular,grupo,hijos,recargo);
						AccionesPrecio.altaPrecioMes(precio);
					}
															
				} catch (SQLException e) {
					
					String error = request.getParameter("error");
					sesion.setAttribute("error", error);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
											
				break;
				
			case "modificarMes":
				
				a�o = (Integer) sesion.getAttribute("a�oModific");				
				sesion.removeAttribute("a�oModific");
				sesion.removeAttribute("mesModific");
				
				PrecioMes precio = new PrecioMes(a�o, i,regular,grupo,hijos,recargo);
				
				try {
					
					AccionesPrecio.modificarMes(precio,i);
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				break;
					
						
			case "altaInscrip":			
			
			a�o =  (Integer) sesion.getAttribute("a�oPrecios");
			
			try {
				
				PrecioInscrip precioI = new PrecioInscrip(a�o, fecha, regular, recargo);
				AccionesPrecio.altaPrecioInscrip(precioI);				
														
			} catch (SQLException e) {
				
				String error = request.getParameter("error");
				sesion.setAttribute("error", error);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
										
			break;
			
			case "modificarInscrip":
			
			a�o = (Integer) sesion.getAttribute("a�oModific");			
			sesion.removeAttribute("inscripModif");
			
			try {
				
				PrecioInscrip precioI =new PrecioInscrip(a�o, fecha, regular, recargo);
				AccionesPrecio.modificarInscrip(precioI);
				
				sesion.removeAttribute("inscripModif");
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			break;
				
		}			
				
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/PrecioList");
			dispatcher.forward(request, response);
		}
}
