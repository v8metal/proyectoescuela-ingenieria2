package conexion;

import java.sql.*;
import java.util.Calendar;

import datos.*;
import conexion.Conexion;

public class AccionesMateria {
	
	public static Materias getAllActivas() {
		Materias lista = new Materias();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM MATERIAS WHERE IND_ESTADO = 1 ORDER BY MATERIA");
			Materia tmp;
			
			while (rs.next()) {
				tmp = new Materia(rs.getString("MATERIA"), rs.getInt("IND_ESTADO"));
				lista.agregarMateria(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public static Materias getAllInactivas() {
		Materias lista = new Materias();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM MATERIAS WHERE IND_ESTADO = 0 ORDER BY MATERIA");
			Materia tmp;
			
			while (rs.next()) {
				tmp = new Materia(rs.getString("MATERIA"), rs.getInt("IND_ESTADO"));
				lista.agregarMateria(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public static Materia getOne(String materia) throws SQLException, Exception {
		Materia m = new Materia();
		int i = 0;
		
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM MATERIAS WHERE MATERIA = '" + materia + "'");
			
			while (rs.next()) {
				m = new Materia(rs.getString("MATERIA"), rs.getInt("IND_ESTADO"));
				i = 1;
			}
			
			if (i == 0) {
				throw new SQLException();
			}
			stmt.close();
			Conexion.desconectar();
	
		return m;
	}
	
	public static int deleteOne(String materia) throws SQLException, Exception {				//lanzo la excepcion asi puedo mostrar el error
		int i = 0;
//		try {
			Statement stmt = Conexion.conectar().createStatement();
			i = stmt.executeUpdate("DELETE FROM MATERIAS WHERE MATERIA = '" + materia + "'");
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		return i;
	}
	
	public static void insertOne(Materia m) throws SQLException, Exception {
			Statement stmt = Conexion.conectar().createStatement();
			stmt.executeUpdate("INSERT INTO MATERIAS VALUES ('" + m.getMateria() + "', " + m.getEstado() + ")");
			
			stmt.close();
			Conexion.desconectar();
	}
	
	public static int bajaLogicaMateria(String materia) throws SQLException, Exception {
			
			Statement stmt = Conexion.conectar().createStatement();
		
			Calendar c = Calendar.getInstance();
			
			int i = 0;
			
			ResultSet rs = stmt.executeQuery("SELECT COUNT(1) AS COUNT FROM MATERIAS_GRADO WHERE MATERIA = '" + materia + "' AND AÑO = " + Integer.toString(c.get(Calendar.YEAR)) );
			
			while (rs.next()) {
				i = rs.getInt("COUNT");					
			}
			
			if (i == 0){
			
				stmt.executeUpdate("UPDATE MATERIAS SET IND_ESTADO = 0  WHERE MATERIA = '" + materia + "'");
			
			}else{
				
				throw new CustomException();
			}
			
			stmt.close();
			Conexion.desconectar();
			
			return i;
	} 
	
	public static void activarMateria(String materia) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();
					
		stmt.executeUpdate("UPDATE MATERIAS SET IND_ESTADO = 1  WHERE MATERIA = '" + materia + "'");
		
		stmt.close();
		Conexion.desconectar();		
	} 

	public static void main(String[] args) {	// getAll(), getOne(), insertOne(), updateOne() y deleteOne()  probadas correctamente
		
		try {
			
		//	Materia m = getOne(1);
		//	System.out.println(m.toString());
		//	Materia mm = new Materia(8, "1");
		//	insertOne(mm);
		//	updateOne(8, "15556");
		//	deleteOne(8);
			Materias ma = AccionesMateria.getAllActivas();
			ma.listar();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}

}