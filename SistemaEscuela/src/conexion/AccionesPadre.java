package conexion;

import java.sql.*;

import datos.*;

import conexion.Conexion;

public class AccionesPadre {
	
	public static Padres getAll() {
		Padres lista = new Padres();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM PADRES");
			Padre tmp;
			
			while (rs.next()) {
				tmp = new Padre(rs.getInt("dni"), rs.getString("nombre"), rs.getString("apellido"), rs.getString("lugar_nac"), rs.getString("fecha_nac"), rs.getString("domicilio"), rs.getString("telefono"), rs.getString("ocupacion"), rs.getString("dom_lab"), rs.getString("tel_lab"), rs.getString("est_civil"));
				lista.agregarPadre(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public static Padre getOne(int dni) throws SQLException, Exception {
		Padre p = new Padre();
		int i = 0;
		
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM PADRES WHERE DNI = '" + dni + "'");
			
			while (rs.next()) {
				p = new Padre(rs.getInt("dni"), rs.getString("nombre"), rs.getString("apellido"), rs.getString("lugar_nac"), rs.getString("fecha_nac"), rs.getString("domicilio"), rs.getString("telefono"), rs.getString("ocupacion"), rs.getString("dom_lab"), rs.getString("tel_lab"), rs.getString("est_civil"));
				i = 1;
			}
			
			if (i == 0) {
				throw new SQLException();
			}
			stmt.close();
			Conexion.desconectar();
	
		return p;
	}
	
	public static boolean esPadre(int dni) throws SQLException, Exception {	
		boolean b = false;
		
		Statement stmt = Conexion.conectar().createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM PADRES WHERE DNI = '" + dni + "'");
			
		while (rs.next()) {
			b = true;	
		}
		stmt.close();
		Conexion.desconectar();
	
		return b;
	}
	
	public static int deleteOne(int dni) {
		int i = 0;
		try {
			Statement stmt = Conexion.conectar().createStatement();
			i = stmt.executeUpdate("DELETE FROM PADRES WHERE DNI = '" + dni + "'");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}
	
	
	public static void insertOne(Padre p) throws SQLException, Exception {
		Statement stmt = Conexion.conectar().createStatement();
		stmt.executeUpdate("INSERT INTO PADRES VALUES ('" + p.getDni() + "','" + p.getNombre() + "','" + p.getApellido() + "','" + p.getLugar_nac() + "','" + p.getFecha_nac() + "','" + p.getDomicilio() + "','" + p.getTelefono() + "','" + p.getOcupacion() + "','" + p.getDom_lab() + "','" + p.getTel_lab() + "','" + p.getEst_civil() + "')");
		
		stmt.close();
		Conexion.desconectar();
	} 
	
	public static void updateOne(int dni, String nombre, String apellido, String lugar_nac,
			String fecha_nac, String domicilio, String telefono,
			String ocupacion, String dom_lab, String tel_lab, String est_civil
			) throws SQLException, Exception {
			Statement stmt = Conexion.conectar().createStatement();
			stmt.executeUpdate("UPDATE PADRES SET NOMBRE = '" + nombre + "', APELLIDO = '" + apellido + "', LUGAR_NAC = '" + lugar_nac + "', FECHA_NAC = '" +
								fecha_nac + "', DOMICILIO = '" + domicilio + "', TELEFONO = '" + telefono + "', OCUPACION = '" + ocupacion + "', DOM_LAB = '" +
								dom_lab + "', TEL_LAB = '" + tel_lab + "', EST_CIVIL = '" + est_civil + "' WHERE DNI = '" + dni + "'");
	
			stmt.close();
			Conexion.desconectar();
	}
	
	// Convierte un String en null si este es "" (cadena vacia). 
	// Utilizado en el caso de que el input "dni_padre" o "dni_madre" quede vacio en AltaAlumno.jsp
	// Debido a que estos campos son FK en la tabla ALUMNOS y tiene que existir en la tabla PADRES, o
	// ser null.
	public static String convertToNull (String s){
		String ss = s;
		if (ss == "" || ss == " ") {
			ss = null;
		}
		return ss;
	}
	
	public static void main(String[] args) {	// getAll(), getOne(), insertOne(), updateOne() y deleteOne()  probadas correctamente
		
		try {
			
		//	Padre p = getOne(53665545);
		//	System.out.println(p.toString());
		//	Padre pp = new Padre(3, "2", "2", "2", "1992-05-04", "5", "3", "2", "2", "2", "2", "2");
		//	insertOne(pp);
		//	updateOne(3, "0", "0", "0", "1992-07-12", "0", "0", "0", "0", "0", "0", "0");
		//	deleteOne(3);
		//	Padres p1 = getAll();
		//	p1.listar();
			
	//		String s = convertToNull("");
	//		System.out.println(s);
			
			boolean b = esPadre(0);
			System.out.println(b);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
