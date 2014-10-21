package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesEntrevista;
import conexion.AccionesGrado;
import conexion.AccionesTardanza;
import datos.Entrevistas;
import datos.Grado;
import datos.Grados;
import datos.Tardanzas;

/**
 * Servlet implementation class AsistenciaList
 */
public class AsistenciaList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AsistenciaList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
						
		
		if(sesion.getAttribute("usuario") != null){
			
			//System.out.println("Tardanzas doGet");
			
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
			
			sesion.removeAttribute("gradosTardanza");
			sesion.removeAttribute("añoTardanza");
						
			año = Integer.parseInt(request.getParameter("año_tardanza"));			
									
			try {
				
				//obtiene los grados en condiciones de cobrar cuota, para el año seleccionado
				grados = AccionesGrado.getAñoGradosCuota(año);
				
				request.setAttribute("gradosTardanza", grados);				
				request.setAttribute("añoTardanza", año);
								
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/menu_tardanzas.jsp");
				dispatcher.forward(request, response);				
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			break;
			
			case "listarTardanzas":
				
			String string = "";
			String[] parts;
			String grado="", turno="";
			
			
			año = (Integer) sesion.getAttribute("añoTardanza");
			
			Grado g = null;
			
			if(request.getParameter("grado_anio") != null){
				
				//año = Integer.parseInt(request.getParameter("anio"));
				string = request.getParameter("grado_anio");				
				parts = string.split(" - ");				
				grado = parts[0];
				turno = parts[1];
				
				sesion.setAttribute("gradoAltaTardanza", AccionesGrado.getOne(grado, turno));
			
			}else{
				
				 g = (Grado) sesion.getAttribute("gradoAltaTardanza");
				 
				 grado = g.getGrado();
				 turno = g.getTurno();
				
			}			
			
						
			try {
					
					//obtiene los grados en condiciones de cobrar cuota, para el año seleccionado
				Tardanzas tardanzas = AccionesTardanza.getAllTardanzas(grado, turno, año);					
				sesion.setAttribute("tardanzas", tardanzas);					
				
			} catch (Exception e) {				
				e.printStackTrace();
			}			
			
									
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/tardanza_list.jsp");
			dispatcher.forward(request, response);			
			
			
			break;
							
			} //fin del case
			
		}else{
			response.sendRedirect("login.jsp");
		}	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		if(sesion.getAttribute("usuario")!=null){
			
			//System.out.println("CuotaList doPost");
			
			String accion = "";
			
			if (request.getAttribute("accion") != null){
				 accion = (String) request.getAttribute("accion");
			}else{
				 accion = (String) request.getParameter("accion");
			}
			
			//System.out.println("accion= " + accion);
			
			int año = 0;
			
			switch(accion){
			
				case "listarTardanzas": //este se usa luego del alta
			
				String string = "";
				String[] parts;
				String grado="", turno="";
				
				
				año = (Integer) sesion.getAttribute("añoTardanza");
				
				Grado g = null;
				
				if(request.getParameter("grado_anio") != null){
					
					string = request.getParameter("grado_anio");				
					parts = string.split(" - ");				
					grado = parts[0];
					turno = parts[1];
					
					sesion.setAttribute("gradoAltaTardanza", AccionesGrado.getOne(grado, turno));
				}else{
					
					 g = (Grado) sesion.getAttribute("gradoAltaTardanza");
					 
					 grado = g.getGrado();
					 turno = g.getTurno();
					
				}	
				
							
				try {
										
					Tardanzas tardanzas = AccionesTardanza.getAllTardanzas(grado, turno, año);					
					sesion.setAttribute("tardanzas", tardanzas);					
					
				} catch (Exception e) {				
					e.printStackTrace();
				}			
				
										
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/tardanza_list.jsp");
				dispatcher.forward(request, response);			
				
				
				break;

		} //fin del case

			
		}else{
			response.sendRedirect("login.jsp");
		}
		
	}

}
