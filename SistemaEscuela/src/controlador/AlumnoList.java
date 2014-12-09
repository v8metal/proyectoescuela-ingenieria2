package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesAlumno;
import conexion.AccionesGrado;
import conexion.AccionesUsuario;
import datos.Alumnos;
import datos.Grado;
import datos.Grados;

/**
 * Servlet implementation class AlumnoList
 */
public class AlumnoList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AlumnoList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");						
		if (AccionesUsuario.validarAcceso(tipo, "AlumnoList") != 1){							
			response.sendRedirect("Login");						
		}
		
		String accion = "";
		
		if (request.getParameter("accion") != null){
			accion = (String) request.getParameter("accion");
		}else{
			accion = (String) request.getAttribute("accion");
		}
		
		//System.out.println("accion doGet = " + accion);
		
		switch(accion){			

		case "solicitarGrados":
			
			if (AccionesUsuario.validarAcceso(tipo, "menu_alumnos.jsp") != 1){							
				response.sendRedirect("Login");						
			}
			
			sesion.removeAttribute("gradosAlumno");
			sesion.removeAttribute("a�oAlumno");
			sesion.removeAttribute("turno_alumno");
						
			int a�o = Integer.parseInt(request.getParameter("a�o_alumno"));			
									
			try {
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesGrado") != 1){							
					response.sendRedirect("Login");						
				}
				
				//Grados grados = AccionesGrado.getA�oGradosCuota(a�o);
				Grados grados = AccionesGrado.getAll();
				
				sesion.setAttribute("grados_alta", grados);
				
				request.setAttribute("gradosAlumno", grados);				
				request.setAttribute("a�oAlumno", a�o);
								
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/menu_alumnos.jsp");
				dispatcher.forward(request, response);				
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			break;
			
		case "listarAlumnos":
			
			sesion.removeAttribute("tutor");
			
			if (AccionesUsuario.validarAcceso(tipo, "alumno_list.jsp") != 1){							
				response.sendRedirect("Login");						
			}
			
			String string = "";
			String[] parts;
			String grado="", turno="";
			
			
			if (sesion.getAttribute("a�oAlumno") == null){
				a�o = (Integer) sesion.getAttribute("a�o_ing"); 
				sesion.setAttribute("a�oAlumno", a�o);
			}else{
				a�o = (Integer) sesion.getAttribute("a�oAlumno");				
			}
			
			Grado g = null;
			
			if(request.getParameter("grado_turno") != null){
				
				string = request.getParameter("grado_turno");				
				parts = string.split(" - ");				
				grado = parts[0];
				turno = parts[1];
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesGrado") != 1){							
					response.sendRedirect("Login");						
				}
				
				sesion.setAttribute("gradoAlumno", AccionesGrado.getOne(grado, turno));
			
			}else{
				
				 g = (Grado) sesion.getAttribute("gradoAlumno");
				 
				 grado = g.getGrado();
				 turno = g.getTurno();
				
			}	
			
			sesion.setAttribute("grado_alumno",grado);
			sesion.setAttribute("turno_alumno",turno);
			
			sesion.setAttribute("titulo_alumno",  grado + " " + turno + " - " + a�o);
						
			try {
					
				if (AccionesUsuario.validarAcceso(tipo, "AccionesAlumno") != 1){							
					response.sendRedirect("Login");						
				}
				
				Alumnos alumnos = AccionesAlumno.getAllByGradoTurnoYA�o(grado, turno, a�o);					
				sesion.setAttribute("alumnos_alumno", alumnos);					
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/alumno_list.jsp");
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
		if (AccionesUsuario.validarAcceso(tipo, "AlumnoList") != 1){							
			response.sendRedirect("Login");						
		}
		
		String accion = "";
		
		if (request.getParameter("accion") != null){
			accion = (String) request.getParameter("accion");
		}else{
			accion = (String) request.getAttribute("accion");
		}
		
		//System.out.println("accion doPost = " + accion);
		
		switch(accion){			

		case "solicitarGrados":
			
			if (AccionesUsuario.validarAcceso(tipo, "menu_alumnos.jsp") != 1){							
				response.sendRedirect("Login");						
			}
			
			sesion.removeAttribute("gradosAlumno");
			sesion.removeAttribute("a�oAlumno");
						
			int a�o = Integer.parseInt(request.getParameter("a�o_alumno"));			
									
			try {
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesGrado") != 1){							
					response.sendRedirect("Login");						
				}
				
				Grados grados = AccionesGrado.getA�oGradosCuota(a�o);
				
				request.setAttribute("gradosAlumno", grados);				
				request.setAttribute("a�oAlumno", a�o);
								
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/menu_alumnos.jsp");
				dispatcher.forward(request, response);				
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			break;
			
		case "listarAlumnos":
			
			sesion.removeAttribute("tutor");
			
			if (AccionesUsuario.validarAcceso(tipo, "alumno_list.jsp") != 1){							
				response.sendRedirect("Login");						
			}
			
			String string = "";
			String[] parts;
			String grado="", turno="";
			
			
			if (sesion.getAttribute("a�oAlumno") == null){
				a�o = (Integer) sesion.getAttribute("a�o_ing"); 
				sesion.setAttribute("a�oAlumno", a�o);
			}else{
				a�o = (Integer) sesion.getAttribute("a�oAlumno");				
			}
			
			Grado g = null;
			
			if(request.getParameter("grado_turno") != null){
				
				string = request.getParameter("grado_turno");				
				parts = string.split(" - ");				
				grado = parts[0];
				turno = parts[1];
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesGrado") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				sesion.setAttribute("gradoAlumno", AccionesGrado.getOne(grado, turno));
			
			}else{
				
				 g = (Grado) sesion.getAttribute("gradoAlumno");
				 
				 grado = g.getGrado();
				 turno = g.getTurno();
				
			}			
			
			sesion.setAttribute("grado_alumno",grado);
			sesion.setAttribute("turno_alumno",turno);
	
			sesion.setAttribute("titulo_alumno",  grado + " " + turno + " - " + a�o);
						
			try {
					
				if (AccionesUsuario.validarAcceso(tipo, "AccionesAlumno") != 1){							
					response.sendRedirect("Login");						
				}
				
				Alumnos alumnos = AccionesAlumno.getAllByGradoTurnoYA�o(grado, turno, a�o);
				
				sesion.setAttribute("alumnos_alumno", alumnos);					
				
			} catch (Exception e) {				
				e.printStackTrace();
			}			
			
									
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/alumno_list.jsp");
			dispatcher.forward(request, response);			
			
			
			break;
							
			} //fin del case	
	}

}