package controlador;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import conexion.AccionesAlumno;
import conexion.AccionesCertificado;
import datos.*;

/**
 * Servlet implementation class CertificadoEdit
 */
public class CertificadoEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CertificadoEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		
		String from = request.getParameter("from"); 	// nombre de la pagina que llamo al servlet(este param solo se manda desde "nota_menu")	
		if (from == null) {	
			from = 	"otro_lado";
		}

		try {
			
			String accion = request.getParameter("do");
			//recupero el año lectivo seleccionado desde la sesion
			int año = Integer.parseInt((String)sesion.getAttribute("año"));
					
			if (accion.equals("modificar")) {
				
				int dni = Integer.parseInt(request.getParameter("dni"));
				
				// recuperando el dni obtengo el alumno y su lista de certificados con las observaciones correspondiente
				Alumno alumno = AccionesAlumno.getOne(dni);
				Certificado certificado = AccionesCertificado.getOneByDniYAño(dni, año);
				Observaciones observaciones = AccionesCertificado.getObservacionesByDniYAño(dni, año);
		
				// luego los seteo en la sesion
				sesion.setAttribute("alumno", alumno);
				sesion.setAttribute("certificado", certificado);  
				sesion.setAttribute("observaciones", observaciones);
				
				if (from.equals("certificado_list")) {		
					response.sendRedirect("obs.jsp");
				} else if (from.equals("otro_lado")){
					response.sendRedirect("certificado_edit.jsp");
				}
				
				// por ultimo redirecciono a la pagina para editar la lista de certificados
//				response.sendRedirect("certificado_edit.jsp");				

			} else if (accion.equals("eliminar")) {
				
				String obs = (String)request.getParameter("obs");
				Alumno a = (Alumno)sesion.getAttribute("alumno");
				
				AccionesCertificado.deleteObservacion(a.getDni(), año, obs);
				
				if (from.equals("obs")) {		
					response.sendRedirect("certificadoEdit?from=certificado_list&do=modificar&dni=" + a.getDni());
				} else if (from.equals("otro_lado")){
					response.sendRedirect("certificado_list.jsp");
				}
				
//				response.sendRedirect("certificado_list.jsp");
			}	
			
		} catch (Exception e) {
			e.printStackTrace();
			sesion.setAttribute("error", e);
			response.sendRedirect("certificado_edit.jsp");
		}						
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		
		String from = request.getParameter("from"); 	// nombre de la pagina que llamo al servlet(este param solo se manda desde "nota_menu")	
		if (from == null) {	
			from = 	"otro_lado";
		}
/*		
		response.setContentType("text/html");
		PrintWriter out= response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 3.2//EN\">"
		            + "<HTML>" + "<HEAD>"
		            + " <TITLE>" + "PROBANDO" + "</TITLE>"
		            + "</HEAD>"  + "<BODY>"
		            + "<br>" + "from: " + from
				 );                              
		out.println("</BODY>" + "</HTML>");
		out.close();				*/
		
		try {
			
			//recupero el alumno a modificar desde la sesion
			Alumno a = (Alumno)sesion.getAttribute("alumno");
			//recupero el año lectivo seleccionado desde la sesion
			int año = Integer.parseInt((String)sesion.getAttribute("año"));
			
			if (from.equals("obs")) {
				
				//recupero de la sesion la fecha del sistema
				String año_sys = (String)sesion.getAttribute("año_sys");
				String mes_sys = (String)sesion.getAttribute("mes_sys");
				String dia_sys = (String)sesion.getAttribute("dia_sys");
				String fecha_sys = año_sys + "/" + mes_sys + "/" + dia_sys + ": ";

				//recupero la nueva observacion
				String obsnueva = request.getParameter("obs_nueva");
				String obs_nueva = fecha_sys + obsnueva;
				//creo el nuevo objecto observacion
				Observacion o = new Observacion(a.getDni(), año, obs_nueva);
				
				//verifica que no se pase una cadena vacia
				if ((o.getObservaciones() != null) && (!o.getObservaciones().equals(" "))) {
					//si no existe la observacion en ese año y en ese alumno, que la ingrese
					if (!AccionesCertificado.esObservacion(o)) {	
						if (!o.getObservaciones().equals("Escriba nueva observación")) {
							AccionesCertificado.insertObservacion(o);
						}
					}
				}
				
				response.sendRedirect("certificadoEdit?from=certificado_list&do=modificar&dni=" + a.getDni());
				
			} else if (from.equals("otro_lado")){
			
			Boolean ind_salud = Boolean.valueOf(request.getParameter("ind_salud"));
			Boolean ind_bucal = Boolean.valueOf(request.getParameter("ind_bucal"));
			Boolean ind_dni = Boolean.valueOf(request.getParameter("ind_dni"));
			Boolean ind_auditivo = Boolean.valueOf(request.getParameter("ind_auditivo"));
			Boolean ind_visual = Boolean.valueOf(request.getParameter("ind_visual"));
			Boolean ind_vacunas = Boolean.valueOf(request.getParameter("ind_vacunas"));
			
			//modifico la lista de certificados a partir del dni del alumno obtenido y los valores actualizados de los certificados
			AccionesCertificado.updateOne(a.getDni(), ind_salud.booleanValue(), ind_bucal.booleanValue(), ind_dni.booleanValue(), ind_auditivo.booleanValue(), 
												ind_visual.booleanValue(), ind_vacunas.booleanValue(), año);
			
			response.sendRedirect("alumno_list.jsp");
			
			}

		//	response.sendRedirect("alumno_list.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			sesion.setAttribute("error", e);
			response.sendRedirect("certificado_edit.jsp");
		}		
		
	}

}
