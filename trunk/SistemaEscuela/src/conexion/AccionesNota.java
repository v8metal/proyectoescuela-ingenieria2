package conexion;

import java.sql.*;

import datos.*;

import conexion.Conexion;

public class AccionesNota {
	
	public static Notas getAll() {
		Notas lista = new Notas();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM NOTAS");
			Nota tmp;
			
			while (rs.next()) {
				tmp = new Nota(rs.getString("grado"), rs.getString("turno"),  rs.getInt("año"), rs.getInt("dni"), rs.getInt("cod_materia"), rs.getString("periodo"), rs.getInt("calific"));
				lista.agregarNota(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public static Nota getOne(String grado, String turno, int año, int dni, int cod_materia, String periodo) throws SQLException, Exception {
		Nota n = new Nota();
		int i = 0;
		
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM NOTAS WHERE GRADO = '" + grado + "' AND TURNO = '" + turno + "' AND AÑO = '" + año + "' AND DNI = '" + dni + "' AND COD_MATERIA = '" + cod_materia + "' AND PERIODO = '" + periodo + "'");
			
			while (rs.next()) {
				n = new Nota(rs.getString("grado"), rs.getString("turno"), rs.getInt("año"), rs.getInt("dni"), rs.getInt("cod_materia"), rs.getString("periodo"), rs.getInt("calific"));
				i = 1;
			}
			
			if (i == 0) {
				throw new SQLException();
			}
			stmt.close();
			Conexion.desconectar();
	
		return n;
	}
	
	public static boolean estaCargada(String grado, String turno, int año, int dni, int cod_materia, String periodo) throws SQLException, Exception {
		boolean b = false;
		
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM NOTAS WHERE GRADO = '" + grado + "' AND TURNO = '" + turno + "' AND AÑO = '" + año + "' AND DNI = '" + dni + "' AND COD_MATERIA = '" + cod_materia + "' AND PERIODO = '" + periodo + "'");
			
			while (rs.next()) {
				b = true;
			}
			
			stmt.close();
			Conexion.desconectar();
	
		return b;
	}
	
	public static int deleteOne(String grado, String turno, int año, int dni, int cod_materia, String periodo) {
		int i = 0;
		try {
			Statement stmt = Conexion.conectar().createStatement();
			i = stmt.executeUpdate("DELETE FROM NOTAS WHERE GRADO = '" + grado + "' AND TURNO = '" + turno + "' AND AÑO = '" + año + "' AND DNI = '" + dni + "' AND COD_MATERIA = '" + cod_materia + "' AND PERIODO = '" + periodo + "'");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}
	
	public static void insertOne(Nota n) throws SQLException, Exception {
		Statement stmt = Conexion.conectar().createStatement();
		stmt.executeUpdate("INSERT INTO NOTAS VALUES ('" + n.getGrado() + "','" + n.getTurno() + "','" + n.getAño() + "','" + n.getDni() + "','" + n.getCod_materia() + "','" + n.getPeriodo() + "','" + n.getCalific() + "')");
		
		stmt.close();
		Conexion.desconectar();
}
	
	public static void updateOne(String grado, String turno, int año, int dni, int cod_materia,  String periodo, int calific) throws SQLException, Exception {
			Statement stmt = Conexion.conectar().createStatement();
			stmt.executeUpdate("UPDATE NOTAS SET CALIFIC = '" + calific +  "' WHERE GRADO = '" + grado + "' AND TURNO = '" + turno + "' AND AÑO = '" + año + "' AND DNI = '" + dni + "' AND COD_MATERIA = '" + cod_materia + "' AND PERIODO = '" + periodo + "'");
			
			stmt.close();
			Conexion.desconectar();
	} 
	
	public static void main(String[] args) {	// getAll(), getOne(), insertOne(), updateOne() y deleteOne()  probadas correctamente
	
		try {
			
		//	Nota n = getOne(37041734, "4º", 7, "1º bimestre", 2011);
		//	System.out.println(n.toString());
			Nota nn = new Nota("6to", "mañana", 2014, 37041734, 3, "1er Bimestre", 7);
			insertOne(nn);
			System.out.println(nn);
		//	updateOne(37041734, "3º", 5, "1", 1, 9998888);
	//		deleteOne(37041734, "3º", 5, "1", 1);
	//		Nota n = AccionesNota.getOne(37041734, "6to", "tarde", 1, 2014, "2do bimestre");
			
			boolean b = estaCargada("6to", "mañana", 2014, 37041734,  1, "1er bimestre");
			System.out.println(b);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	
}