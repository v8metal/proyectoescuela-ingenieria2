package conexion;

import java.sql.*;

import conexion.Conexion;
import datos.Alumno;
import datos.Alumnos;
import datos.Grado;
import datos.Grados;
import datos.Materia;
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
			ResultSet rs = stmt.executeQuery("SELECT G.GRADO, G.TURNO, G.IND_EVALUACION, G.IND_BIM, G.SALON, IFNULL(MG2.AÑO, 0) AS AÑO, IFNULL(MG2.DNI_MAESTRO_TIT, 0) AS DNI_MAESTRO_TIT, IFNULL(MG2.DNI_MAESTRO_PAR, 0) AS DNI_MAESTRO_PAR FROM GRADOS G LEFT JOIN (SELECT MG.GRADO, MG.TURNO, MG.AÑO, MG.DNI_MAESTRO_TIT, MG.DNI_MAESTRO_PAR FROM MAESTROS_GRADO AS MG INNER JOIN (SELECT GRADO, TURNO, MAX(AÑO) AS AÑO FROM MAESTROS_GRADO GROUP BY GRADO, TURNO) AS MG1 ON (MG1.GRADO = MG.GRADO AND MG1.TURNO = MG.TURNO AND MG1.AÑO = MG.AÑO)) AS MG2 ON (MG2.grado = G.GRADO AND MG2.TURNO = G.TURNO) INNER JOIN GRADOS_BASE GB ON GB.GRADO = G.GRADO AND GB.TURNO = G.TURNO ORDER BY GB.ORDEN");
			Grado tmp;
			
			while (rs.next()) {
				tmp = new Grado(rs.getString("GRADO"), rs.getString("TURNO"), rs.getInt("IND_EVALUACION"), rs.getBoolean("IND_BIM"), rs.getString("SALON"), rs.getInt("AÑO"), rs.getInt("DNI_MAESTRO_TIT"),rs.getInt("DNI_MAESTRO_PAR"));
				lista.agregarGrado(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	//nuevo devuelve la lista de grados que no han sido dados de alta turno tarde
	public static Grados getPendingTarde() {
		
		Grados lista = new Grados();
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT GB.GRADO, GB.turno FROM GRADOS_BASE GB LEFT JOIN GRADOS G ON GB.GRADO = G.GRADO AND GB.Turno = G.TURNO WHERE GB.TURNO = 'TARDE' AND G.TURNO IS NULL ORDER BY GB.ORDEN");
			Grado tmp;
			
			while (rs.next()) {
				tmp = new Grado(rs.getString("GRADO"), rs.getString("TURNO"));
				lista.agregarGrado(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	//nuevo devuelve la lista de grados que no han sido dados de alta turno tarde

	//nuevo devuelve la lista de grados que no han sido dados de alta turno mañana
	public static Grados getPendingMañana() {
		
		Grados lista = new Grados();
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT GB.GRADO, GB.turno FROM GRADOS_BASE GB LEFT JOIN GRADOS G ON GB.GRADO = G.GRADO AND GB.Turno = G.TURNO WHERE GB.TURNO = 'MAÑANA' AND G.TURNO IS NULL ORDER BY GB.ORDEN");
			Grado tmp;
			
			while (rs.next()) {
				tmp = new Grado(rs.getString("GRADO"), rs.getString("TURNO"));
				lista.agregarGrado(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	//nuevo devuelve la lista de grados que no han sido dados de alta turno mañana
	
	//nuevo devuelve la lista de año y grados que tienen alumnos cargados para el cobro de cuotas
	public static Grados getAñoGradosCuota(int año) {
		
		Grados lista = new Grados();
					
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
			
			//System.out.println("SELECT DISTINCT AG.GRADO, AG.TURNO, AG.AÑO FROM ALUMNOS_GRADO AG INNER JOIN GRADOS_BASE GB ON AG.GRADO = GB.GRADO AND AG.TURNO = GB.TURNO WHERE AG.AÑO = "+ año + " ORDER BY GB.ORDEN");
			
			ResultSet rs = stmt.executeQuery("SELECT DISTINCT AG.GRADO, AG.TURNO, AG.AÑO FROM ALUMNOS_GRADO AG INNER JOIN GRADOS_BASE GB ON AG.GRADO = GB.GRADO AND AG.TURNO = GB.TURNO WHERE AG.AÑO = "+ año + " ORDER BY GB.ORDEN");
			Grado tmp;
			
			while (rs.next()) {
				tmp = new Grado(rs.getString("GRADO"), rs.getString("TURNO"),rs.getInt("AÑO"));
				lista.agregarGrado(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	//nuevo devuelve la lista de grados que tienen alumnos cargados para el año seleccionado - cobro de cuotas
	
	public static Grado getOne(String grado, String turno) {
		
		Grado g = null;
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
					
			ResultSet rs = stmt.executeQuery("SELECT * FROM GRADOS  WHERE GRADO = '" + grado + "' AND TURNO = '" + turno + "'");	
			
			while (rs.next()) {
				g = new Grado(rs.getString("GRADO"), rs.getString("TURNO"), rs.getInt("IND_EVALUACION"), rs.getBoolean("IND_BIM"), rs.getString("SALON"));
				
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
					
			ResultSet rs = stmt.executeQuery("SELECT G.GRADO, G.TURNO, G.IND_BIM, G.SALON, IFNULL(MG2.AÑO, 0) AS AÑO, IFNULL(MG2.DNI_MAESTRO_TIT, 0) AS DNI_MAESTRO_TIT, IFNULL(MG2.DNI_MAESTRO_PAR, 0) AS DNI_MAESTRO_PAR FROM GRADOS G LEFT JOIN (SELECT MG.GRADO, MG.TURNO, MG.AÑO, MG.DNI_MAESTRO_TIT, MG.DNI_MAESTRO_PAR FROM MAESTROS_GRADO AS MG INNER JOIN (SELECT GRADO, TURNO, MAX(AÑO) AS AÑO FROM MAESTROS_GRADO GROUP BY GRADO, TURNO) AS MG1 ON (MG1.GRADO = MG.GRADO AND MG1.TURNO = MG.TURNO AND MG1.AÑO = MG.AÑO)) AS MG2 ON (MG2.grado = G.GRADO AND MG2.TURNO = G.TURNO) WHERE G.GRADO = '" + grado + "'");	
			
			while (rs.next()) {
				g = new Grado(rs.getString("GRADO"), rs.getString("TURNO"), rs.getInt("IND_EVALUACION"), rs.getBoolean("IND_BIM"), rs.getString("SALON"), rs.getInt("AÑO"), rs.getInt("DNI_MAESTRO_TIT"),rs.getInt("DNI_MAESTRO_PAR"));				
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
			ResultSet rs = stmt.executeQuery("SELECT * FROM MATERIAS_GRADO WHERE GRADO = '" + grado + "'" );
			
			Materia materia;
			
			while (rs.next()) {
					
				materia = new Materia(rs.getString("MATERIA"), rs.getInt("IND_ESTADO"));
				materias.agregarMateria(materia);			
							
			}
			
			stmt.close();			
			Conexion.desconectar();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return materias;
	}
	
	public static MateriasGrado getMateriasByGradoTurnoYAño(String grado, String turno, int año) {			
		
		MateriasGrado materias  = new MateriasGrado();
			
			try {
				
				Statement stmt = Conexion.conectar().createStatement();
				ResultSet rs = stmt.executeQuery("SELECT M.MATERIA, M.IND_ESTADO FROM MATERIAS_GRADO MG INNER JOIN MATERIAS M ON M.MATERIA = MG.MATERIA WHERE MG.GRADO = '" + grado + "' AND MG.TURNO = '" + turno + "' AND MG.AÑO = '" + año + "'");
				
				Materia materia;
				
				while (rs.next()) {
						
					materia = new Materia(rs.getString("MATERIA"), rs.getInt("IND_ESTADO"));
					materias.agregarMateria(materia);		
								
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
	
	public static int deleteMateria(String grado, String turno, int año, String materia) throws SQLException, Exception  {     //lanzo la excepcion asi puedo mostrar el error
		int i = 0;
//		try {
			Statement stmt = Conexion.conectar().createStatement();			
			i = stmt.executeUpdate("DELETE FROM MATERIAS_GRADO WHERE GRADO = '"+ grado + "' AND TURNO = '"+ turno + "' AND AÑO = " + año + " AND MATERIA = '" + materia + "'");
			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		return i;
	}
	
	public static void asignarMateria(String grado, int materia) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();
		stmt.executeUpdate("INSERT INTO MATERIAS_GRADO VALUES ('" + grado + "'," + materia + ")");
			
		stmt.close();
		Conexion.desconectar();		
	}
	
	public static void updateOne(String grado, String turno, int evaluacion, boolean bimestre, String salon) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();
		
		stmt.executeUpdate("UPDATE GRADOS SET IND_EVALUACION =" + evaluacion + ", IND_BIM = '" + boolToByte(bimestre) + "', SALON = '" + salon + "' WHERE GRADO = '" + grado + "' AND TURNO = '" + turno + "'");
						
		stmt.close();
		Conexion.desconectar();		
	}
	
	public static void insertOne(Grado g) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();		
		stmt.executeUpdate("INSERT INTO GRADOS VALUES ('" + g.getGrado() + "', '" + g.getTurno()+ "', " + g.getEvaluacion() + ", '" + boolToByte(g.getBimestre()) + "', '" + g.getSalon() + "')");
					
		stmt.close();
		Conexion.desconectar();		
	}
	
	public static void insertAlumnoEnGrado(String grado, String turno, int dni, int año) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();		
		stmt.executeUpdate("INSERT INTO ALUMNOS_GRADO VALUES ('" + grado + "','" + turno + "'," + año + "," + dni + ")");
			
		stmt.close();
		Conexion.desconectar();	
	}
	
	public static int getCurrentYear(String grado, String turno) {
		
		int año = 0;
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT MAX(AÑO) AS AÑO FROM ALUMNOS_GRADO WHERE GRADO = '" + grado + "' AND TURNO = '"+ turno + "'" );
			
			
			while (rs.next()) {
				año = rs.getInt("AÑO");				
			}
			
			stmt.close();
			Conexion.desconectar();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return año;
	}
	
public static int getCurrentYear(Grado g) {
		
		int año = 0;
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT MAX(AÑO) AS AÑO FROM ALUMNOS_GRADO WHERE GRADO = '" + g.getGrado() + "' AND TURNO = '"+ g.getTurno() + "'" );
			
			
			while (rs.next()) {
				año = rs.getInt("AÑO");				
			}
			
			stmt.close();
			Conexion.desconectar();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return año;
	}

	public static Grado getOne(String grado, String turno, int año) {
		
		Grado g = null;
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
			
			ResultSet rs = stmt.executeQuery("SELECT DISTINCT G.GRADO, G.TURNO, G.IND_EVALUACION, G.IND_BIM, G.SALON, IFNULL(AG2.AÑO, 0) AS AÑO, IFNULL(MG2.DNI_MAESTRO_TIT, 0) AS DNI_MAESTRO_TIT, IFNULL(MG2.DNI_MAESTRO_PAR, 0) AS DNI_MAESTRO_PAR FROM GRADOS G LEFT JOIN (SELECT AG.GRADO, AG.TURNO, AG.AÑO FROM ALUMNOS_GRADO AS AG INNER JOIN (SELECT GRADO, TURNO, MAX(AÑO) AS AÑO FROM ALUMNOS_GRADO GROUP BY GRADO, TURNO) AS AG1 ON (AG1.GRADO = AG.GRADO AND AG1.TURNO = AG.TURNO AND AG1.AÑO = AG.AÑO)) AS AG2 ON (AG2.grado = G.GRADO AND AG2.TURNO = G.TURNO) LEFT JOIN (SELECT MG.GRADO, MG.TURNO, MG.AÑO, MG.DNI_MAESTRO_TIT, MG.DNI_MAESTRO_PAR FROM MAESTROS_GRADO AS MG INNER JOIN (SELECT GRADO, TURNO, MAX(AÑO) AS AÑO FROM MAESTROS_GRADO GROUP BY GRADO, TURNO) AS MG1 ON (MG1.GRADO = MG.GRADO AND MG1.TURNO = MG.TURNO AND MG1.AÑO = MG.AÑO)) AS MG2 ON (MG2.grado = G.GRADO AND MG2.TURNO = G.TURNO) WHERE G.GRADO = '" + grado + "' AND G.TURNO = '" + turno +"' AND AG2.AÑO = "+ año);			
			
			while (rs.next()) {
				g = new Grado(rs.getString("GRADO"), rs.getString("TURNO"), rs.getInt("IND_EVALUACION"), rs.getBoolean("IND_BIM"), rs.getString("SALON"), rs.getInt("AÑO"), rs.getInt("DNI_MAESTRO_TIT"),rs.getInt("DNI_MAESTRO_PAR"));				
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return g;
	}
	
	public static Alumnos getAlumnosGrado(String grado, String turno, int año){
	
		Alumnos lista = new Alumnos();
	
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT A.* FROM ALUMNOS AS A INNER JOIN ALUMNOS_GRADO AG ON (AG.DNI = A.DNI) WHERE AG.GRADO = '" + grado + "' AND AG.TURNO = '"+ turno + "' AND AG.AÑO = " + año );
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

	public static void promAlumnoGrado(String grado, String turno, int dni, int año) throws SQLException, Exception {
	
	Statement stmt = Conexion.conectar().createStatement();
	
	stmt.executeUpdate("INSERT INTO ALUMNOS_GRADO VALUES ('"+ grado + "','"+ turno + "'," + año +", " + dni + ")");
	
	//se insertan los mismos subsidios que el año en curso para el siguiente año
	stmt.executeUpdate("INSERT INTO ALUMNOS_SUBSIDIO SELECT AÑO+1, DNI, IND_GRUPO, IND_SUBSIDIO FROM ALUMNOS_SUBSIDIO WHERE DNI = " + dni + " AND AÑO = " + año);
	
	AccionesCertificado.insertOne(dni, año);	
		
	stmt.close();
	Conexion.desconectar();				
	}
	
	public static void insertMaestroGrado(String grado, String turno, int año, int titular, int paralelo) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();
		stmt.executeUpdate("INSERT INTO MAESTROS_GRADO VALUES ('" + grado + "', '" + turno +"', " + año + ", " + titular + ", " + paralelo + ")");
					
		stmt.close();
		Conexion.desconectar();		
	}
	
	public static void UpdateMaestroGrado(String grado, String turno, int año, int titular, int paralelo) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();
		stmt.executeUpdate("UPDATE MAESTROS_GRADO SET DNI_MAESTRO_TIT = " + titular + ", DNI_MAESTRO_PAR = " + paralelo + " WHERE GRADO = '" + grado + "' AND TURNO = '" + turno + "' AND AÑO =" + año);
					
		stmt.close();
		Conexion.desconectar();		
	}
	
	public static int getTitular(String grado, String turno, int año) {
		
		int maestro = 0;
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
					
			ResultSet rs = stmt.executeQuery("SELECT DNI_MAESTRO_TIT FROM MAESTROS_GRADO WHERE GRADO = '" + grado + "' AND TURNO = '" + turno + "' AND AÑO = " + año);	
			
			while (rs.next()) {
				maestro  = rs.getInt("DNI_MAESTRO_TIT");				
			}
			
			stmt.close();
			Conexion.desconectar();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return maestro;
	}
	
	public static int getParalelo(String grado, String turno, int año) {
		
		int maestro = 0;
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
					
			ResultSet rs = stmt.executeQuery("SELECT DNI_MAESTRO_PAR FROM MAESTROS_GRADO WHERE GRADO = '" + grado + "' AND TURNO = '" + turno + "' AND AÑO = " + año);	
			
			while (rs.next()) {
				maestro  = rs.getInt("DNI_MAESTRO_PAR");				
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
			i = stmt.executeUpdate("DELETE FROM MATERIAS_GRADO WHERE GRADO = '"+ grado + "' AND TURNO = '" + turno + "' AND COD_MATERIA = " + materia );
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return i;
	}

	public static MateriasGrado getMaterias(String grado, String turno, int año) {
		
		MateriasGrado materias  = new MateriasGrado();
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();			
			ResultSet rs = stmt.executeQuery("SELECT M.MATERIA, M.IND_ESTADO FROM MATERIAS_GRADO MG INNER JOIN MATERIAS M ON M.MATERIA = MG.MATERIA WHERE MG.GRADO = '" + grado + "' AND MG.TURNO = '" + turno + "' AND MG.AÑO = '" + año + "'");
			
			Materia materia;
			
			while (rs.next()) {
					
				materia = new Materia(rs.getString("MATERIA"), rs.getInt("IND_ESTADO"));
				materias.agregarMateria(materia);				
							
			}
			
			stmt.close();			
			Conexion.desconectar();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return materias;
	}
	
	public static void asignarMateria(String grado, String turno, int año, String materia) throws SQLException, Exception {
	
		Statement stmt = Conexion.conectar().createStatement();
		
		//System.out.println("INSERT INTO MATERIAS_GRADO VALUES ('" + grado + "','"+ turno + "'," + año + ", '" + materia + "')");
		
		stmt.executeUpdate("INSERT INTO MATERIAS_GRADO VALUES ('" + grado + "','"+ turno + "'," + año + ", '" + materia + "')");
		
		stmt.close();
		Conexion.desconectar();		
	}
	
	//devuelve la lista de grados para el año y el maestro seleccionado
		public static Grados getAñoGradosByMaestro(int año, int dni) {
			
			Grados lista = new Grados();
						
			try {
				
				Statement stmt = Conexion.conectar().createStatement();
				
				//System.out.println("SELECT DISTINCT AG.GRADO, AG.TURNO, AG.AÑO FROM ALUMNOS_GRADO AG INNER JOIN GRADOS_BASE GB ON AG.GRADO = GB.GRADO AND AG.TURNO = GB.TURNO WHERE AG.AÑO = "+ año + " ORDER BY GB.ORDEN");
				
				ResultSet rs = stmt.executeQuery("SELECT DISTINCT AG.GRADO, AG.TURNO, AG.AÑO FROM ALUMNOS_GRADO AG INNER JOIN GRADOS_BASE GB ON AG.GRADO = GB.GRADO AND AG.TURNO = GB.TURNO INNER JOIN MAESTROS_GRADO MG ON AG.GRADO = MG.GRADO AND AG.TURNO = MG.TURNO AND (MG.DNI_MAESTRO_TIT = " + dni + " OR DNI_MAESTRO_PAR = " + dni + ") WHERE AG.AÑO = '" + año + "' ORDER BY GB.ORDEN");
				Grado tmp;
				
				while (rs.next()) {
					tmp = new Grado(rs.getString("GRADO"), rs.getString("TURNO"),rs.getInt("AÑO"));
					lista.agregarGrado(tmp);
				}
				stmt.close();
				Conexion.desconectar();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return lista;
		}
		//nuevo devuelve la lista de grados que tienen alumnos cargados para el año seleccionado - cobro de cuotas
		
	
	public static void main(String[] args) throws SQLException, Exception {
		
//		MateriasGrado g = AccionesGrado.getMaterias("1ro");
//		g.listar();
//		insertAlumnoEnGrado("5to", "tarde", 37041734, 2015);
		
//		Grado g = getOneByGradoTurno("6to", "mañana");
//		System.out.println(g);
		
//		boolean b = g.getBimestre();
//		System.out.println(b);
		
		int res = AccionesGrado.getTitular("Sala 4", "MAÑANA", 2013);
		
		System.out.println(res);
	
	}
}