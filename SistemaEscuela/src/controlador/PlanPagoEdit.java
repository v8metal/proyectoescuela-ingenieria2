package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesPlanPago;
import conexion.AccionesUsuario;
import datos.PlanPago;


/**
 * Servlet implementation class PlanPagoEdit
 */
public class PlanPagoEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PlanPagoEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();						
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "PlanPagoEdit") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
		
		//System.out.println("CuotaList doGet");
			
		String accion = "";
			
			/*
			if (request.getAttribute("accion") != null){
				 accion = (String) request.getAttribute("accion");
			}else
			{
			*/
		accion = (String) request.getParameter("accion");
			
			
		//System.out.println("accion= " + accion);
			
		switch(accion){			
			
			case "altaPlanPago":
			
			if (AccionesUsuario.validarAcceso(tipo, "CuotaList") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			/*
			int dia = Integer.parseInt(request.getParameter("dia_plan"));
			int mes = Integer.parseInt(request.getParameter("mes_plan"));
			*/
			int año = (Integer) sesion.getAttribute("añoPlan");
			
			
			String fecha = request.getParameter("fecha_pp");
			fecha = fecha.substring(6,10) +"-"+ fecha.substring(3,5) +"-"+ fecha.substring(0,2);
			
			int dni = Integer.parseInt(request.getParameter("dni"));
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
				
				PlanPago plan = new PlanPago(0, dni, 1,1, inicio, fin, fecha, obs);
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesPlanPago") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				AccionesPlanPago.insertOnePlan(plan);
			
				request.setAttribute("añoplan", año);
				request.setAttribute("accion", "listarGrado");
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/CuotaList");
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
