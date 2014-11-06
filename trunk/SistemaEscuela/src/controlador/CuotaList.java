package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesUsuario;
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
						
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");			
		if (AccionesUsuario.validarAcceso(tipo, "CuotaList") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
			
		//System.out.println("CuotaList doGet");
			
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
			
			if (AccionesUsuario.validarAcceso(tipo, "menu_cuotas.jsp") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			sesion.removeAttribute("gradoCuota");
			sesion.removeAttribute("turnoCuota");	
			//sesion.removeAttribute("a�oCuota");
			sesion.removeAttribute("alumnos_cuota");
						
			a�o = Integer.parseInt(request.getParameter("a�o_cuotas"));			
									
			try {
		
				if (AccionesUsuario.validarAcceso(tipo, "AccionesGrado") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				//obtiene los grados en condiciones de cobrar cuota, para el a�o seleccionado
				grados = AccionesGrado.getA�oGradosCuota(a�o);
				
				request.setAttribute("gradosCuota", grados);				
				request.setAttribute("a�oCuota", a�o);
										
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/menu_cuotas.jsp");
				dispatcher.forward(request, response);				
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			break;
			
			case "listarGrado":
			
			if (AccionesUsuario.validarAcceso(tipo, "cuota_list.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			sesion.removeAttribute("a�o");
			sesion.removeAttribute("dni");
			sesion.removeAttribute("mes");
			sesion.removeAttribute("pagosMes");
				
			String string = "";
			String[] parts;
			String grado="", turno="";
			
			if(request.getParameter("anio") != null){
				a�o = Integer.parseInt(request.getParameter("anio"));
				string = request.getParameter("grado_anio");				
				parts = string.split(" - ");				
				grado = parts[0];
				turno = parts[1];
				
				sesion.setAttribute("gradoCuota",grado);
				sesion.setAttribute("turnoCuota",turno);	
				sesion.setAttribute("a�oCuota",a�o);
				
				try {
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesAlumno") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					//obtiene los grados en condiciones de cobrar cuota, para el a�o seleccionado
					Alumnos alumnos = AccionesAlumno.getAllByGradoTurnoYA�o(grado,turno,a�o);					
					sesion.setAttribute("alumnos_cuota", alumnos);					
					
					alumnos = AccionesAlumno.getAlumnosPlanPago(grado,turno,a�o);
					sesion.setAttribute("alumnos_PlanPagos", alumnos);
					
				} catch (Exception e) {				
					e.printStackTrace();
				}

			}
			
				
			//System.out.println("grado = " + grado + " turno = " + turno + " a�o= " + a�o);
		
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/cuota_list.jsp");
			dispatcher.forward(request, response);			
			
			
			break;

			case "visualizarPagos":
			
			if (AccionesUsuario.validarAcceso(tipo, "pagos_list.jsp") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			//System.out.println("visualizar pagos goGet");
			int dni = 0, mes = 0;
			
			//pago edit
			sesion.removeAttribute("pagoEdit");
			//pago edit
			
			if (request.getParameter("a�o") != null){ //se ingresa por primera vez
			
				a�o = Integer.parseInt(request.getParameter("a�o"));			
				dni = Integer.parseInt(request.getParameter("dni"));			
				mes = Integer.parseInt(request.getParameter("mes"));
				

				sesion.setAttribute("a�o", a�o);
				sesion.setAttribute("dni", dni);
				sesion.setAttribute("mes", mes);
				
				
				//System.out.println("a�o= " + a�o);
				//System.out.println("dni= " + dni);
				//System.out.println("mes= " + mes);			
				
				try {
							
					if (AccionesUsuario.validarAcceso(tipo, "AccionesCuota") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					//obtiene los grados en condiciones de cobrar cuota, para el a�o seleccionado
					Cuotas cuotas = AccionesCuota.getPagosMes(dni, a�o, mes);
					
				    sesion.setAttribute("pagosMes", cuotas); //lo dejamos como session						
					
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
			}			
						
			if (request.getAttribute("accion") != null){
				
				//sesion.removeAttribute("pagosMes");
				
				a�o = (Integer) sesion.getAttribute("a�o");			
				dni = (Integer) sesion.getAttribute("dni");			
				mes = (Integer) sesion.getAttribute("mes");
				
				try {
					
					//obtiene los grados en condiciones de cobrar cuota, para el a�o seleccionado
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesCuota") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					Cuotas cuotas = AccionesCuota.getPagosMes(dni, a�o, mes);
					
				    sesion.setAttribute("pagosMes", cuotas); //lo dejamos como session						
					
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
			}
	
			dispatcher = getServletContext().getRequestDispatcher("/pagos_list.jsp");
			dispatcher.forward(request, response);			
			
			
			break;
			
			case "pagosDia":
				
				if (AccionesUsuario.validarAcceso(tipo, "pagos_dia.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				double d = 0.0;
				
				a�o = (Integer) sesion.getAttribute("a�oPlan");
				grados = (Grados) sesion.getAttribute("gradosPlan");
				
				String fecha = (String) request.getParameter("fecha_pagos");
				fecha = fecha.substring(6,10) +"-"+ fecha.substring(3,5) +"-"+ fecha.substring(0,2);
				
				request.setAttribute("fecha_dia", fecha);
							
				try {
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesCuota") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					double total = 0.0;
					
					d = AccionesCuota.getPagosDia(fecha);
					total = total + d;
					request.setAttribute("totalcuotas", ""+d);
					
					d = AccionesCuota.getPlanesDia(fecha);
					total = total + d;
					request.setAttribute("totalplanes", ""+d);
					
					d = AccionesCuota.getInscripcionesDia(fecha);
					total = total + d;
					request.setAttribute("totalinscripciones", ""+d);
					
					request.setAttribute("totaldia", ""+total);
					
					dispatcher = getServletContext().getRequestDispatcher("/pagos_dia.jsp");
					dispatcher.forward(request, response);
					
					
				} catch (Exception e) {
					e.printStackTrace();
				}
					
				break;
				
			} //fin del case		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		//System.out.println("CuotaList doPost");
			
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");			
		if (AccionesUsuario.validarAcceso(tipo, "CuotaList") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
			
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
			
			if (AccionesUsuario.validarAcceso(tipo, "menu_cuotas.jsp") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			sesion.removeAttribute("gradoCuota");
			sesion.removeAttribute("turnoCuota");	
			//sesion.removeAttribute("a�oCuota");
			sesion.removeAttribute("alumnos_cuota");
			sesion.removeAttribute("alumnos_PlanPagos");
			
			//pago edit
			sesion.removeAttribute("pagoEdit");
			//pago edit
						
			a�o = Integer.parseInt(request.getParameter("a�o_cuotas"));
												
			try {
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesGrado") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				//obtiene los grados en condiciones de cobrar cuota, para el a�o seleccionado
				grados = AccionesGrado.getA�oGradosCuota(a�o);
				
				request.setAttribute("gradosCuota", grados);			
				request.setAttribute("a�oCuota", a�o);		
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/menu_cuotas.jsp");
				dispatcher.forward(request, response);				
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			break;
			
			case "listarGrado":
			
			if (AccionesUsuario.validarAcceso(tipo, "cuota_list.jsp") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
				
			sesion.removeAttribute("a�o");
			sesion.removeAttribute("dni");
			sesion.removeAttribute("mes");
			sesion.removeAttribute("pagosMes");
				
			String string = "";
			String[] parts;
			String grado="", turno="";
			
			if(request.getParameter("anio") != null){
				a�o = Integer.parseInt(request.getParameter("anio"));
				string = request.getParameter("grado_anio");				
				parts = string.split(" - ");				
				grado = parts[0];
				turno = parts[1];
				
				sesion.setAttribute("gradoCuota",grado);
				sesion.setAttribute("turnoCuota",turno);	
				sesion.setAttribute("a�oCuota",a�o);
				
				try {
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesAlumno") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					//obtiene los grados en condiciones de cobrar cuota, para el a�o seleccionado					
					Alumnos alumnos = AccionesAlumno.getAllByGradoTurnoYA�o(grado,turno,a�o);
					
					sesion.setAttribute("alumnos_cuota", alumnos);					
					
				} catch (Exception e) {				
					e.printStackTrace();
				}

			}
			
				
			//System.out.println("grado = " + grado + " turno = " + turno + " a�o= " + a�o);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/cuota_list.jsp");
			dispatcher.forward(request, response);			
			
			
			break;

			case "visualizarPagos":
			
			if (AccionesUsuario.validarAcceso(tipo, "pagos_list.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			//System.out.println("visualizar pagos goPost");
			
			sesion.removeAttribute("pagoEdit");
			
			int dni = 0, mes = 0;
			
			if (request.getParameter("a�o") != null){ //se ingresa por primera vez
			
				a�o = Integer.parseInt(request.getParameter("a�o"));			
				dni = Integer.parseInt(request.getParameter("dni"));			
				mes = Integer.parseInt(request.getParameter("mes"));
				

				sesion.setAttribute("a�o", a�o);
				sesion.setAttribute("dni", dni);
				sesion.setAttribute("mes", mes);
				
				
				//System.out.println("a�o= " + a�o);
				//System.out.println("dni= " + dni);
				//System.out.println("mes= " + mes);			
				
				try {

					if (AccionesUsuario.validarAcceso(tipo, "AccionesCuota") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					//obtiene los grados en condiciones de cobrar cuota, para el a�o seleccionado
					Cuotas cuotas = AccionesCuota.getPagosMes(dni, a�o, mes);
					
				    sesion.setAttribute("pagosMes", cuotas); //lo dejamos como session						
					
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
			}
			
			if (request.getAttribute("accion") != null){
				
				//sesion.removeAttribute("pagosMes");
				
				a�o = (Integer) sesion.getAttribute("a�o");			
				dni = (Integer) sesion.getAttribute("dni");			
				mes = (Integer) sesion.getAttribute("mes");
				
				try {
	
					if (AccionesUsuario.validarAcceso(tipo, "AccionesCuota") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					//obtiene los grados en condiciones de cobrar cuota, para el a�o seleccionado					
					Cuotas cuotas = AccionesCuota.getPagosMes(dni, a�o, mes);
					
				    sesion.setAttribute("pagosMes", cuotas); //lo dejamos como session						
					
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
			}
									
			dispatcher = getServletContext().getRequestDispatcher("/pagos_list.jsp");
			dispatcher.forward(request, response);			
			
			
			break;
			} //fin del case		
	}

}
