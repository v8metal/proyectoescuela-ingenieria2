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
import conexion.AccionesMaestro;
import conexion.AccionesNota;
import conexion.AccionesUsuario;
import datos.Alumnos;
import datos.Grado;
import datos.Grados;
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
			
			if (AccionesUsuario.validarAcceso(tipo, "nota_lista_mat.jsp") != 1){							
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
				
				sesion.setAttribute("grado_notas", AccionesGrado.getOne(grado, turno));
			
			}else{
				
				 g = (Grado) sesion.getAttribute("grado_notas");
				 
				 grado = g.getGrado();
				 turno = g.getTurno();
				
			}			
			
						
			try {
					
				if (AccionesUsuario.validarAcceso(tipo, "AccionesAlumno") != 1){							
					response.sendRedirect("Login");						
				}
				
				Alumnos alumnos = AccionesAlumno.getAllByGradoTurnoYAño(grado, turno, año);
				MateriasGrado materias = AccionesGrado.getMateriasByGradoTurnoYAño(grado, turno, año);
				
				System.out.println("cant Materias= " + materias.getLista().size());
				
				sesion.setAttribute("alumnos_notas", alumnos);
				sesion.setAttribute("materias_notas", materias);
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			dispatcher = getServletContext().getRequestDispatcher("/nota_lista_mat.jsp");
			dispatcher.forward(request, response);
			
			break;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		
		try {
			
			// recupero los atributos para modificar la nota
			
			String grado  = (String)sesion.getAttribute("grado");
			String turno = (String)sesion.getAttribute("turno");
			int año = Integer.parseInt((String)sesion.getAttribute("año_sys"));
			int dni = Integer.parseInt((String)sesion.getAttribute("dni_alum"));
			int cod_materia = (Integer)sesion.getAttribute("cod_materia");
			String periodo = (String)sesion.getAttribute("periodo");
			
			int calific = Integer.parseInt(request.getParameter("calific"));
	/*		
			response.setContentType("text/html");
		    PrintWriter out= response.getWriter();
		    out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 3.2//EN\">"
		            + "<HTML>" + "<HEAD>"
		            + " <TITLE>" + "PROBANDO" + "</TITLE>"
		            + "</HEAD>"  + "<BODY>"
		            + "calific = " + calific
		    		); 					            					          					       		
			out.println("</BODY>" + "</HTML>");
		    out.close();				
			*/
			
			if (AccionesNota.estaCargada(grado, turno, año, dni, cod_materia, periodo)) {
				AccionesNota.updateOne(grado, turno, año, dni, cod_materia, periodo, calific);
			} else {
				Nota n = new Nota(grado, turno, año, dni, cod_materia, periodo, calific);
				AccionesNota.insertOne(n);
			}
			
			response.sendRedirect("nota_lista_mat.jsp");
					
		} catch (Exception e) {
			e.printStackTrace();
		}				
	}

}
