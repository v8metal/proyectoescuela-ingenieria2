package controlador;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesAlumno;
import conexion.AccionesGrado;
import conexion.AccionesMaestro;
import conexion.AccionesNota;
import conexion.AccionesUsuario;
import datos.Alumno;
import datos.Alumnos;
import datos.Grado;
import datos.Grados;
import datos.Informe;
import datos.MateriasGrado;
import datos.Nota;

/**
 * Servlet implementation class NotaEdit
 */
public class NotaEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NotaEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");						
		if (AccionesUsuario.validarAcceso(tipo, "NotaEdit") != 1){							
			response.sendRedirect("Login");						
		}
		
		String accion = "";
		
		if (request.getParameter("accion") != null){
			accion = (String) request.getParameter("accion");
		}else{
			accion = (String) request.getAttribute("accion");
		}
		
		//System.out.println("NotaEdit GET, Accion= " + accion);
		
		switch(accion){			

		case "solicitarGrados":
			
			if (AccionesUsuario.validarAcceso(tipo, "menu_notas.jsp") != 1){							
				response.sendRedirect("Login");						
			}
						
			int año  = Integer.parseInt(request.getParameter("año_notas"));			
			int dni = (Integer) sesion.getAttribute("dni_maestro");
			
			try {
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesMaestro") != 1){							
					response.sendRedirect("Login");						
				}
				
				Grados grados = AccionesMaestro.getGradosAño(dni, año);
			
				request.setAttribute("gradosNotas", grados);				
				request.setAttribute("añoNotas", año);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/menu_notas.jsp");
			dispatcher.forward(request, response);
						
			break;
			
		case "listarGrado":
			
			if (AccionesUsuario.validarAcceso(tipo, "nota_lista_alum.jsp") != 1){							
				response.sendRedirect("Login");						
			}
			
			año  = (Integer) sesion.getAttribute("añoNotas");
			
			String string = "";
			String[] parts;
			String grado="", turno="";
			
			Grado g = null;
			
			if(request.getParameter("grado_turno") != null){

				string = request.getParameter("grado_turno");				
				parts = string.split(" - ");				
				grado = parts[0];
				turno = parts[1];
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesGrado") != 1){							
					response.sendRedirect("Login");						
				}
				
				g = AccionesGrado.getOne(grado, turno);
							
			}else{
				
				 g = (Grado) sesion.getAttribute("grado_notas");
				 
				 grado = g.getGrado();
				 turno = g.getTurno();
				
			}			
			
			String redirect = "/nota_lista_alum.jsp";
			
			try {
					
				if (AccionesUsuario.validarAcceso(tipo, "AccionesAlumno") != 1){							
					response.sendRedirect("Login");						
				}
				
				Alumnos alumnos = AccionesAlumno.getAllByGradoTurnoYAño(grado, turno, año);
				
				if (g.getEvaluacion() == 0){									
					redirect = "/nota_lista_inf.jsp";
				}
				
				sesion.setAttribute("alumnos_notas", alumnos);
				sesion.setAttribute("grado_notas", g);				
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			dispatcher = getServletContext().getRequestDispatcher(redirect);
			dispatcher.forward(request, response);
			
			break;
			
		case "listarMaterias":
			
			if (AccionesUsuario.validarAcceso(tipo, "nota_lista_mat.jsp") != 1){							
				response.sendRedirect("Login");						
			}
			
			año = (Integer) sesion.getAttribute("añoNotas");			
			dni = Integer.parseInt(request.getParameter("dni_nota"));
			
			g = (Grado) sesion.getAttribute("grado_notas");
			
			if (AccionesUsuario.validarAcceso(tipo, "AccionesGrado") != 1){							
				response.sendRedirect("Login");						
			}
			
			MateriasGrado materias = AccionesGrado.getMateriasByGradoTurnoYAño(g.getGrado(), g.getTurno(), año);			
			sesion.setAttribute("materias_notas", materias);
			
			if (AccionesUsuario.validarAcceso(tipo, "AccionesAlumno") != 1){							
				response.sendRedirect("Login");						
			}
			
			Alumno alumno = null;
			
			try {
				
				alumno = AccionesAlumno.getOneAlumno(dni);
				sesion.setAttribute("alumno_notas", alumno);
				
			} catch (Exception e1) {
				e1.printStackTrace();
			}			
			
			dispatcher = getServletContext().getRequestDispatcher("/nota_lista_mat.jsp");
			dispatcher.forward(request, response);
			
			break;
			
		case "editarNota":
			
			if (AccionesUsuario.validarAcceso(tipo, "nota_edit.jsp") != 1){							
				response.sendRedirect("Login");						
			}
			
			año = (Integer) sesion.getAttribute("añoNotas");			
			dni = Integer.parseInt(request.getParameter("dni_nota"));
			String materia = request.getParameter("materia");
			String periodo = request.getParameter("periodo");
			
			g = (Grado) sesion.getAttribute("grado_notas");
			
			Nota nota;
			
			try {
				
				nota = new Nota(g.getGrado(), g.getTurno(), año, dni, materia, periodo, AccionesNota.getCalific(año, dni, materia, periodo));
				
				sesion.setAttribute("nota_edit", nota);
			
			} catch (SQLException e1) {
				e1.printStackTrace();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
						
			dispatcher = getServletContext().getRequestDispatcher("/nota_edit.jsp");
			dispatcher.forward(request, response);
			
			break;
			
		case "editarInforme":
			
			if (AccionesUsuario.validarAcceso(tipo, "informe_edit.jsp") != 1){							
				response.sendRedirect("Login");						
			}
			
			año  = (Integer) sesion.getAttribute("añoNotas");			
			dni = Integer.parseInt(request.getParameter("dni_inf"));
			int numero = Integer.parseInt(request.getParameter("informe"));
			g = (Grado) sesion.getAttribute("grado_notas");
						
			try {
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesAlumno") != 1){							
					response.sendRedirect("Login");						
				}
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesNota") != 1){							
					response.sendRedirect("Login");						
				}
				
				alumno = AccionesAlumno.getOne(dni);
				Informe inf = AccionesNota.getInforme(año, dni);
				
				String informe = null;
				
				switch(numero){
					
					case 1:
						
						informe = inf.getMarzo();
						
						break;
						
					case 2:
						
						informe = inf.getMitad();
						break;
						
					case 3:
						
						informe = inf.getFin();
						break;
						
				}
				
				if (informe != null){
					request.setAttribute("informe", informe);
				}
				
				sesion.setAttribute("numero_inf", numero);
				sesion.setAttribute("alumno_inf", alumno);				
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			dispatcher = getServletContext().getRequestDispatcher("/informe_edit.jsp");
			dispatcher.forward(request, response);
			
			break;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");						
		if (AccionesUsuario.validarAcceso(tipo, "NotaEdit") != 1){							
			response.sendRedirect("Login");						
		}
		
		String accion = "";
		
		if (request.getParameter("do") != null){
			accion = (String) request.getParameter("do");
		}else{
			accion = (String) request.getAttribute("accion");
		}
		
		int año = (Integer) sesion.getAttribute("añoNotas"); //año seleccionado en el menú
		Grado grado = (Grado) sesion.getAttribute("grado_notas");
		
		//System.out.println("NotaEdit POST, Accion= " + accion);
		
		switch(accion){			
		
		case "editarNota":
			
			if (AccionesUsuario.validarAcceso(tipo, "AccionesNota") != 1){							
				response.sendRedirect("Login");						
			}
			
			if (AccionesUsuario.validarAcceso(tipo, "nota_lista_mat.jsp") != 1){							
				response.sendRedirect("Login");						
			}
			
			Nota nota = (Nota) sesion.getAttribute("nota_edit");
			String calific = request.getParameter("calificacion");
			
			nota.setCalific(calific);
			
			try {
				
				if(AccionesNota.estaCargada(nota)){
					
					AccionesNota.updateNota(nota);
					
				}else{
					
					AccionesNota.insertNota(nota);
				}
				
			} catch (SQLException e1) {
				e1.printStackTrace();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/nota_lista_mat.jsp");
			dispatcher.forward(request, response);
			
			break;
			
		case "altaInforme":
		case "modificarInforme":
			
			if (AccionesUsuario.validarAcceso(tipo, "nota_lista_inf.jsp") != 1){							
				response.sendRedirect("Login");						
			}
			
			String informe = request.getParameter("desc_informe");
			int numero = (Integer) sesion.getAttribute("numero_inf"); //número de informe (1,2,3)
			Alumno alumno = (Alumno) sesion.getAttribute("alumno_inf");
			
			Informe inf = null;
			
			switch(numero){
			
			case 1:				
				inf = new Informe(grado.getGrado(), grado.getTurno(), año, alumno.getDni(),informe, "", "");
				break;
			case 2:				
				inf = new Informe(grado.getGrado(), grado.getTurno(), año, alumno.getDni(), "", informe, "");
				break;
			case 3:				
				inf = new Informe(grado.getGrado(), grado.getTurno(), año, alumno.getDni(), "", "", informe);
				break;
			}
			
			try {
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesNota") != 1){							
					response.sendRedirect("Login");						
				}
				
				if (accion.equals("altaInforme")){	
					
					AccionesNota.insertInforme(inf);
				}else{
					
					AccionesNota.updateInforme(inf, numero);
				}
					
				} catch (SQLException e) {
					e.printStackTrace();
				} catch (Exception e) {					
					e.printStackTrace();
				}
								
			dispatcher = getServletContext().getRequestDispatcher("/nota_lista_inf.jsp");
			dispatcher.forward(request, response);
			
			break;			
			
		}
		
	}

}
