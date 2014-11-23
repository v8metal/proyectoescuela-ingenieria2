package conexion;

import java.sql.*;

import datos.*;

import conexion.Conexion;

public class AccionesNota {
	
	public static Nota getNota(int año, int dni, String materia, String periodo) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();
		
		//System.out.println("SELECT * FROM NOTAS WHERE AÑO = " + año + " AND DNI = " + dni + " AND MATERIA = '" + materia + "' AND PERIODO = '" + periodo + "'");
		
		ResultSet rs = stmt.executeQuery("SELECT * FROM NOTAS WHERE AÑO = " + año + " AND DNI = " + dni + " AND MATERIA = '" + materia + "' AND PERIODO = '" + periodo + "'");
		
		Nota n = null;
		
		while (rs.next()) {
			n = new Nota(rs.getString("GRADO"), rs.getString("TURNO"), rs.getInt("AÑO"), rs.getInt("DNI"), rs.getString("MATERIA"), rs.getString("PERIODO"), rs.getString("CALIFIC"));
		
		}
		
		stmt.close();
		Conexion.desconectar();
	
		return n;
	}
	
	public static String getCalific(int año, int dni, String materia, String periodo) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();
		
		//System.out.println("SELECT CALIFIC FROM NOTAS WHERE AÑO = " + año + " AND DNI = " + dni + " AND MATERIA = '" + materia + "' AND PERIODO = '" + periodo + "'");
		
		ResultSet rs = stmt.executeQuery("SELECT CALIFIC FROM NOTAS WHERE AÑO = " + año + " AND DNI = " + dni + " AND MATERIA = '" + materia + "' AND PERIODO = '" + periodo + "'");
		
		String nota = "S/C";
		
		while (rs.next()) {
			nota = rs.getString("CALIFIC");
		
		}
		
		stmt.close();
		Conexion.desconectar();
	
		return nota;
	}
	
	public static boolean estaCargada(Nota n) throws SQLException, Exception {

		boolean b = false;
		
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM NOTAS WHERE GRADO = '" + n.getGrado() + "' AND TURNO = '" + n.getTurno() + "' AND AÑO = '" + n.getAño() + "' AND DNI = '" + n.getDni() + "' AND MATERIA = '" + n.getMateria() + "' AND PERIODO = '" + n.getPeriodo() + "'");
			
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
	
	public static void insertNota(Nota n) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();
		
		//System.out.println("INSERT INTO NOTAS VALUES ('" + n.getGrado() + "','" + n.getTurno() + "','" + n.getAño() + "','" + n.getDni() + "','" + n.getMateria() + "','" + n.getPeriodo() + "','" + n.getCalific() + "')");
		
		stmt.executeUpdate("INSERT INTO NOTAS VALUES ('" + n.getGrado() + "','" + n.getTurno() + "','" + n.getAño() + "','" + n.getDni() + "','" + n.getMateria() + "','" + n.getPeriodo() + "','" + n.getCalific() + "')");
		
		stmt.close();
		Conexion.desconectar();
	}
	
	public static void updateNota(Nota n) throws SQLException, Exception {
			
			Statement stmt = Conexion.conectar().createStatement();
			
			//System.out.println("UPDATE NOTAS SET CALIFIC = '" + n.getCalific() +  "' WHERE GRADO = '" + n.getGrado() + "' AND TURNO = '" + n.getTurno() + "' AND AÑO = '" + n.getAño() + "' AND DNI = '" + n.getDni() + "' AND MATERIA = '" + n.getMateria() + "' AND PERIODO = '" + n.getPeriodo() + "'");
			
			stmt.executeUpdate("UPDATE NOTAS SET CALIFIC = '" + n.getCalific() +  "' WHERE GRADO = '" + n.getGrado() + "' AND TURNO = '" + n.getTurno() + "' AND AÑO = '" + n.getAño() + "' AND DNI = '" + n.getDni() + "' AND MATERIA = '" + n.getMateria() + "' AND PERIODO = '" + n.getPeriodo() + "'");
			
			stmt.close();
			Conexion.desconectar();
	} 
	
	public static Informe getInforme(int año, int dni) throws SQLException, Exception {
		
		Informe i = new Informe();
		
		Statement stmt = Conexion.conectar().createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM INFORMES WHERE AÑO = " + año + " AND DNI = " + dni );
			
		while (rs.next()) {
			i = new Informe(rs.getString("GRADO"), rs.getString("TURNO"), rs.getInt("AÑO"), rs.getInt("DNI"),rs.getString("MARZO"), rs.getString("MEDIO_AÑO"), rs.getString("FIN_AÑO"));			
		}
				
		stmt.close();
		Conexion.desconectar();
	
		return i;
	}
	
	public static void insertInforme(Informe i) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();
		
		//System.out.println("INSERT INTO INFORMES VALUES ('" + i.getGrado() + "','" + i.getTurno() + "', " + i.getAño() + " , " + i.getDni() + " ,'" + i.getMarzo() + "','" + i.getMitad() + "','" + i.getFin() + "')");
		
		stmt.executeUpdate("INSERT INTO INFORMES VALUES ('" + i.getGrado() + "','" + i.getTurno() + "', " + i.getAño() + " , " + i.getDni() + " ,'" + i.getMarzo() + "','" + i.getMitad() + "','" + i.getFin() + "')");
		
		stmt.close();
		Conexion.desconectar();
	}
	
	public static void updateInforme(Informe i, int numero) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();
		
		String informe = "";
		
		switch(numero){
		
		case 1:
			informe = "MARZO = '" + i.getMarzo() + "' ";
			break;
		case 2:
			informe = "MEDIO_AÑO = '" + i.getMitad() + "' ";
			break;
		case 3:
			informe = "FIN_AÑO = '" + i.getFin() + "' ";
			break;
		}
		
		//System.out.println("UPDATE INFORMES SET " + informe + " WHERE GRADO = '" + i.getGrado() + "' AND TURNO = '" + i.getTurno() + "' AND AÑO = " + i.getAño() + " AND DNI = " + i.getDni());
		
		stmt.executeUpdate("UPDATE INFORMES SET " + informe + " WHERE GRADO = '" + i.getGrado() + "' AND TURNO = '" + i.getTurno() + "' AND AÑO = " + i.getAño() + " AND DNI = " + i.getDni() );
		
		stmt.close();
		Conexion.desconectar();
} 

	
	public static void main(String[] args) {	// getAll(), getOne(), insertOne(), updateOne() y deleteOne()  probadas correctamente
	
		try {
			
		//	Nota n = getOne(37041734, "4º", 7, "1º bimestre", 2011);
		//	System.out.println(n.toString());
			//Nota nn = new Nota("6to", "mañana", 2014, 37041734, 3, "1er Bimestre", 7);
			//insertOne(nn);
			//System.out.println(nn);
		//	updateOne(37041734, "3º", 5, "1", 1, 9998888);
	//		deleteOne(37041734, "3º", 5, "1", 1);
	//		Nota n = AccionesNota.getOne(37041734, "6to", "tarde", 1, 2014, "2do bimestre");
			
			//boolean b = estaCargada("6to", "mañana", 2014, 37041734,  1, "1er bimestre");
			//System.out.println(b);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	
}