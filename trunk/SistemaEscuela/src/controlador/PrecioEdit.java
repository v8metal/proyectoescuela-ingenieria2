package controlador;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesPrecio;
import datos.Precio;

/**
 * Servlet implementation class PrecioEdit
 */
public class PrecioEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PrecioEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		if(sesion.getAttribute("login")!=null){
			String accion = request.getParameter("do");
			int año = Integer.parseInt(request.getParameter("año"));
			int mes = Integer.parseInt(request.getParameter("mes"));
			String modificar = request.getParameter("modificar");
			
			sesion.setAttribute("modificar", modificar);
			if(accion.equals("modificar")){
				datos.Precio precio;
				try {
					precio = conexion.AccionesPrecio.getOnePrecio(año, mes);
					sesion.setAttribute("precio", precio);
					request.setAttribute("precio", precio);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/precio_edit.jsp");
				dispatcher.forward(request, response);
			}else{
				try {
					conexion.AccionesPrecio.borrarPrecio(año, mes);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/PrecioList");
				dispatcher.forward(request, response);
			}
		}else{
			response.sendRedirect("login.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		if(sesion.getAttribute("login")!=null){
			int prec_reg=Integer.parseInt(request.getParameter("prec_reg"));
			int prec_grupo = Integer.parseInt(request.getParameter("prec_grupo"));
			int reinsc_ant = Integer.parseInt(request.getParameter("reinsc_ant"));
			int reinsc = Integer.parseInt(request.getParameter("reinsc"));
			String modificar =(String)sesion.getAttribute("modificar");
			
			int año=0;
			if(modificar==null){
				año = Integer.parseInt(request.getParameter("año"));
				try {
					for(int i=1;i<13;i++){
						Precio precio =new Precio(año,i,prec_reg,prec_grupo,reinsc_ant,reinsc);
						AccionesPrecio.altaPrecio(precio);
					}
					sesion.setAttribute("year", año);
					response.sendRedirect("PrecioList");
				} catch (SQLException e) {
					String error = request.getParameter("error");
					sesion.setAttribute("error", error);
					response.sendRedirect("precio_edit.jsp");
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}else{
				año = (Integer)sesion.getAttribute("año");
				Precio p = (Precio)sesion.getAttribute("precio");
				String mes = request.getParameter("mes");
				if(mes.equals("Enero")){
					for(int i=2;i<13;i++){
						Precio precio = new Precio(año,i,prec_reg,prec_grupo,reinsc_ant,reinsc);
						try {
							AccionesPrecio.modificarPrecio(precio,i);
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
				if(mes.equals("Febrero")){
					for(int i=3;i<13;i++){
						Precio precio = new Precio(año,i,prec_reg,prec_grupo,reinsc_ant,reinsc);
						try {
							AccionesPrecio.modificarPrecio(precio,i);
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
				if(mes.equals("Marzo")){
					for(int i=4;i<13;i++){
						Precio precio = new Precio(año,i,prec_reg,prec_grupo,reinsc_ant,reinsc);
						try {
							AccionesPrecio.modificarPrecio(precio,i);
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
				if(mes.equals("Abril")){
					for(int i=5;i<13;i++){
						Precio precio = new Precio(año,i,prec_reg,prec_grupo,reinsc_ant,reinsc);
						try {
							AccionesPrecio.modificarPrecio(precio,i);
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
				if(mes.equals("Mayo")){
					for(int i=6;i<13;i++){
						Precio precio = new Precio(año,i,prec_reg,prec_grupo,reinsc_ant,reinsc);
						try {
							AccionesPrecio.modificarPrecio(precio,i);
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
				if(mes.equals("Junio")){
					for(int i=7;i<13;i++){
						Precio precio = new Precio(año,i,prec_reg,prec_grupo,reinsc_ant,reinsc);
						try {
							AccionesPrecio.modificarPrecio(precio,i);
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
				if(mes.equals("Julio")){
					for(int i=8;i<13;i++){
						Precio precio = new Precio(año,i,prec_reg,prec_grupo,reinsc_ant,reinsc);
						try {
							AccionesPrecio.modificarPrecio(precio,i);
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
				if(mes.equals("Agosto")){
					for(int i=9;i<13;i++){
						Precio precio = new Precio(año,i,prec_reg,prec_grupo,reinsc_ant,reinsc);
						try {
							AccionesPrecio.modificarPrecio(precio,i);
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
				if(mes.equals("Septiembre")){
					for(int i=10;i<13;i++){
						Precio precio = new Precio(año,i,prec_reg,prec_grupo,reinsc_ant,reinsc);
						try {
							AccionesPrecio.modificarPrecio(precio,i);
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
				if(mes.equals("Octubre")){
					for(int i=11;i<13;i++){
						Precio precio = new Precio(año,i,prec_reg,prec_grupo,reinsc_ant,reinsc);
						try {
							AccionesPrecio.modificarPrecio(precio,i);
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
				if(mes.equals("Noviembre")){
					for(int i=12;i<13;i++){
						Precio precio = new Precio(año,i,prec_reg,prec_grupo,reinsc_ant,reinsc);
						try {
							AccionesPrecio.modificarPrecio(precio,i);
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
				
				
				sesion.setAttribute("modificar", null);
				sesion.setAttribute("year", año);
				response.sendRedirect("PrecioList");
			}
		}else{
			response.sendRedirect("login.jsp");
		}
	}

}
