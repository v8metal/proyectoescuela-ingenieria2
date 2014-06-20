package conexion;

import java.sql.*;
import datos.*;

import conexion.Conexion;

public class AccionesMateria {
	
	public static Materias getAll() {
		Materias lista = new Materias();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM MATERIAS ORDER BY NOMBRE");
			Materia tmp;
			
			while (rs.next()) {
				tmp = new Materia(rs.getInt("cod_materia"), rs.getString("nombre"));
				lista.agregarMateria(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public static Materia getOne(int cod_materia) throws SQLException, Exception {
		Materia m = new Materia();
		int i = 0;
		
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM MATERIAS WHERE COD_MATERIA = '" + cod_materia + "'");
			
			while (rs.next()) {
				m = new Materia(rs.getInt("cod_materia"), rs.getString("nombre"));
				i = 1;
			}
			
			if (i == 0) {
				throw new SQLException();
			}
			stmt.close();
			Conexion.desconectar();
	
		return m;
	}
	
	public static int deleteOne(int cod_materia) throws SQLException, Exception {				//lanzo la excepcion asi puedo mostrar el error
		int i = 0;
//		try {
			Statement stmt = Conexion.conectar().createStatement();
			i = stmt.executeUpdate("DELETE FROM MATERIAS WHERE COD_MATERIA = '" + cod_materia + "'");
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		return i;
	}
	
	public static void insertOne(Materia m) throws SQLException, Exception {
			Statement stmt = Conexion.conectar().createStatement();
			stmt.executeUpdate("INSERT INTO MATERIAS VALUES ('" + m.getCod_materia() + "','" + m.getNombre() + "')");
			
			stmt.close();
			Conexion.desconectar();
	}
	
	public static void updateOne(int cod_materia, String nombre) throws SQLException, Exception {
			Statement stmt = Conexion.conectar().createStatement();
			stmt.executeUpdate("UPDATE MATERIAS SET NOMBRE = '" + nombre + "' WHERE COD_MATERIA = '" + cod_materia + "'");
			
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
			Materias ma = AccionesMateria.getAll();
			ma.listar();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}

}