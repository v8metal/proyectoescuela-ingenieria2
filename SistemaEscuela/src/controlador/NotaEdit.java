package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesNota;
import conexion.AccionesUsuario;

import datos.Materia;
import datos.Materias;
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
		
		try {
			
			// recupero los atributos para seleccionar la nota
			String grado  = (String)sesion.getAttribute("grado");
			String turno = (String)sesion.getAttribute("turno");
			int año = Integer.parseInt((String)sesion.getAttribute("año_sys"));
			int dni = Integer.parseInt((String)sesion.getAttribute("dni_alum"));
			String periodo = (String)sesion.getAttribute("periodo");
			
			int cod_materia = Integer.parseInt(request.getParameter("cod_materia"));
			sesion.setAttribute("cod_materia", cod_materia);
				
	/*		response.setContentType("text/html");
		    PrintWriter out= response.getWriter();
		    out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 3.2//EN\">"
		            + "<HTML>" + "<HEAD>"
		            + " <TITLE>" + "PROBANDO" + "</TITLE>"
		            + "</HEAD>"  + "<BODY>"
		            + "cod_materia = " + cod_materia
		    		); 					            					          					       		
			out.println("</BODY>" + "</HTML>");
		    out.close();				*/

			if (AccionesNota.estaCargada(grado, turno, año, dni, cod_materia, periodo)) {
				Nota n = AccionesNota.getOne(grado, turno, año, dni, cod_materia, periodo);
				int calific = n.getCalific();
				
				sesion.setAttribute("calific", calific);
			} else {
				sesion.setAttribute("calific", 0);
			}
			
			response.sendRedirect("nota_edit.jsp");
	
		} catch (Exception e) {
			e.printStackTrace();
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
