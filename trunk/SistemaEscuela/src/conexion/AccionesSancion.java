package conexion;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import datos.Alumno;
import datos.Sancion;
import datos.Sanciones;
import datos.Alumnos;

public class AccionesSancion {

	public static Sanciones getAll(int año, int DNI_MAESTRO) {
		Sanciones lista = new Sanciones();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT DISTINCT S.DNI, AG.GRADO, AG.TURNO, S.FECHA, S.HORA, S.MOTIVO FROM SANCIONES AS S INNER JOIN ALUMNOS_GRADO AS AG ON (AG.DNI = S.DNI AND AG.AÑO = "+ año + ") INNER JOIN MAESTROS_GRADO AS MG ON (MG.GRADO = AG.GRADO AND MG.TURNO = AG.TURNO) WHERE S.FECHA BETWEEN '"+ año +"-01-01' AND '" + año + "-12-31' AND (MG.DNI_MAESTRO_TIT = " + DNI_MAESTRO + " OR MG.DNI_MAESTRO_PAR = " + DNI_MAESTRO + ")" );			
			Sancion tmp;
			
			while (rs.next()) {
				tmp = new Sancion(rs.getInt("DNI"), rs.getString("GRADO"),rs.getString("TURNO"),rs.getString("FECHA"), rs.getString("HORA"), rs.getString("MOTIVO"));
				lista.agregarSancion(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public static Sancion getOne(int dni, String fecha, String hora) {
		Sancion sancion = new Sancion();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM SANCIONES WHERE DNI = " + dni + " AND FECHA = '" + fecha + "' AND HORA = '" + hora + "'");
						
			while (rs.next()) {
				sancion = new Sancion(rs.getInt("DNI"), rs.getString("FECHA"), rs.getString("HORA"), rs.getString("MOTIVO"));				
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sancion;
	}
	
	public static Alumnos getAlumnos(int año, int DNI_MAESTRO) {
		Alumnos lista = new Alumnos();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT DISTINCT A.* FROM MAESTROS_GRADO MG INNER JOIN ALUMNOS_GRADO AG ON(AG.GRADO = MG.GRADO AND AG.TURNO = MG.TURNO) INNER JOIN ALUMNOS A ON (A.DNI = AG.DNI) WHERE AG.AÑO = " + año + " AND (MG.DNI_MAESTRO_TIT = " + DNI_MAESTRO + " OR MG.DNI_MAESTRO_PAR = " + DNI_MAESTRO+ ")");
			Alumno tmp;
			
			while (rs.next()) {
				tmp = new Alumno(rs.getInt("dni"), rs.getString("nombre"), rs.getString("apellido"), rs.getString("domicilio"), rs.getString("telefono"), rs.getString("fecha_nac"), rs.getString("lugar_nac"), rs.getInt("dni_tutor"), rs.getInt("dni_madre"), rs.getInt("cant_her_may"), rs.getInt("cant_her_men"), rs.getString("iglesia"), rs.getString("esc"), false, false);
				lista.agregarAlumno(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public static void updateOne(int dni, String fecha, String hora, String fecha_update, String hora_update, String motivo_update) throws SQLException, Exception {
			Statement stmt = Conexion.conectar().createStatement();
			stmt.executeUpdate("UPDATE SANCIONES SET FECHA = '" + fecha_update + "', HORA = '" + hora_update + "', MOTIVO = '" + motivo_update + "' WHERE DNI = "+ dni + " AND FECHA = '" + fecha + "' AND HORA = '" + hora + "'");			
			stmt.close();
			Conexion.desconectar();
	}
	
	public static void insertOne(Sancion s) throws SQLException, Exception {
		Statement stmt = Conexion.conectar().createStatement();		
		stmt.executeUpdate("INSERT INTO SANCIONES VALUES ("+ s.getDni()+ ",'" + s.getFecha() + "','" + s.getHora() + "','" + s.getMotivo() + "')");
		
		stmt.close();
		Conexion.desconectar();
}
	
	public static int deleteOne(int dni, String fecha, String hora) {
		int i = 0;
		try {
			Statement stmt = Conexion.conectar().createStatement();
			i = stmt.executeUpdate("DELETE FROM SANCIONES WHERE DNI = " + dni + " AND FECHA = '" + fecha + "' AND HORA = '" + hora + "'");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}
	
	public static void main(String[] args) {
		Sancion s = AccionesSancion.getOne(30685259, "2014-01-01", "09:00:00");		
		System.out.println(s.toString());
		
	}
}
