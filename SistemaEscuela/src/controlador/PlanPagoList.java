package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesAlumno;
import conexion.AccionesPlanPago;
import conexion.AccionesUsuario;
import datos.PagoPlanPago;
import datos.PagosPlanPago;
import datos.PlanPago;

/**
 * Servlet implementation class PlanPagoList
 */
public class PlanPagoList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PlanPagoList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		HttpSession sesion = request.getSession();						
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		
		if (AccionesUsuario.validarAcceso(tipo, "PlanPagoList") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
			
		//System.out.println("CuotaList doGet");
			
		String accion = "";
				
		//accion = (String) request.getParameter("accion");
			
		if (request.getAttribute("accion") != null){
			 accion = (String) request.getAttribute("accion");
		}else{
			 accion = (String) request.getParameter("accion");
		}
		
		String fecha = "";
		
		if (request.getParameter("fecha_ppp") != null){	//pago para plan de pago	
			fecha = request.getParameter("fecha_ppp");
			fecha = fecha.substring(6,10) +"-"+ fecha.substring(3,5) +"-"+ fecha.substring(0,2);			
		}
		
		if (request.getParameter("fecha_pp") != null){ //plan de pago			
			fecha = request.getParameter("fecha_pp");
			fecha = fecha.substring(6,10) +"-"+ fecha.substring(3,5) +"-"+ fecha.substring(0,2);			
		}
		 
			
		//System.out.println("accion= " + accion);
			
		int cod_plan = 0 ;
			
		switch(accion){			
			
			case "visualizarPlan":
			
			if (AccionesUsuario.validarAcceso(tipo, "planPago_edit.jsp") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			sesion.removeAttribute("planPagos");
									
			cod_plan = Integer.parseInt(request.getParameter("codplan"));
						
			try {
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesPlanPago") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				PlanPago plan = AccionesPlanPago.getOnePlan(cod_plan);
				
				request.setAttribute("PlanPago", plan);	
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/planPago_edit.jsp");
				dispatcher.forward(request, response);								
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			break;
			
			case "altaPlanPago":
				
			//sesion.removeAttribute("PlanPago");
				
			if (AccionesUsuario.validarAcceso(tipo, "CuotaList") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
				
			/*
			int dia = Integer.parseInt(request.getParameter("dia_plan"));
			int mes = Integer.parseInt(request.getParameter("mes_plan"));
			*/
			int a�o = (Integer) sesion.getAttribute("a�oPlan");
			
			
			int dni = Integer.parseInt(request.getParameter("dni"));
			int a�oini = Integer.parseInt(request.getParameter("a�oini"));
			int a�ofin = Integer.parseInt(request.getParameter("a�ofin"));
			int inicio = Integer.parseInt(request.getParameter("periodo_ini"));
			int fin = Integer.parseInt(request.getParameter("periodo_fin"));
			String obs = (String) request.getParameter("obs");
			
			/*
			String relleno = "";		
			
			if (dia < 10){
				relleno = "0";
			}
			*/
			
			//sesion.setAttribute("dni", dni);
			
			try {
				
				PlanPago plan = new PlanPago(0, dni, a�oini, a�ofin, inicio, fin, fecha, obs);
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesPlanPago") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				AccionesPlanPago.insertOnePlan(plan);
			
				request.setAttribute("a�oplan", a�o);
				request.setAttribute("accion", "listarGrado");
					
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/CuotaList");
				dispatcher.forward(request, response);								
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			break;
			
			case "modificarPlanPago":
				
			if (AccionesUsuario.validarAcceso(tipo, "CuotaList") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
				
			cod_plan = Integer.parseInt(request.getParameter("cod_plan"));
			a�oini = Integer.parseInt(request.getParameter("a�oini"));
			a�ofin = Integer.parseInt(request.getParameter("a�ofin"));
			inicio = Integer.parseInt(request.getParameter("periodo_ini"));
			fin = Integer.parseInt(request.getParameter("periodo_fin"));
			obs = (String) request.getParameter("obs");
			
			/*
			System.out.println(cod_plan);
			System.out.println(inicio);
			System.out.println(fin);
			System.out.println(obs);
			*/
			
			try {
				
				PlanPago plan = new PlanPago(cod_plan, 0, a�oini,a�ofin, inicio, fin, "",obs);
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesPlanPago") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				AccionesPlanPago.updatePlanPago(plan);

				//request.setAttribute("a�oplan", a�o);
				request.setAttribute("accion", "listarGrado");
					
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/CuotaList");
				dispatcher.forward(request, response);						
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			break;
			
			case "borrarPlanPago":
				
				if (AccionesUsuario.validarAcceso(tipo, "CuotaList") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				cod_plan = Integer.parseInt(request.getParameter("codplan"));
							
				try {
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesPlanPago") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					AccionesPlanPago.deletePagosPlanPago(cod_plan);
					
					AccionesPlanPago.deletePlanPago(cod_plan);					
					
					//sesion.setAttribute("PlanPago", plan);
					
					request.setAttribute("accion", "listarGrado");
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/CuotaList");
					dispatcher.forward(request, response);							
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				break;
			
				case "listarPagosPlan":
				
				if (AccionesUsuario.validarAcceso(tipo, "pagosPlanPago_list.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				if (request.getParameter("codplan") != null){
					cod_plan = Integer.parseInt(request.getParameter("codplan"));
				}else{
					PlanPago p = (PlanPago) sesion.getAttribute("planPagos");
					cod_plan = p.getCod_plan();					
				}
				
				PagosPlanPago ppp = null;
				PlanPago pp = null;
				
							
				try {
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesPlanPago") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					pp= AccionesPlanPago.getOnePlan(cod_plan);					
					
					ppp = AccionesPlanPago.getPagospp(cod_plan);
					
				
					request.setAttribute("pagospp", ppp);
					
					sesion.setAttribute("planPagos", pp); //lo hacemos session para que se pueda utilizar para cargar pagos (pagoPlanPago_edit.jsp)
					
					request.setAttribute("alumnopp", AccionesAlumno.getOne(pp.getDni()));
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/pagosPlanPago_list.jsp");
					dispatcher.forward(request, response);							
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				break;
				
				case "altaPagopp":
				
				if (AccionesUsuario.validarAcceso(tipo, "PlanPagoList") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
					
			    PlanPago plan = (PlanPago) sesion.getAttribute("planPagos");
				
			    /*
			    dia = Integer.parseInt(request.getParameter("diapp"));
			    mes = Integer.parseInt(request.getParameter("mespp"));
			    a�o = Integer.parseInt(request.getParameter("a�opp"));
			    */
			    double pago = Double.parseDouble(request.getParameter("pagopp"));
			    obs = (String) request.getParameter("obspp");
			    
			    /*
			    if (dia < 10){
					relleno = "0";
				}
				*/
				
							
				try {
					
					PagoPlanPago pagopp = new PagoPlanPago(plan.getCod_plan(), 0, plan.getDni(), fecha, pago, obs);
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesPlanPago") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					AccionesPlanPago.insertOnePagopp(pagopp);
					
					request.setAttribute("accion", "listarPagosPlan");
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/PlanPagoList");
					dispatcher.forward(request, response);							
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				break;
				
				case "modificarPagopp":
					
					if (AccionesUsuario.validarAcceso(tipo, "pagoPlanPago_edit.jsp") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
				    int cod_pago = Integer.parseInt(request.getParameter("cod_pago"));
				    
				    //System.out.println("cod_pago" + cod_pago);
				    
				    plan = (PlanPago) sesion.getAttribute("planPagos");
				    							
					try {
						
						if (AccionesUsuario.validarAcceso(tipo, "AccionesPlanPago") != 1){							
							response.sendRedirect("Login"); //redirecciona al login, sin acceso						
						}
												
						PagoPlanPago pagopp = AccionesPlanPago.getOnePagopp(plan.getCod_plan(), cod_pago);
						
						request.setAttribute("pagopp", pagopp);
						
						RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/pagoPlanPago_edit.jsp");
						dispatcher.forward(request, response);							
						
					} catch (Exception e) {				
						e.printStackTrace();
					}
					
					break;
					
					case "modificarPagopp2":
					
					if (AccionesUsuario.validarAcceso(tipo, "PlanPagoList") != 1){							
							response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
				    cod_pago = Integer.parseInt(request.getParameter("cod_pago"));
				    
				    plan = (PlanPago) sesion.getAttribute("planPagos");
				    
				    /*
				    dia = Integer.parseInt(request.getParameter("diapp"));
				    mes = Integer.parseInt(request.getParameter("mespp"));
				    a�o = Integer.parseInt(request.getParameter("a�opp"));
				    */
				    pago = Double.parseDouble(request.getParameter("pagopp"));
				    obs = (String) request.getParameter("obspp");
				    
				    /*
				    if (dia < 10){
						relleno = "0";
					}
					*/
					
								
					try {
						
						PagoPlanPago pagopp = new PagoPlanPago(plan.getCod_plan(), cod_pago, plan.getDni(), fecha, pago, obs);
					
						if (AccionesUsuario.validarAcceso(tipo, "AccionesPlanPago") != 1){							
							response.sendRedirect("Login"); //redirecciona al login, sin acceso						
						}
						
						AccionesPlanPago.updatePagopp(pagopp);
						
						request.setAttribute("accion", "listarPagosPlan");
						
						RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/PlanPagoList");
						dispatcher.forward(request, response);							
												
						
					} catch (Exception e) {				
						e.printStackTrace();
					}
					
					break;
					
					case "borrarPagopp":
						
						if (AccionesUsuario.validarAcceso(tipo, "PlanPagoList") != 1){							
							response.sendRedirect("Login"); //redirecciona al login, sin acceso						
						}
						
					    cod_pago = Integer.parseInt(request.getParameter("cod_pago"));
					    
					    plan = (PlanPago) sesion.getAttribute("planPagos");
					    
					    try {
					    	
							if (AccionesUsuario.validarAcceso(tipo, "AccionesPlanPago") != 1){							
								response.sendRedirect("Login"); //redirecciona al login, sin acceso						
							}
							
							AccionesPlanPago.borrarPagopp(plan.getCod_plan(), cod_pago);
							
							request.setAttribute("accion", "listarPagosPlan");
							
							RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/PlanPagoList");
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
		// TODO Auto-generated method stub
	}

}
