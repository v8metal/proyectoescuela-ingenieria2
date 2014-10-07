package conexion;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import datos.EstadoAlumno;
import datos.EstadoAlumnos;

public class AccionesEstado {
	
	public static void activarAlumno(int dni, String fecha) throws SQLException, Exception {
		Statement stmt = Conexion.conectar().createStatement();
		stmt.executeUpdate("INSERT INTO ESTADO_ALUMNO (DNI, FECHA) VALUES ('" + dni + "','" + fecha + "')");
		
		stmt.close();
		Conexion.desconectar();
	}
	
	public static void desactivarAlumno(int dni, String fecha) throws SQLException, Exception {
		Statement stmt = Conexion.conectar().createStatement();
		stmt.executeUpdate("INSERT INTO ESTADO_ALUMNO VALUES ('" + dni + "','" + fecha + "','0')");
		
		stmt.close();
		Conexion.desconectar();
	}
	
	public static int deleteEstado(int dni) {
		int i = 0;
		try {
			Statement stmt = Conexion.conectar().createStatement();
			i = stmt.executeUpdate("DELETE FROM ESTADO_ALUMNO WHERE DNI = '"+ dni + "'");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}
	
	public static EstadoAlumno getOne(int dni) throws SQLException, Exception {		// RECUPERA EL ULTIMO ESTADO Y FECHA DEL ALUMNO PASADO POR EL DNI
		EstadoAlumno m = new EstadoAlumno();
		int i = 0;
		
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT EA1.DNI, EA1.FECHA, EA.ACTIVO FROM ESTADO_ALUMNO AS EA INNER JOIN (SELECT DNI, MAX(FECHA) AS FECHA FROM ESTADO_ALUMNO GROUP BY DNI) AS EA1 ON (EA.DNI = EA1.DNI AND EA.FECHA = EA1.FECHA) WHERE EA1.DNI = '" + dni + "'");
			
			while (rs.next()) {
				m = new EstadoAlumno(rs.getInt("dni"), rs.getString("fecha"), rs.getBoolean("activo"));
				i = 1;
			}
			
			if (i == 0) {
				throw new SQLException();
			}
			stmt.close();
			Conexion.desconectar();
	
		return m;
	}
	
	public static EstadoAlumnos getInactivos() {
		EstadoAlumnos lista = new EstadoAlumnos();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT EA1.DNI, EA1.FECHA, EA.ACTIVO FROM ESTADO_ALUMNO AS EA INNER JOIN (SELECT DNI, MAX(FECHA) AS FECHA FROM ESTADO_ALUMNO GROUP BY DNI) AS EA1 ON (EA.DNI = EA1.DNI AND EA.FECHA = EA1.FECHA) WHERE EA.ACTIVO = 0 ORDER BY EA.FECHA DESC");
			EstadoAlumno tmp;
			
			while (rs.next()) {
				tmp = new EstadoAlumno(rs.getInt("dni"), rs.getString("fecha"), rs.getBoolean("activo"));
				lista.agregarEstadoAlumno(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public static void main(String[] args) {
		try {
			//DesactivarAlumno(37041734, "2015-9-24");

		//	deleteEstado(1);
			
			EstadoAlumno ea = getOne(3915648);
			System.out.println(ea);
	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
