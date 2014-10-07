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
		
		if(sesion.getAttribute("login")!=null){
			
			//System.out.println("CuotaList doGet");
			
			String accion = "";
				
			//accion = (String) request.getParameter("accion");
			
			if (request.getAttribute("accion") != null){
				 accion = (String) request.getAttribute("accion");
			}else{
				 accion = (String) request.getParameter("accion");
			}
			
			System.out.println("accion= " + accion);
			
			int cod_plan = 0 ;
			
			switch(accion){			
			
			case "visualizarPlan":
				
			sesion.removeAttribute("planPagos");
									
			cod_plan = Integer.parseInt(request.getParameter("codplan"));
						
			try {
				
				PlanPago plan = AccionesPlanPago.getOnePlan(cod_plan);
				
				request.setAttribute("PlanPago", plan);
				//sesion.setAttribute("PlanPago", plan);
				
				//RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/planPago_list.jsp");
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/planPago_edit.jsp");
				dispatcher.forward(request, response);								
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			break;
			
			case "altaPlanPago":
				
			//sesion.removeAttribute("PlanPago");
				
			int dia = Integer.parseInt(request.getParameter("dia_plan"));
			int mes = Integer.parseInt(request.getParameter("mes_plan"));
			int año = (Integer) sesion.getAttribute("añoPlan");
			
			int dni = Integer.parseInt(request.getParameter("dni"));
			int añoini = Integer.parseInt(request.getParameter("añoini"));
			int añofin = Integer.parseInt(request.getParameter("añofin"));
			int inicio = Integer.parseInt(request.getParameter("periodo_ini"));
			int fin = Integer.parseInt(request.getParameter("periodo_fin"));
			String obs = (String) request.getParameter("obs");
			
			String relleno = "";
			
			
			if (dia < 10){
				relleno = "0";
			}
			
			//sesion.setAttribute("dni", dni);
			
			try {
				
				PlanPago plan = new PlanPago(0, dni, añoini, añofin, inicio, fin, año + "-" + mes + "-" + relleno + dia, obs);
				
				AccionesPlanPago.insertOnePlan(plan);
			
				request.setAttribute("añoplan", año);
				request.setAttribute("accion", "listarGrado");
					
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/CuotaList");
				dispatcher.forward(request, response);								
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			break;
			
			case "modificarPlanPago":
				
			
			cod_plan = Integer.parseInt(request.getParameter("cod_plan"));
			añoini = Integer.parseInt(request.getParameter("añoini"));
			añofin = Integer.parseInt(request.getParameter("añofin"));
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
				
				PlanPago plan = new PlanPago(cod_plan, 0, añoini,añofin, inicio, fin, "",obs);
				
				AccionesPlanPago.updatePlanPago(plan);

				//request.setAttribute("añoplan", año);
				request.setAttribute("accion", "listarGrado");
					
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/CuotaList");
				dispatcher.forward(request, response);						
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			break;
			
			case "borrarPlanPago":
				
				cod_plan = Integer.parseInt(request.getParameter("codplan"));
							
				try {
					
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
				
				if (request.getParameter("codplan") != null){
					cod_plan = Integer.parseInt(request.getParameter("codplan"));
				}else{
					PlanPago p = (PlanPago) sesion.getAttribute("planPagos");
					cod_plan = p.getCod_plan();					
				}
				
				PagosPlanPago ppp = null;
				PlanPago pp = null;
				
							
				try {
					
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
					
			    PlanPago plan = (PlanPago) sesion.getAttribute("planPagos");
				
			    dia = Integer.parseInt(request.getParameter("diapp"));
			    mes = Integer.parseInt(request.getParameter("mespp"));
			    año = Integer.parseInt(request.getParameter("añopp"));
			    double pago = Double.parseDouble(request.getParameter("pagopp"));
			    obs = (String) request.getParameter("obspp");
			    
			    if (dia < 10){
					relleno = "0";
				}
				
							
				try {
					
					PagoPlanPago pagopp = new PagoPlanPago(plan.getCod_plan(), 0, plan.getDni(), año + "-" + mes + "-" + dia, pago, obs);
					
					AccionesPlanPago.insertOnePagopp(pagopp);
					
					request.setAttribute("accion", "listarPagosPlan");
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/PlanPagoList");
					dispatcher.forward(request, response);							
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				break;
				
				case "modificarPagopp":
					
				    int cod_pago = Integer.parseInt(request.getParameter("cod_pago"));
				    
				    System.out.println("cod_pago" + cod_pago);
				    
				    plan = (PlanPago) sesion.getAttribute("planPagos");
				    							
					try {
						
						
						PagoPlanPago pagopp = AccionesPlanPago.getOnePagopp(plan.getCod_plan(), cod_pago);
						
						request.setAttribute("pagopp", pagopp);
						
						RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/pagoPlanPago_edit.jsp");
						dispatcher.forward(request, response);							
						
					} catch (Exception e) {				
						e.printStackTrace();
					}
					
					break;
					
					case "modificarPagopp2":
					
				    cod_pago = Integer.parseInt(request.getParameter("cod_pago"));
				    
				    plan = (PlanPago) sesion.getAttribute("planPagos");
				    
				    dia = Integer.parseInt(request.getParameter("diapp"));
				    mes = Integer.parseInt(request.getParameter("mespp"));
				    año = Integer.parseInt(request.getParameter("añopp"));
				    pago = Double.parseDouble(request.getParameter("pagopp"));
				    obs = (String) request.getParameter("obspp");
				    
				    if (dia < 10){
						relleno = "0";
					}
					
								
					try {
						
						PagoPlanPago pagopp = new PagoPlanPago(plan.getCod_plan(), cod_pago, plan.getDni(), año + "-" + mes + "-" + dia, pago, obs);
					
						AccionesPlanPago.updatePagopp(pagopp);
						
						request.setAttribute("accion", "listarPagosPlan");
						
						RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/PlanPagoList");
						dispatcher.forward(request, response);							
												
						
					} catch (Exception e) {				
						e.printStackTrace();
					}
					
					break;
					
					case "borrarPagopp":
						
					    cod_pago = Integer.parseInt(request.getParameter("cod_pago"));
					    
					    plan = (PlanPago) sesion.getAttribute("planPagos");
					    
					    try {
							
							AccionesPlanPago.borrarPagopp(plan.getCod_plan(), cod_pago);
							
							request.setAttribute("accion", "listarPagosPlan");
							
							RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/PlanPagoList");
							dispatcher.forward(request, response);							
													
							
						} catch (Exception e) {				
							e.printStackTrace();
						}
						
						break;

					
			} //fin del case
			
		}else{
			response.sendRedirect("login.jsp");
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
