package conexion;

import java.sql.*;

import conexion.Conexion;
import datos.*;

public class AccionesCertificado {
	
	public static Certificados getAll() {
		Certificados lista = new Certificados();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM CERTIFICADOS");
			Certificado tmp;
			
			while (rs.next()) {
				tmp = new Certificado(rs.getInt("dni"), rs.getInt("año"), rs.getBoolean("ind_salud"), rs.getBoolean("ind_bucal"), rs.getBoolean("ind_dni"), rs.getBoolean("ind_auditivo"), rs.getBoolean("ind_visual"), rs.getBoolean("ind_vacunas"));
				lista.agregarCertificado(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public static Observaciones getObservacionesByDni(int dni) {
		Observaciones lista = new Observaciones();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM OBSERVACIONES WHERE DNI = '" + dni + "' AND AÑO = YEAR(current_date);");
			Observacion tmp;
			
			while (rs.next()) {
				tmp = new Observacion(rs.getInt("dni"), rs.getInt("año"), rs.getString("observaciones"));
				lista.agregarObservacion(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public static Observaciones getObservacionesByDniYAño(int dni, int año) {
		Observaciones lista = new Observaciones();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM OBSERVACIONES WHERE DNI = '" + dni + "' AND AÑO = '" + año + "'");
			Observacion tmp;
			
			while (rs.next()) {
				tmp = new Observacion(rs.getInt("dni"), rs.getInt("año"), rs.getString("observaciones"));
				lista.agregarObservacion(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
/*	
	
	public static Certificado getOne(int dni) throws SQLException, Exception {
		Certificado c = new Certificado();
//		int i = 0;
		
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM CERTIFICADOS WHERE DNI = '" + dni + "' AND AÑO = YEAR(current_date);");
			
			while (rs.next()) {
				c = new Certificado(rs.getInt("dni"), rs.getInt("año"), rs.getBoolean("ind_salud"), rs.getBoolean("ind_bucal"), rs.getBoolean("ind_dni"), rs.getBoolean("ind_auditivo"), rs.getBoolean("ind_visual"), rs.getBoolean("ind_vacunas"));
//				i = 1;
			}
			
	//		if (i == 0) {
	//			throw new SQLException();
	//		}	
			stmt.close();
			Conexion.desconectar();
	
		return c;
	}   			*/
	
	public static Certificado getOneByDniYAño(int dni, int año) throws SQLException, Exception {
		Certificado c = new Certificado();
//		int i = 0;
		
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM CERTIFICADOS WHERE DNI = '" + dni + "' AND AÑO = '" + año + "'");
			
			while (rs.next()) {
				c = new Certificado(rs.getInt("dni"), rs.getInt("año"), rs.getBoolean("ind_salud"), rs.getBoolean("ind_bucal"), rs.getBoolean("ind_dni"), rs.getBoolean("ind_auditivo"), rs.getBoolean("ind_visual"), rs.getBoolean("ind_vacunas"));
//				i = 1;
			}
			
	/*		if (i == 0) {
				throw new SQLException();
			}	*/
			stmt.close();
			Conexion.desconectar();
	
		return c;
	}
	
	public static void updateObservacion(int dni, String obs, String obs_nueva) throws SQLException, Exception {
		Statement stmt = Conexion.conectar().createStatement();
		stmt.executeUpdate("UPDATE OBSERVACIONES SET OBSERVACIONES = '" + obs_nueva +  "' WHERE DNI = '" + dni + "' AND AÑO = YEAR(current_date) AND OBSERVACIONES = '" + obs + "';");
		
		stmt.close();
		Conexion.desconectar();
	}
	
	public static void insertObservacion(Observacion o) throws SQLException, Exception {
		Statement stmt = Conexion.conectar().createStatement();
		stmt.executeUpdate("INSERT INTO OBSERVACIONES VALUES ('" + o.getDni() + "','" + o.getAño() + "','" + o.getObservaciones() + "')");
		
		stmt.close();
		Conexion.desconectar();
	}
	
	public static int deleteObservacion(int dni, int año, String obs) {
		int i = 0;
		try {
			Statement stmt = Conexion.conectar().createStatement();
			i = stmt.executeUpdate("DELETE FROM OBSERVACIONES WHERE DNI = '" + dni + "' AND AÑO = '" + año + "' AND OBSERVACIONES = '" + obs + "';");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}
	
	public static int deleteObservaciones(int dni) {
		int i = 0;
		try {
			Statement stmt = Conexion.conectar().createStatement();
			i = stmt.executeUpdate("DELETE FROM OBSERVACIONES WHERE DNI = '" + dni + "'");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}
	
	public static boolean esObservacion(Observacion o) throws SQLException, Exception {	
		boolean b = false;
		
		Statement stmt = Conexion.conectar().createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM OBSERVACIONES WHERE DNI = '" + o.getDni() + "' AND AÑO = '" + o.getAño() + "' AND OBSERVACIONES = '" + o.getObservaciones() + "';");
			
		while (rs.next()) {
			b = true;	
		}
		stmt.close();
		Conexion.desconectar();
	
		return b;
	}
	
	public static int boolToByte(boolean b) {
		byte r = (b == true? (byte)1 : (byte)0);
		return r;
	}
	
	public static void updateOne(int dni, boolean ind_salud, boolean ind_bucal, boolean ind_dni, boolean ind_auditivo, boolean ind_visual, boolean ind_vacunas, int año) throws SQLException, Exception {
			Statement stmt = Conexion.conectar().createStatement();
			stmt.executeUpdate("UPDATE CERTIFICADOS SET IND_SALUD = '" + boolToByte(ind_salud) + "', IND_BUCAL = '" + boolToByte(ind_bucal) + "', IND_DNI = '" + boolToByte(ind_dni) + "', IND_AUDITIVO = '" + boolToByte(ind_auditivo) + "', IND_VISUAL = '" + boolToByte(ind_visual) + "', IND_VACUNAS = '" + boolToByte(ind_vacunas) +  "' WHERE DNI = '" + dni + "' AND AÑO = '" + año + "'");
			
			stmt.close();
			Conexion.desconectar();
	}
	
	public static void insertOne(int dni, int año) throws SQLException, Exception { //inserta los valores por defecto (0) de los indicadores de certificados
		Statement smt = Conexion.conectar().createStatement();
		
		//System.out.println("INSERT INTO CERTIFICADOS (DNI, AÑO) VALUES (" + dni + "," + año + " )");
		
		smt.executeUpdate("INSERT INTO CERTIFICADOS (DNI, AÑO) VALUES (" + dni + "," + año + " )");
		
		smt.close();
		Conexion.desconectar();
}
	
	public static int deleteOne(int dni, int año) {
		int i = 0;
		try {
			Statement stmt = Conexion.conectar().createStatement();
			i = stmt.executeUpdate("DELETE FROM CERTIFICADOS WHERE DNI = " + dni + " AND AÑO = " + año);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}

/*	
	public static Certificados getByGrado(String grado) {
		Certificados lista = new Certificados();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT A.DNI, A.NOMBRE, A.APELLIDO, A.DOMICILIO, A.TELEFONO, A.FECHA_NAC, A.LUGAR_NAC, A.DNI_TUTOR, A.DNI_MADRE, A.CANT_HER_MAY, A.CANT_HER_MEN, A.IGLESIA, A.ESC, A.IND_GRUPO, A.IND_SUBSIDIO FROM ALUMNOS A, ALUMNOS_GRADO AG WHERE A.DNI = AG.DNI AND AG.GRADO = '" + grado + "' AND AG.AÑO = YEAR(current_date);");
			Alumno tmp;
			while (rs.next()) {
				tmp = new Alumno(rs.getInt("dni"), rs.getString("nombre"), rs.getString("apellido"), rs.getString("domicilio"), rs.getString("telefono"), rs.getString("fecha_nac"), rs.getString("lugar_nac"), rs.getInt("dni_tutor"), rs.getInt("dni_madre"), rs.getInt("cant_her_may"), rs.getInt("cant_her_men"), rs.getString("iglesia"), rs.getString("esc"), rs.getBoolean("ind_grupo"), rs.getBoolean("ind_subsidio"));
				lista.agregarAlumno(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
*/
	
	public static void main(String[] args) {

		try {
			
//			updateOne(37041734, false, true, false, true, false, true);
//			updateObservacion(37041734, "a", "b");
//			Observacion o = new Observacion(37041734, 2014, "Los perdioo");
//			insertObservacion(o);
//			Observaciones al = getObservacionesByDni(37041734);
//			al.listar();
			
//			boolean b = esObservacion(o);
//			System.out.println(b);
			
			Observaciones obs = getObservacionesByDniYAño(37041734, 2010);
			obs.getLista();
			
			Certificado c = getOneByDniYAño(37041734, 2010);
			System.out.println(c);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
