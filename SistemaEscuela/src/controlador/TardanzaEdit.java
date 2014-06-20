package controlador;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexion.AccionesTardanza;
import datos.Tardanza;

/**
 * Servlet implementation class TardanzaEdit
 */
public class TardanzaEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TardanzaEdit() {
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
			int dni = Integer.parseInt(request.getParameter("dni"));
			String fecha = request.getParameter("fecha");
			
			if(accion.equals("borrar")){
				try {
					AccionesTardanza.bajaTardanza(dni, fecha);
					sesion.setAttribute("borrar", "borrar");
					response.sendRedirect("TardanzaList");
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}else{
				sesion.setAttribute("activador", "activador");
				Tardanza t;
				try {
					t = AccionesTardanza.getOneTardanza(dni, fecha);
					sesion.setAttribute("tardanza", t);
					sesion.setAttribute("fecha", fecha);
					sesion.setAttribute("dni", dni);
					String modificar = request.getParameter("modificar");
					sesion.setAttribute("modificar", modificar);
					response.sendRedirect("tardanza_edit.jsp");
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
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
			String modificar=(String)sesion.getAttribute("modificar");
			int dni = Integer.parseInt(request.getParameter("dni"));
			String observaciones = request.getParameter("observaciones");
			String tipo = request.getParameter("tipo");
			if(modificar==null){
				Tardanza t = new Tardanza(dni,"",observaciones,tipo,"T");
				try {
					AccionesTardanza.altaTardanza(t);
					sesion.setAttribute("alta", "alta");
					response.sendRedirect("TardanzaList");
				} catch (SQLException e) {
					String error = request.getParameter("error");
					sesion.setAttribute("error", error);
					response.sendRedirect("tardanza_edit.jsp");
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}else{
				int dni2 = (int)sesion.getAttribute("dni");
				String fecha = (String)sesion.getAttribute("fecha");
				Tardanza tardanza = new Tardanza(dni,fecha,observaciones,tipo,"T");
				try {
					AccionesTardanza.modificarTardanza(tardanza, dni2, fecha);
					sesion.setAttribute("editar", "editar");
					response.sendRedirect("TardanzaList");
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
		}else{
			response.sendRedirect("login.jsp");
		}
	}

}
