package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesGrado;
import conexion.AccionesTardanza;
import conexion.AccionesUsuario;
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
				
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "AsistenciaList") != 1){							
			response.sendRedirect("Login");
		}
			
		//System.out.println("Tardanzas doGet");
			
		String accion = "";
			
		if (request.getAttribute("accion") != null){
			 accion = (String) request.getAttribute("accion");
		}else{
			 accion = (String) request.getParameter("accion");
		}
			
		//System.out.println("accion= " + accion);
			
		int a�o = 0;
		Grados grados = new Grados();
			
		switch(accion){			
			
			case "solicitarGrados":
			
			if (AccionesUsuario.validarAcceso(tipo, "menu_asistencias.jsp") != 1){							
				response.sendRedirect("Login");
			}
			
			sesion.removeAttribute("gradosAsitencia");
			sesion.removeAttribute("a�oAsistencia");
			
			int dni_maestro = (Integer) sesion.getAttribute("dni_maestro"); //dni de la session
						
			a�o = Integer.parseInt(request.getParameter("a�o_asistencia"));			
									
			try {
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesGrado") != 1){							
					response.sendRedirect("Login");
				}
				
				//obtiene los grados en condiciones de cobrar cuota, para el a�o seleccionado
				grados = AccionesGrado.getA�oGradosByMaestro(a�o, dni_maestro);
				
				request.setAttribute("gradosAsistencia", grados);				
				request.setAttribute("a�oAsistencia", a�o);
								
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/menu_asistencias.jsp");
				dispatcher.forward(request, response);				
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			break;
			
			case "listarAsistencias":
			
			if (AccionesUsuario.validarAcceso(tipo, "asistencia_list.jsp") != 1){							
				response.sendRedirect("Login");
			}
				
			String string = "";
			String[] parts;
			String grado="", turno="";
			int dia = 0;
			String mes = "";
			String relleno="";
			String fecha ="";
			
			a�o = (Integer) sesion.getAttribute("a�oAsistencia");
			
						
			Grado g = null;
			
			if(request.getParameter("grado_anio") != null){
				
				//a�o = Integer.parseInt(request.getParameter("anio"));
				string = request.getParameter("grado_anio");				
				parts = string.split(" - ");				
				grado = parts[0];
				turno = parts[1];
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesGrado") != 1){							
					response.sendRedirect("Login");
				}
				
				sesion.setAttribute("gradoAltaAsistencia", AccionesGrado.getOne(grado, turno));
				
				dia = Integer.parseInt(request.getParameter("dia_asistencia"));
				mes = request.getParameter("mes_asistencia");	
				
				if (dia < 10) relleno ="0";
				
				fecha = a�o + "-" + mes + "-" + relleno + dia;
				
				sesion.setAttribute("fechaDisplayAsistencia", relleno + dia + "/" + mes + "/" + a�o);
				sesion.setAttribute("fechaAsistencia", fecha);
				
			}else{
				
				 g = (Grado) sesion.getAttribute("gradoAltaAsistencia");
				 
				 grado = g.getGrado();
				 turno = g.getTurno();
				 
				 fecha = (String) sesion.getAttribute("fechaAsistencia");
				
			}			
			
						
			try {
					
				if (AccionesUsuario.validarAcceso(tipo, "AccionesTardanza") != 1){							
					response.sendRedirect("Login");
				}
				
				//obtener las asistencias por dni para la fecha seleccionada para el grado, turno y a�o				
				Tardanzas tardanzas = AccionesTardanza.getAsistenciasByGradoFecha(grado, turno, fecha);					
				sesion.setAttribute("Asistencias", tardanzas);					
				
			} catch (Exception e) {				
				e.printStackTrace();
			}			
			
									
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/asistencia_list.jsp");
			dispatcher.forward(request, response);			
			
			
			break;
							
		} //fin del case
}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "AsistenciaList") != 1){							
			response.sendRedirect("Login");
		}
			
		//System.out.println("CuotaList doPost");
			
		String accion = "";
			
		if (request.getAttribute("accion") != null){
			 accion = (String) request.getAttribute("accion");
		}else{
			 accion = (String) request.getParameter("accion");
		}
			
		//System.out.println("accion= " + accion);
			
		int a�o = 0;
			
		switch(accion){
			
			case "listarAsistencias":
				
			if (AccionesUsuario.validarAcceso(tipo, "asistencia_list.jsp") != 1){							
				response.sendRedirect("Login");
			}
				
			String string = "";
			String[] parts;
			String grado="", turno="";
			int dia = 0;
			String mes = "";
			String relleno="";
			String fecha ="";
			
			a�o = (Integer) sesion.getAttribute("a�oAsistencia");
									
			Grado g = null;
			
			if(request.getParameter("grado_anio") != null){
				
				//a�o = Integer.parseInt(request.getParameter("anio"));
				string = request.getParameter("grado_anio");				
				parts = string.split(" - ");				
				grado = parts[0];
				turno = parts[1];
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesGrado") != 1){							
					response.sendRedirect("Login");
				}
				
				sesion.setAttribute("gradoAltaAsistencia", AccionesGrado.getOne(grado, turno));
				
				dia = Integer.parseInt(request.getParameter("dia_asistencia"));
				mes = request.getParameter("mes_asistencia");	
				
				if (dia < 10) relleno ="0";
				
				fecha = a�o + "-" + mes + "-" + relleno + dia;
				
				sesion.setAttribute("fechaDisplayAsistencia", relleno + dia + "/" + mes + "/" + a�o);
				sesion.setAttribute("fechaAsistencia", fecha);
					
				
				
			}else{
				
				 g = (Grado) sesion.getAttribute("gradoAltaAsistencia");
				 
				 grado = g.getGrado();
				 turno = g.getTurno();
				 
				 fecha = (String) sesion.getAttribute("fechaAsistencia");
				
			}			
			
						
			try {
					
				if (AccionesUsuario.validarAcceso(tipo, "AccionesTardanza") != 1){							
					response.sendRedirect("Login");
				}
				
				//obtener las asistencias por dni para la fecha seleccionada para el grado, turno y a�o				
				Tardanzas tardanzas = AccionesTardanza.getAsistenciasByGradoFecha(grado, turno, fecha);					
				sesion.setAttribute("Asistencias", tardanzas);					
				
			} catch (Exception e) {				
				e.printStackTrace();
			}			
			
									
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/asistencia_list.jsp");
			dispatcher.forward(request, response);			
			
			
			break;

		} //fin del case
	
	}

}
