package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesAlumno;
import conexion.AccionesCertificado;
import conexion.AccionesEstado;
import conexion.AccionesGrado;
import conexion.AccionesPadre;
import datos.Alumno;
import datos.Padre;

/**
 * Servlet implementation class AlumnoEdit
 */
public class AlumnoEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AlumnoEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get session of the request
		HttpSession sesion = request.getSession();
		
		try {
			
			//get parameter do of the request
			String accion = request.getParameter("do");			    
			
			//get dnis of the request
			Integer dni_tutor = null;
			Integer dni_madre = null;
			Integer dni_alum = null;
			if(request.getParameter("dni_tutor") != null) {
				dni_tutor = Integer.valueOf(request.getParameter("dni_tutor"));
			}			
			if(request.getParameter("dni_madre") != null) {
				dni_madre = Integer.valueOf(request.getParameter("dni_madre"));
			}				
			if(request.getParameter("dni_alum") != null) {
				dni_alum = Integer.valueOf(request.getParameter("dni_alum"));
			}				
				
			//add / edit
			if(accion.equals("alta")){	//nunca entra en este if, directamente entra al post cuando se da de alta
				
				//get the request dispatcher
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/alumno_edit.jsp");
				
				//forward to the jsp file to display the alumno list
				dispatcher.forward(request, response);	
			
			}  else if(accion.equals("modificar")){
	
				//get the tutor from simulated DB
				Padre tutor = new Padre();
				if(dni_tutor != null){
					tutor = AccionesPadre.getOne(dni_tutor.intValue());
				}
				//get the madre from simulated DB
				Padre madre = new Padre();
				if(dni_madre != null){
					madre = AccionesPadre.getOne(dni_madre.intValue());
				}
				//get the alumno from simulated DB
				Alumno alumno = new Alumno();
				if(dni_alum != null){
					alumno = AccionesAlumno.getOne(dni_alum.intValue());
				}

				//set the tutor object in the request
				request.setAttribute("tutor", tutor);
				//set the madre object in the request
				request.setAttribute("madre", madre);
				//set the alumno object in the request
				request.setAttribute("alumno", alumno);  
				
				//get the request dispatcher
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/alumno_edit.jsp");
				
				//forward to the jsp file to display the alumno list
				dispatcher.forward(request, response);	
				
		 
			//delete
			} else if(accion.equals("baja")){
				
	/*			//delete alumno by dni
				AccionesCertificado.deleteObservaciones(dni_alum.intValue());
				AccionesCertificado.deleteOne(dni_alum.intValue());
				AccionesAlumno.deleteAlumnoFromGrado(dni_alum.intValue());
				AccionesEstado.deleteEstado(dni_alum.intValue());
				AccionesAlumno.deleteOne(dni_alum.intValue());				*/
				
				// baja logica
				
				//recupero de la sesion la fecha del sistema
				String año_sys = (String)sesion.getAttribute("año_sys");
				String mes_sys = (String)sesion.getAttribute("mes_sys");
				String dia_sys = (String)sesion.getAttribute("dia_sys");
				String fecha_sys = año_sys + "-" + mes_sys + "-" + dia_sys;
				
				AccionesEstado.desactivarAlumno(dni_alum, fecha_sys);
				
				//redirect to the alumno list servlet 
				response.sendRedirect(request.getContextPath() + "/alumnoList");

			} 
			
		} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
			sesion.setAttribute("error", "Se ha producido un error. No se puede activar y dar de baja a un alumno el mismo dia." + "<br><br>" + "Exception:" + "<br>" + e.toString());
			response.sendRedirect("alumno_list.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();

			sesion.setAttribute("error", e.toString());
			response.sendRedirect("alumno_edit.jsp");
		}  
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get session of the request
		HttpSession sesion = request.getSession();
			
		try {
			
			//get dni_alum properties from the request
			int dni_alum = Integer.parseInt(request.getParameter("dni_alum"));
						
			// DATOS ALUMNO
			String apellido_alum = request.getParameter("apellido_alum");
			String nombre_alum = request.getParameter("nombre_alum");
			String lugar_nac_alum = request.getParameter("lugar_nac_alum");				
			// Recupero el dia, mes y año por separado
			String dia_nac_alum = request.getParameter("dia_nac_alum");
			String mes_nac_alum = request.getParameter("mes_nac_alum"); 
			String año_nac_alum = request.getParameter("año_nac_alum"); 			
			// Luego los uno como String en el formato aceptado por MySQL (YYYY-MM-DD)
			String fecha_nac_alum = año_nac_alum + "-" + mes_nac_alum + "-" + dia_nac_alum;		
			String domicilio_alum = request.getParameter("domicilio_alum");
			String telefono_alum = request.getParameter("telefono_alum");
			String esc = request.getParameter("esc");
			String ind_grupo = request.getParameter("ind_grupo");
			String ind_subsidio = request.getParameter("ind_subsidio");
	
			//DATOS PADRE O TUTOR
			String apellido_tutor = request.getParameter("apellido_tutor");
			String nombre_tutor = request.getParameter("nombre_tutor");
			String lugar_nac_tutor = request.getParameter("lugar_nac_tutor");		
			String dia_nac_tutor = request.getParameter("dia_nac_tutor");
			String mes_nac_tutor = request.getParameter("mes_nac_tutor"); 
			String año_nac_tutor = request.getParameter("año_nac_tutor"); 			
			String fecha_nac_tutor = año_nac_tutor + "-" + mes_nac_tutor + "-" + dia_nac_tutor;		
			
			String dni_tutor_st = request.getParameter("dni_tutor");
			// en caso de no pasar un dni, se le asigna un 0 (para solucionar el problema de la pk con la tabla padres)
			int dni_tutor = 0;
			//verifica que no se pase una cadena vacia
			if ((dni_tutor_st != null) && (!dni_tutor_st.equals(""))) {
				dni_tutor = Integer.parseInt(request.getParameter("dni_tutor"));
			}
			
			String domicilio_tutor = request.getParameter("domicilio_tutor");
			String telefono_tutor = request.getParameter("telefono_tutor");
			String ocupacion_tutor = request.getParameter("ocupacion_tutor");
			String dom_lab_tutor = request.getParameter("dom_lab_tutor");
			String telefono_lab_tutor = request.getParameter("telefono_lab_tutor");
			String est_civil_tutor = request.getParameter("est_civil_tutor");
									
			//DATOS MADRE
			String apellido_madre = request.getParameter("apellido_madre");
			String nombre_madre = request.getParameter("nombre_madre");
			String lugar_nac_madre = request.getParameter("lugar_nac_madre");		
			String dia_nac_madre = request.getParameter("dia_nac_madre");
			String mes_nac_madre = request.getParameter("mes_nac_madre"); 
			String año_nac_madre = request.getParameter("año_nac_madre"); 			
			String fecha_nac_madre = año_nac_madre + "-" + mes_nac_madre + "-" + dia_nac_madre;	
			
			String dni_madre_st = request.getParameter("dni_madre");
			// en caso de no pasar un dni, se le asigna un 0 (para solucionar el problema de la pk con la tabla padres)
			int dni_madre = 0;
			// verifica que no se pase una cadena vacia
			if ((dni_madre_st != null) && (!dni_madre_st.equals(""))) {
				dni_madre = Integer.parseInt(request.getParameter("dni_madre"));
			}
			
			String domicilio_madre = request.getParameter("domicilio_madre");
			String telefono_madre = request.getParameter("telefono_madre");
			String ocupacion_madre = request.getParameter("ocupacion_madre");
			String dom_lab_madre = request.getParameter("dom_lab_madre");
			String telefono_lab_madre = request.getParameter("telefono_lab_madre");
			String est_civil_madre = request.getParameter("est_civil_madre");
				
			//HERMANOS
			int cant_her_may = Integer.parseInt(request.getParameter("cant_her_may"));
			int cant_her_men = Integer.parseInt(request.getParameter("cant_her_men"));
						
			//IGLESIA
			String iglesia = request.getParameter("iglesia");
			
			//create a new padre object		
			Padre tutor = new Padre(dni_tutor, nombre_tutor, apellido_tutor, lugar_nac_tutor,
					fecha_nac_tutor, domicilio_tutor, telefono_tutor, ocupacion_tutor, dom_lab_tutor,
					telefono_lab_tutor, est_civil_tutor);
			//create a new padre(madre) object
			Padre madre = new Padre(dni_madre, nombre_madre, apellido_madre, lugar_nac_madre,
					fecha_nac_madre, domicilio_madre, telefono_madre, ocupacion_madre, dom_lab_madre,
					telefono_lab_madre, est_civil_madre);
			//create a new alumno object
			Alumno alumno = new Alumno(dni_alum, nombre_alum, apellido_alum, domicilio_alum, telefono_alum, 
					fecha_nac_alum, lugar_nac_alum, dni_tutor, dni_madre, cant_her_may,
					cant_her_men, iglesia, esc, ind_grupo.equals("si"),
					ind_subsidio.equals("si"));		
					
			//save the alumno to DB
			if (!AccionesAlumno.esAlumno(dni_alum)){	//Si no esta en el sistema los datos del alumno. Es un insert
				
				//INGRESO
				String dia_insc = request.getParameter("dia_insc");
				String mes_insc = request.getParameter("mes_insc"); 
				String año_insc = request.getParameter("año_insc");
				String fecha_insc = año_insc + "-" + mes_insc + "-" + dia_insc;
			
				
				//GRADO Y TURNO AL QUE VA A INGRESAR Y AÑO ESCOLAR
				String grado = request.getParameter("grado");
				String turno = request.getParameter("turno");
				String año_ing = request.getParameter("año_ing");
				
				//insert tutor
				if (!AccionesPadre.esPadre(dni_tutor)) {	//Si no esta en el sistema los datos del tutor lo inserta. Si ya estan sus datos no hace nada.
					AccionesPadre.insertOne(tutor);
				}
				//insert madre
				if (!AccionesPadre.esPadre(dni_madre)) {	//Lo mismo con la madre.
					AccionesPadre.insertOne(madre);
				}
				//insert alumno	 
				AccionesAlumno.insertOne(alumno);
				//lo activo
				AccionesEstado.activarAlumno(dni_alum, fecha_insc);
				//creo su lista de certificados (todos como false como valor por defecto)
				AccionesCertificado.insertOne(alumno.getDni());
				//y le asigno un grado
				AccionesGrado.insertAlumnoEnGrado(grado, turno, dni_alum, Integer.parseInt(año_ing));
				
				//seteo el grado en la sesion asi me redirecciona a la lista del curso al que se inscribio
				sesion.setAttribute("grado", grado);
				sesion.setAttribute("turno", turno);
				sesion.setAttribute("año", año_ing);
										
			} else {	//Si ya estan los datos del alumno, que lo modifique
				//update tutor
				AccionesPadre.updateOne(dni_tutor, nombre_tutor, apellido_tutor, lugar_nac_tutor, fecha_nac_tutor,
						domicilio_tutor, telefono_tutor, ocupacion_tutor, dom_lab_tutor, telefono_lab_tutor, est_civil_tutor);
				//update madre
				AccionesPadre.updateOne(dni_madre, nombre_madre, apellido_madre, lugar_nac_madre, fecha_nac_madre,
						domicilio_madre, telefono_madre, ocupacion_madre, dom_lab_madre, telefono_lab_madre, est_civil_madre);
				//update alumno
				AccionesAlumno.updateOne(dni_alum, nombre_alum, apellido_alum, domicilio_alum, telefono_alum,
						fecha_nac_alum, lugar_nac_alum, dni_tutor, dni_madre, cant_her_may, cant_her_men,
						iglesia, esc, ind_grupo.equals("si"), ind_subsidio.equals("si"));
			}   
			
			//redirect to the alumno list servlet
			response.sendRedirect(request.getContextPath() + "/alumnoList");	
			
		} catch (java.lang.NumberFormatException e) {
			e.printStackTrace();
			sesion.setAttribute("error", "Se ha producido un error. Debe completar todos los campos del alumno para poder registrarlo. Exception: " + e.toString());
			response.sendRedirect("alumno_edit.jsp");
			
		} catch (java.lang.NullPointerException e) {
			e.printStackTrace();
			sesion.setAttribute("error", "Se ha producido un error. Debe completar los campos \"Escolaridad\", \"Grupo Familiar\" y \"Subsidio\". Exception: " + e.toString());
			response.sendRedirect("alumno_edit.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			sesion.setAttribute("error", e.toString());
			response.sendRedirect("alumno_edit.jsp");
		}
			
	}
	
}
