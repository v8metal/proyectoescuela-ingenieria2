package conexion;

import java.sql.*;

import conexion.Conexion;
import datos.Alumno;
import datos.Alumnos;
import datos.Grado;
import datos.Grados;
import datos.MateriasGrado;

public class AccionesGrado {
	
	public static int boolToByte(boolean b) {
		byte r = (b == true? (byte)1 : (byte)0);
		return r;
	}
	
	public static Grados getAll() {
		
		Grados lista = new Grados();
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT G.GRADO, G.TURNO, G.IND_BIM, G.SALON, IFNULL(MG2.A�O, 0) AS A�O, IFNULL(MG2.COD_MAESTRO_TIT, 0) AS COD_MAESTRO_TIT, IFNULL(MG2.COD_MAESTRO_PAR, 0) AS COD_MAESTRO_PAR FROM GRADOS G LEFT JOIN (SELECT MG.GRADO, MG.TURNO, MG.A�O, MG.COD_MAESTRO_TIT, MG.COD_MAESTRO_PAR FROM MAESTROS_GRADO AS MG INNER JOIN (SELECT GRADO, TURNO, MAX(A�O) AS A�O FROM MAESTROS_GRADO GROUP BY GRADO, TURNO) AS MG1 ON (MG1.GRADO = MG.GRADO AND MG1.TURNO = MG.TURNO AND MG1.A�O = MG.A�O)) AS MG2 ON (MG2.grado = G.GRADO AND MG2.TURNO = G.TURNO)");
			Grado tmp;
			
			while (rs.next()) {
				tmp = new Grado(rs.getString("GRADO"), rs.getString("TURNO"), rs.getBoolean("IND_BIM"), rs.getString("SALON"), rs.getInt("A�O"), rs.getInt("COD_MAESTRO_TIT"),rs.getInt("COD_MAESTRO_PAR"));
				lista.agregarGrado(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public static Grado getOne(String grado, String turno) {
		
		Grado g = null;
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
					
			ResultSet rs = stmt.executeQuery("SELECT * FROM GRADOS  WHERE GRADO = '" + grado + "' AND TURNO = '" + turno + "'");	
			
			while (rs.next()) {
				//g = new Grado(rs.getString("GRADO"), rs.getString("TURNO"), rs.getBoolean("IND_BIM"), rs.getString("SALON"), rs.getInt("A�O"), rs.getInt("COD_MAESTRO_TIT"),rs.getInt("COD_MAESTRO_PAR"));
				g = new Grado(rs.getString("GRADO"), rs.getString("TURNO"), rs.getBoolean("IND_BIM"), rs.getString("SALON"), 0, 0, 0);
				
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return g;
	}

	
	public static Grado getOne(String grado) {
		
		Grado g = null;
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
					
			ResultSet rs = stmt.executeQuery("SELECT G.GRADO, G.TURNO, G.IND_BIM, G.SALON, IFNULL(MG2.A�O, 0) AS A�O, IFNULL(MG2.COD_MAESTRO_TIT, 0) AS COD_MAESTRO_TIT, IFNULL(MG2.COD_MAESTRO_PAR, 0) AS COD_MAESTRO_PAR FROM GRADOS G LEFT JOIN (SELECT MG.GRADO, MG.TURNO, MG.A�O, MG.COD_MAESTRO_TIT, MG.COD_MAESTRO_PAR FROM MAESTROS_GRADO AS MG INNER JOIN (SELECT GRADO, TURNO, MAX(A�O) AS A�O FROM MAESTROS_GRADO GROUP BY GRADO, TURNO) AS MG1 ON (MG1.GRADO = MG.GRADO AND MG1.TURNO = MG.TURNO AND MG1.A�O = MG.A�O)) AS MG2 ON (MG2.grado = G.GRADO AND MG2.TURNO = G.TURNO) WHERE G.GRADO = '" + grado + "'");	
			
			while (rs.next()) {
				g = new Grado(rs.getString("GRADO"), rs.getString("TURNO"), rs.getBoolean("IND_BIM"), rs.getString("SALON"), rs.getInt("A�O"), rs.getInt("COD_MAESTRO_TIT"),rs.getInt("COD_MAESTRO_PAR"));				
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return g;
	}

	
	/*
	public static Grado getOneByGradoTurno(String grado, String turno) {	
		
		Grado g = null;
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM GRADOS WHERE GRADO = '" + grado + "' AND TURNO = '" + turno + "'");
			
			
			while (rs.next()) {
				g = new Grado(rs.getString("GRADO"), rs.getString("TURNO"), rs.getBoolean("IND_BIM"), rs.getString("SALON"), rs.getInt("COD_MAEST_TIT"),rs.getInt("COD_MAEST_PAR"));				
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return g;
	}
	*/
	
	public static MateriasGrado getMaterias(String grado) {			
		
		MateriasGrado materias  = new MateriasGrado();
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM MAT_GRADO WHERE GRADO = '" + grado + "'" );
			
			int cod_mat;
			
			while (rs.next()) {
					
				cod_mat = rs.getInt("COD_MATERIA");
				materias.agregarMateria(cod_mat);			
							
			}
			
			stmt.close();			
			Conexion.desconectar();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return materias;
	}
	
	public static MateriasGrado getMateriasByGradoTurnoYA�o(String grado, String turno, int a�o) {			
		
		MateriasGrado materias  = new MateriasGrado();
			
			try {
				
				Statement stmt = Conexion.conectar().createStatement();
				ResultSet rs = stmt.executeQuery("SELECT * FROM MAT_GRADO WHERE GRADO = '" + grado + "' AND TURNO = '" + turno + "' AND A�O = '" + a�o + "'");
				
				int cod_mat;
				
				while (rs.next()) {
						
					cod_mat = rs.getInt("COD_MATERIA");
					materias.agregarMateria(cod_mat);			
								
				}
				
				stmt.close();			
				Conexion.desconectar();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return materias;
		}

	public static int deleteOne(Grado g) {
		int i = 0;
		try {
			Statement stmt = Conexion.conectar().createStatement();
			i = stmt.executeUpdate("DELETE FROM GRADOS WHERE GRADO = '" + g.getGrado() + "' AND TURNO = '" + g.getTurno() + "'");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}
	
	public static int deleteMateria(String grado, String turno, int a�o, int materia) throws SQLException, Exception  {     //lanzo la excepcion asi puedo mostrar el error
		int i = 0;
//		try {
			Statement stmt = Conexion.conectar().createStatement();			
			i = stmt.executeUpdate("DELETE FROM MAT_GRADO WHERE GRADO = '"+ grado + "' AND TURNO = '"+ turno + "' AND A�O = " + a�o + " AND COD_MATERIA = " + materia );
			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		return i;
	}
	
	public static void asignarMateria(String grado, int materia) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();
		stmt.executeUpdate("INSERT INTO MAT_GRADO VALUES ('" + grado + "'," + materia + ")");
			
		stmt.close();
		Conexion.desconectar();		
	}
	
	public static void updateOne(String grado, String turno, boolean bimestre, String salon) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();
	
		stmt.executeUpdate("UPDATE GRADOS SET IND_BIM = '" + boolToByte(bimestre) + "', SALON = '" + salon + "' WHERE GRADO = '" + grado + "' AND TURNO = '" + turno + "'");
					
		stmt.close();
		Conexion.desconectar();		
	}
	
	public static void insertOne(Grado g) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();		
		stmt.executeUpdate("INSERT INTO GRADOS VALUES ('" + g.getGrado() + "', '" + g.getTurno()+"', '" + boolToByte(g.getBimestre()) + "', '" + g.getSalon() + "')");
					
		stmt.close();
		Conexion.desconectar();		
	}
	
	public static void insertAlumnoEnGrado(String grado, String turno, int dni, int a�o) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();
		stmt.executeUpdate("INSERT INTO ALUMNOS_GRADO VALUES ('" + grado + "','" + turno + "','" + dni + "','" + a�o + "')");
			
		stmt.close();
		Conexion.desconectar();	
	}
	
	public static int getCurrentYear(String grado, String turno) {
		
		int a�o = 0;
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT MAX(A�O) AS A�O FROM ALUMNOS_GRADO WHERE GRADO = '" + grado + "' AND TURNO = '"+ turno + "'" );
			
			
			while (rs.next()) {
				a�o = rs.getInt("A�O");				
			}
			
			stmt.close();
			Conexion.desconectar();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return a�o;
	}
	
public static int getCurrentYear(Grado g) {
		
		int a�o = 0;
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT MAX(A�O) AS A�O FROM ALUMNOS_GRADO WHERE GRADO = '" + g.getGrado() + "' AND TURNO = '"+ g.getTurno() + "'" );
			
			
			while (rs.next()) {
				a�o = rs.getInt("A�O");				
			}
			
			stmt.close();
			Conexion.desconectar();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return a�o;
	}

	public static Grado getOne(String grado, String turno, int a�o) {
		
		Grado g = null;
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
			
			ResultSet rs = stmt.executeQuery("SELECT DISTINCT G.GRADO, G.TURNO, G.IND_BIM, G.SALON, IFNULL(AG2.A�O, 0) AS A�O, IFNULL(MG2.COD_MAESTRO_TIT, 0) AS COD_MAESTRO_TIT, IFNULL(MG2.COD_MAESTRO_PAR, 0) AS COD_MAESTRO_PAR FROM GRADOS G LEFT JOIN (SELECT AG.GRADO, AG.TURNO, AG.A�O FROM ALUMNOS_GRADO AS AG INNER JOIN (SELECT GRADO, TURNO, MAX(A�O) AS A�O FROM ALUMNOS_GRADO GROUP BY GRADO, TURNO) AS AG1 ON (AG1.GRADO = AG.GRADO AND AG1.TURNO = AG.TURNO AND AG1.A�O = AG.A�O)) AS AG2 ON (AG2.grado = G.GRADO AND AG2.TURNO = G.TURNO) LEFT JOIN (SELECT MG.GRADO, MG.TURNO, MG.A�O, MG.COD_MAESTRO_TIT, MG.COD_MAESTRO_PAR FROM MAESTROS_GRADO AS MG INNER JOIN (SELECT GRADO, TURNO, MAX(A�O) AS A�O FROM MAESTROS_GRADO GROUP BY GRADO, TURNO) AS MG1 ON (MG1.GRADO = MG.GRADO AND MG1.TURNO = MG.TURNO AND MG1.A�O = MG.A�O)) AS MG2 ON (MG2.grado = G.GRADO AND MG2.TURNO = G.TURNO) WHERE G.GRADO = '" + grado + "' AND G.TURNO = '" + turno +"' AND AG2.A�O = "+ a�o);			
			
			while (rs.next()) {
				g = new Grado(rs.getString("GRADO"), rs.getString("TURNO"), rs.getBoolean("IND_BIM"), rs.getString("SALON"), rs.getInt("A�O"), rs.getInt("COD_MAESTRO_TIT"),rs.getInt("COD_MAESTRO_PAR"));				
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return g;
	}
	
	public static Alumnos getAlumnosGrado(String grado, String turno, int a�o){
	
		Alumnos lista = new Alumnos();
	
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT A.* FROM ALUMNOS AS A INNER JOIN ALUMNOS_GRADO AG ON (AG.DNI = A.DNI) WHERE AG.GRADO = '" + grado + "' AND AG.TURNO = '"+ turno + "' AND AG.A�O = " + a�o );
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

	public static void promAlumnoGrado(String grado, String turno, int dni, int a�o) throws SQLException, Exception {
	
	Statement stmt = Conexion.conectar().createStatement();
	stmt.executeUpdate("INSERT INTO ALUMNOS_GRADO VALUES ('"+ grado + "','"+ turno + "'," + a�o +", " + dni + ")");
		
	stmt.close();
	Conexion.desconectar();				
	}
	
	public static void insertMaestroGrado(String grado, String turno, int a�o, int titular, int paralelo) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();
		stmt.executeUpdate("INSERT INTO MAESTROS_GRADO VALUES ('" + grado + "', '" + turno +"', " + a�o + ", " + titular + ", " + paralelo + ")");
					
		stmt.close();
		Conexion.desconectar();		
	}
	
	public static void UpdateMaestroGrado(String grado, String turno, int a�o, int titular, int paralelo) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();
		stmt.executeUpdate("UPDATE MAESTROS_GRADO SET COD_MAESTRO_TIT = " + titular + ", COD_MAESTRO_PAR = " + paralelo + " WHERE GRADO = '" + grado + "' AND TURNO = '" + turno + "' AND A�O =" + a�o);
					
		stmt.close();
		Conexion.desconectar();		
	}
	
	public static int getTitular(String grado, String turno, int a�o) {
		
		int maestro = 0;
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
					
			ResultSet rs = stmt.executeQuery("SELECT COD_MAESTRO_TIT FROM MAESTROS_GRADO WHERE GRADO = '" + grado + "' AND TURNO = '" + turno + "' AND A�O = " + a�o);	
			
			while (rs.next()) {
				maestro  = rs.getInt("COD_MAESTRO_TIT");				
			}
			
			stmt.close();
			Conexion.desconectar();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return maestro;
	}
	
	public static int getParalelo(String grado, String turno, int a�o) {
		
		int maestro = 0;
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
					
			ResultSet rs = stmt.executeQuery("SELECT COD_MAESTRO_PAR FROM MAESTROS_GRADO WHERE GRADO = '" + grado + "' AND TURNO = '" + turno + "' AND A�O = " + a�o);	
			
			while (rs.next()) {
				maestro  = rs.getInt("COD_MAESTRO_PAR");				
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return maestro;
	}
	
	public static int deleteMateria(String grado, String turno, int materia) {
		
		int i = 0;
		
		try {
			Statement stmt = Conexion.conectar().createStatement();
			i = stmt.executeUpdate("DELETE FROM MAT_GRADO WHERE GRADO = '"+ grado + "' AND TURNO = '" + turno + "' AND COD_MATERIA = " + materia );
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return i;
	}

	public static MateriasGrado getMaterias(String grado, String turno, int a�o) {
		
		MateriasGrado materias  = new MateriasGrado();
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();			
			ResultSet rs = stmt.executeQuery("SELECT * FROM MAT_GRADO WHERE GRADO = '" + grado + "' AND TURNO = '" + turno + "' AND A�O = " + a�o );
			
			int cod_mat;
			
			while (rs.next()) {
					
				cod_mat = rs.getInt("COD_MATERIA");
				materias.agregarMateria(cod_mat);			
							
			}
			
			stmt.close();			
			Conexion.desconectar();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return materias;
	}
	
	public static void asignarMateria(String grado, String turno, int a�o, int materia) throws SQLException, Exception {
	
		Statement stmt = Conexion.conectar().createStatement();
		stmt.executeUpdate("INSERT INTO MAT_GRADO VALUES ('" + grado + "','"+ turno + "'," + a�o + "," + materia + ")");
		
		stmt.close();
		Conexion.desconectar();		
	}
	
	public static void main(String[] args) throws SQLException, Exception {
		
//		MateriasGrado g = AccionesGrado.getMaterias("1ro");
//		g.listar();
//		insertAlumnoEnGrado("5to", "tarde", 37041734, 2015);
		
//		Grado g = getOneByGradoTurno("6to", "ma�ana");
//		System.out.println(g);
		
//		boolean b = g.getBimestre();
//		System.out.println(b);
		
		int res = AccionesGrado.getTitular("Sala 4", "MA�ANA", 2013);
		
		System.out.println(res);
	
	}
}