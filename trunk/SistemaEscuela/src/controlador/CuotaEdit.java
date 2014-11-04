package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesCuota;
import conexion.AccionesUsuario;
import datos.Cuota;

/**
 * Servlet implementation class CuotaEdit
 */
public class CuotaEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CuotaEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession sesion = request.getSession();
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "CuotaEdit") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}

		//System.out.println("CuotaEdit doGet");
			
		String accion = (String) request.getParameter("accion");
			
		int cod_pago = 0;
			
		switch(accion){			
			
			case "altaPago":
				
				if (AccionesUsuario.validarAcceso(tipo, "CuotaList") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				sesion.removeAttribute("pagoEdit");		
				
				double pago = Double.parseDouble(request.getParameter("pago"));
				
				String obs = (String) request.getParameter("obs"); //observaciones
				
				int dia = Integer.parseInt(request.getParameter("dia_pago")); //fecha				
				int mes = Integer.parseInt(request.getParameter("mes_pago")); //fecha
				int año = Integer.parseInt(request.getParameter("año_pago")); //fecha
				
			 	int periodo = (Integer) sesion.getAttribute("mes");
				
				String relleno1 = "";
				String relleno2 = "";
				
				if (mes < 10){
					relleno1 = "0";
				}
				
				if (dia < 10){
					relleno2 = "0";
				}
				
				
				//int año = (Integer) sesion.getAttribute("año");	 //fecha
				int añoc = (Integer) sesion.getAttribute("añoCuota");
			    int dni = (Integer) sesion.getAttribute("dni");
			    
			    /*
			    System.out.println(dia);
			    System.out.println(mes);
			    System.out.println(año);
			    System.out.println(añoc);
			    System.out.println(dni);
			    System.out.println(obs);
			    */
			    
			    Cuota cuota = new Cuota(1,dni, año, periodo,"" + añoc + "-" + relleno1 + mes + "-" + relleno2 + dia, pago, obs);
										
				try {
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesCuota") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					//inserta un pago para la cuota seleccionada					
					AccionesCuota.insertOnePago(cuota);
					
					//request.setAttribute("pagoEdit", cuota);				
					
					request.setAttribute("accion", "visualizarPagos");
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/CuotaList");
					dispatcher.forward(request, response);				
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				break;
				
			case "modificarPago":
			
			if (AccionesUsuario.validarAcceso(tipo, "pago_edit.jsp") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			cod_pago = Integer.parseInt(request.getParameter("cod_pago"));			
									
			try {
				
				//obtiene los grados en condiciones de cobrar cuota, para el año seleccionado
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesCuota") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				cuota = AccionesCuota.getOnePago(cod_pago);
				
				sesion.setAttribute("pagoEdit", cuota);				
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/pago_edit.jsp");
				dispatcher.forward(request, response);				
				
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			break;
			
			case "borrarPago":
			
			if (AccionesUsuario.validarAcceso(tipo, "CuotaList") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			cod_pago = Integer.parseInt(request.getParameter("cod_pago"));			
									
			try {
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesCuota") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				//obtiene los grados en condiciones de cobrar cuota, para el año seleccionado
				AccionesCuota.deleteOnePago(cod_pago);
				
							
				request.setAttribute("accion", "visualizarPagos");
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/CuotaList");
				dispatcher.forward(request, response);			
						
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			break;
			
			}// fin del case
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		
		int tipo = (Integer) sesion.getAttribute("tipoUsuario");
		if (AccionesUsuario.validarAcceso(tipo, "CuotaEdit") != 1){							
			response.sendRedirect("Login"); //redirecciona al login, sin acceso						
		}
	
		String accion = (String) request.getParameter("accion");
			
		//System.out.println("accion = " + accion);
			
		switch(accion){			
						
			case "altaPago":
				
				if (AccionesUsuario.validarAcceso(tipo, "CuotaList") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				sesion.removeAttribute("pagoEdit");
				
				double pago = Integer.parseInt(request.getParameter("pago"));
				String obs = (String) request.getParameter("obs"); //observaciones
				
				int dia = Integer.parseInt(request.getParameter("dia_pago")); //fecha				
				int mes = Integer.parseInt(request.getParameter("mes_pago")); //fecha
				
			 	int periodo = (Integer) sesion.getAttribute("mes");
				
				String relleno1 = "";
				String relleno2 = "";
				
				if (mes < 10){
					relleno1 = "0";
				}
				
				if (dia < 10){
					relleno2 = "0";
				}
				
				
				//int año = (Integer) sesion.getAttribute("año");	 //fecha
				int año = (Integer) sesion.getAttribute("añoCuota");
			    int dni = (Integer) sesion.getAttribute("dni");
			    
			    //System.out.println(dia);
			    //System.out.println(mes);
			    //System.out.println(año);
			    //System.out.println(dni);
			    
			    Cuota cuota = new Cuota(1,dni, año, periodo,""+año + "-"+ relleno1 + mes + "-" + relleno2 + dia, pago, obs);			 
										
				try {
					
					if (AccionesUsuario.validarAcceso(tipo, "AccionesCuota") != 1){							
						response.sendRedirect("Login"); //redirecciona al login, sin acceso						
					}
					
					//inserta un pago para la cuota seleccionada
					AccionesCuota.insertOnePago(cuota);
					
					//request.setAttribute("pagoEdit", cuota);				
					
					request.setAttribute("accion", "visualizarPagos");
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/CuotaList");
					dispatcher.forward(request, response);				
					
				} catch (Exception e) {				
					e.printStackTrace();
				}
				
				break;
				
			case "modificarPago":
				
			if (AccionesUsuario.validarAcceso(tipo, "CuotaList") != 1){							
				response.sendRedirect("Login"); //redirecciona al login, sin acceso						
			}
			
			//System.out.println("modificar pago doGet");
				
			cuota = (Cuota) sesion.getAttribute("pagoEdit");
			
			//System.out.println("cod_pago = " +cuota.getCod_pago());
			//pago edit
			//sesion.removeAttribute("pagoEdit");
			//pago edit
									
			try {
				
				//obtiene los grados en condiciones de cobrar cuota, para el año seleccionado
				
				cuota = AccionesCuota.getOnePago(cuota.getCod_pago());
				
				dia = Integer.parseInt(request.getParameter("dia_pago")); //fecha				
				mes = Integer.parseInt(request.getParameter("mes_pago")); //fecha
				año = (Integer) sesion.getAttribute("añoCuota"); //año fecha
				
				pago = Double.parseDouble(request.getParameter("pago")); //pago
				obs = (String) request.getParameter("obs"); //observaciones
				
				/*
			    System.out.println(dia);
			    System.out.println(mes);
			    System.out.println(año);		    
			    System.out.println(obs);
			    */
							
				relleno1 = "";
				relleno2 = "";
				
				if (mes < 10){
					relleno1 = "0";
				}
				
				if (dia < 10){
					relleno2 = "0";
				}
				
				Cuota c = new Cuota(cuota.getCod_pago(), cuota.getDni(),cuota.getAño(),cuota.getPeriodo(), año + "-" + relleno1 + mes + "-" + relleno2 + dia, pago, obs);
				
				if (AccionesUsuario.validarAcceso(tipo, "AccionesCuota") != 1){							
					response.sendRedirect("Login"); //redirecciona al login, sin acceso						
				}
				
				AccionesCuota.updateOnePago(c);
				
				//System.out.println("accion visualizarPagos");
				
				request.setAttribute("accion", "visualizarPagos");
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/CuotaList");
				dispatcher.forward(request, response);				
								
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
			break;
			
			}// fin del case
	
	}

}
