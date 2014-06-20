package conexion;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import datos.Alumno;
import datos.Alumnos;
import datos.Citacion;
import datos.Citaciones;

public class AccionesCitacion {
	
	public static int boolToByte(boolean b) {
		byte r = (b == true? (byte)1 : (byte)0);
		return r;
	}
	
	public static Citaciones getAll(int año, int cod_maestro) {
		Citaciones lista = new Citaciones();
		try {
			Statement stmt = Conexion.conectar().createStatement();			
			ResultSet rs = stmt.executeQuery("SELECT C.DNI, AG.GRADO, AG.TURNO, C.FECHA, C.HORA, C.DESCRIP FROM CITACIONES AS C INNER JOIN ALUMNOS_GRADO AS AG ON (AG.DNI = C.DNI AND AG.AÑO = " + año + ") INNER JOIN MAESTROS_GRADO AS MG ON (MG.GRADO = AG.GRADO AND MG.TURNO = AG.TURNO) WHERE C.FECHA BETWEEN '" + año + "-01-01' AND '"+ año + "-12-31' AND (MG.COD_MAESTRO_TIT = " + cod_maestro + " OR MG.COD_MAESTRO_PAR = " + cod_maestro + ")" );			
			Citacion tmp;
			
			while (rs.next()) {
				tmp = new Citacion (rs.getInt("DNI"),rs.getString("GRADO"),rs.getString("TURNO"),rs.getString("FECHA"), rs.getString("HORA"), rs.getString("DESCRIP"));
				lista.agregarCitacion(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public static Citacion getOne(int dni, String fecha, String hora) {
		Citacion citacion = new Citacion();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM CITACIONES WHERE DNI = " + dni + " AND FECHA = '" + fecha + "' AND HORA = '" + hora + "'");
						
			while (rs.next()) {
				citacion = new Citacion(rs.getInt("DNI"), rs.getString("FECHA"), rs.getString("HORA"), rs.getString("DESCRIP"));				
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return citacion;
	}
	
	public static Alumnos getAlumnos(int año, int cod_maestro) {
		Alumnos lista = new Alumnos();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT A.* FROM MAESTROS_GRADO MG INNER JOIN ALUMNOS_GRADO AG ON(AG.GRADO = MG.GRADO AND AG.TURNO = MG.TURNO) INNER JOIN ALUMNOS A ON (A.DNI = AG.DNI) WHERE AG.AÑO = " + año + " AND (MG.COD_MAESTRO_TIT = " + cod_maestro + " OR MG.COD_MAESTRO_PAR = " + cod_maestro+ ")");
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
	
	
	public static void updateOne(int dni, String fecha, String hora, String fecha_update, String hora_update, String descripcion) throws SQLException, Exception {								
			Statement stmt = Conexion.conectar().createStatement();	
			stmt.executeUpdate("UPDATE CITACIONES SET FECHA = '" + fecha_update + "', HORA = '" + hora_update + "', DESCRIP = '" + descripcion + "' WHERE DNI = "+ dni + " AND FECHA = '" + fecha + "' AND HORA = '" + hora + "'");			
			stmt.close();
			Conexion.desconectar();
	}
		
	public static void insertOne(Citacion c) throws SQLException, Exception {
		Statement stmt = Conexion.conectar().createStatement();		
		//System.out.println("INSERT INTO CITACIONES VALUES ("+ c.getDni()+ /*"," + c.getCod_maestro() + */ ",'" + c.getFecha() + "','" + c.getHora() + "','" + c.getDescripcion() + "'," + boolToByte(c.getAbierto()) + ")");
		stmt.executeUpdate("INSERT INTO CITACIONES VALUES ("+ c.getDni()+ /*"," + c.getCod_maestro() + */ ",'" + c.getFecha() + "','" + c.getHora() + "','" + c.getDescripcion() + "')");
		
		stmt.close();
		Conexion.desconectar();
}
	
	public static int deleteOne(int dni, String fecha, String hora) {
		int i = 0;
		try {
			Statement stmt = Conexion.conectar().createStatement();
			i = stmt.executeUpdate("DELETE FROM CITACIONES WHERE DNI = " + dni + " AND FECHA = '" + fecha + "' AND HORA = '" + hora + "'");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}
	
	public static void main(String[] args) {
		
		AccionesCitacion.getAll(2014, 1).listar();
		
		AccionesCitacion.getAlumnos(2014, 1).listar();
	}

}
