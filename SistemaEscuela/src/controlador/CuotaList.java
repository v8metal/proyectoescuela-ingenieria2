package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesAlumno;
import conexion.AccionesCuota;
import conexion.AccionesGrado;
import datos.Alumnos;
import datos.Cuotas;
import datos.Grados;

/**
 * Servlet implementation class CuotaList
 */
public class CuotaList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CuotaList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
						
		
		if(sesion.getAttribute("login")!=null){
			
			//System.out.println("CuotaList doGet");
			
			String accion = "";
			
			if (request.getAttribute("accion") != null){
				 accion = (String) request.getAttribute("accion");
			}else{
				 accion = (String) request.getParameter("accion");
			}
			
			//System.out.println("accion= " + accion);
			
			int año = 0;
			Grados grados = new Grados();
			
			switch(accion){			
			
			case "solicitarGrados":
			
			sesion.removeAttribute("gradoCuota");
			sesion.removeAttribute("turnoCuota");	
			//sesion.removeAttribute("añoCuota");
			sesion.removeAttribute("alumnos_cuota");
						
			año = Integer.parseInt(request.getParameter("año_cuotas"));			
									
			try {
				
				//obtiene los grados en condiciones de cobrar cuota, para el año seleccionado
				grados = AccionesGrado.getAñoGradosCuota(año);
				
				request.setAttribute("gradosCuota", grados);				
				request.setAttribute("añoCuota", año);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/menu_cuotas.jsp");
				dispatcher.forward(request, response);				
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			break;
			
			case "listarGrado":
				
			sesion.removeAttribute("año");
			sesion.removeAttribute("dni");
			sesion.removeAttribute("mes");
			sesion.removeAttribute("pagosMes");
				
			String string = "";
			String[] parts;
			String grado="", turno="";
			
			if(request.getParameter("anio") != null){
				año = Integer.parseInt(request.getParameter("anio"));
				string = request.getParameter("grado_anio");				
				parts = string.split(" - ");				
				grado = parts[0];
				turno = parts[1];
				
				sesion.setAttribute("gradoCuota",grado);
				sesion.setAttribute("turnoCuota",turno);	
				sesion.setAttribute("añoCuota",año);
				
				try {
					
					//obtiene los grados en condiciones de cobrar cuota, para el año seleccionado
					Alumnos alumnos = AccionesAlumno.getAllByGradoTurnoYAño(grado,turno,año);
					
					sesion.setAttribute("alumnos_cuota", alumnos);					
					
				} catch (Exception e) {				
					e.printStackTrace();
				}

			}
			
				
			//System.out.println("grado = " + grado + " turno = " + turno + " año= " + año);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/cuota_list.jsp");
			dispatcher.forward(request, response);			
			
			
			break;

			case "visualizarPagos":
				
			//System.out.println("visualizar pagos goGet");
			int dni = 0, mes = 0;
			
			//pago edit
			sesion.removeAttribute("pagoEdit");
			//pago edit
			
			if (request.getParameter("año") != null){ //se ingresa por primera vez
			
				año = Integer.parseInt(request.getParameter("año"));			
				dni = Integer.parseInt(request.getParameter("dni"));			
				mes = Integer.parseInt(request.getParameter("mes"));
				

				sesion.setAttribute("año", año);
				sesion.setAttribute("dni", dni);
				sesion.setAttribute("mes", mes);
				
				
				//System.out.println("año= " + año);
				//System.out.println("dni= " + dni);
				//System.out.println("mes= " + mes);			
				
				try {
					
					//obtiene los grados en condiciones de cobrar cuota, para el año seleccionado
					
					Cuotas cuotas = AccionesCuota.getPagosMes(dni, año, mes);
					
				    sesion.setAttribute("pagosMes", cuotas); //lo dejamos como session						
					
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
			}			
						
			if (request.getAttribute("accion") != null){
				
				//sesion.removeAttribute("pagosMes");
				
				año = (Integer) sesion.getAttribute("año");			
				dni = (Integer) sesion.getAttribute("dni");			
				mes = (Integer) sesion.getAttribute("mes");
				
				try {
					
					//obtiene los grados en condiciones de cobrar cuota, para el año seleccionado
					
					Cuotas cuotas = AccionesCuota.getPagosMes(dni, año, mes);
					
				    sesion.setAttribute("pagosMes", cuotas); //lo dejamos como session						
					
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
			}
				
			dispatcher = getServletContext().getRequestDispatcher("/pagos_list.jsp");
			dispatcher.forward(request, response);			
			
			
			break;
			} //fin del case
			
		}else{
			response.sendRedirect("login.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		if(sesion.getAttribute("login")!=null){
			
			//System.out.println("CuotaList doPost");
			
			String accion = "";
			
			if (request.getAttribute("accion") != null){
				 accion = (String) request.getAttribute("accion");
			}else{
				 accion = (String) request.getParameter("accion");
			}
			
			//System.out.println("accion= " + accion);
			
			int año = 0;
			Grados grados = new Grados();
			
			switch(accion){			
			
			case "solicitarGrados":
			
			sesion.removeAttribute("gradoCuota");
			sesion.removeAttribute("turnoCuota");	
			//sesion.removeAttribute("añoCuota");
			sesion.removeAttribute("alumnos_cuota");
			
			//pago edit
			sesion.removeAttribute("pagoEdit");
			//pago edit
						
			año = Integer.parseInt(request.getParameter("año_cuotas"));			
									
			try {
				
				//obtiene los grados en condiciones de cobrar cuota, para el año seleccionado
				grados = AccionesGrado.getAñoGradosCuota(año);
				
				request.setAttribute("gradosCuota", grados);				
				request.setAttribute("añoCuota", año);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/menu_cuotas.jsp");
				dispatcher.forward(request, response);				
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			break;
			
			case "listarGrado":
				
			sesion.removeAttribute("año");
			sesion.removeAttribute("dni");
			sesion.removeAttribute("mes");
			sesion.removeAttribute("pagosMes");
				
			String string = "";
			String[] parts;
			String grado="", turno="";
			
			if(request.getParameter("anio") != null){
				año = Integer.parseInt(request.getParameter("anio"));
				string = request.getParameter("grado_anio");				
				parts = string.split(" - ");				
				grado = parts[0];
				turno = parts[1];
				
				sesion.setAttribute("gradoCuota",grado);
				sesion.setAttribute("turnoCuota",turno);	
				sesion.setAttribute("añoCuota",año);
				
				try {
					
					//obtiene los grados en condiciones de cobrar cuota, para el año seleccionado
					Alumnos alumnos = AccionesAlumno.getAllByGradoTurnoYAño(grado,turno,año);
					
					sesion.setAttribute("alumnos_cuota", alumnos);					
					
				} catch (Exception e) {				
					e.printStackTrace();
				}

			}
			
				
			//System.out.println("grado = " + grado + " turno = " + turno + " año= " + año);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/cuota_list.jsp");
			dispatcher.forward(request, response);			
			
			
			break;

			case "visualizarPagos":
				
			//System.out.println("visualizar pagos goPost");
			
			sesion.removeAttribute("pagoEdit");
			
			int dni = 0, mes = 0;
			
			if (request.getParameter("año") != null){ //se ingresa por primera vez
			
				año = Integer.parseInt(request.getParameter("año"));			
				dni = Integer.parseInt(request.getParameter("dni"));			
				mes = Integer.parseInt(request.getParameter("mes"));
				

				sesion.setAttribute("año", año);
				sesion.setAttribute("dni", dni);
				sesion.setAttribute("mes", mes);
				
				
				//System.out.println("año= " + año);
				//System.out.println("dni= " + dni);
				//System.out.println("mes= " + mes);			
				
				try {
					
					//obtiene los grados en condiciones de cobrar cuota, para el año seleccionado
					
					Cuotas cuotas = AccionesCuota.getPagosMes(dni, año, mes);
					
				    sesion.setAttribute("pagosMes", cuotas); //lo dejamos como session						
					
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
			}
			
			if (request.getAttribute("accion") != null){
				
				//sesion.removeAttribute("pagosMes");
				
				año = (Integer) sesion.getAttribute("año");			
				dni = (Integer) sesion.getAttribute("dni");			
				mes = (Integer) sesion.getAttribute("mes");
				
				try {
					
					//obtiene los grados en condiciones de cobrar cuota, para el año seleccionado
					
					Cuotas cuotas = AccionesCuota.getPagosMes(dni, año, mes);
					
				    sesion.setAttribute("pagosMes", cuotas); //lo dejamos como session						
					
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
			}
			
						
			dispatcher = getServletContext().getRequestDispatcher("/pagos_list.jsp");
			dispatcher.forward(request, response);			
			
			
			break;
			} //fin del case

			
		}else{
			response.sendRedirect("login.jsp");
		}
	}

}
