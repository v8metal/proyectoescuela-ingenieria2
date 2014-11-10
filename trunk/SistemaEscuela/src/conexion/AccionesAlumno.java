package conexion;

import java.sql.*;

import datos.Alumnos_Grados;
import datos.Alumno_Grado;
import datos.Alumno;
import conexion.Conexion;
import datos.*;

public class AccionesAlumno {
	
	public static Alumnos_Grados getAllAlumnos_Grado(String grado, String turno) throws Exception{
		Alumnos_Grados alumnos = new Alumnos_Grados();
		try{
			Statement stm = Conexion.conectar().createStatement();
			ResultSet rs = stm.executeQuery("SELECT * FROM ALUMNOS_GRADO WHERE GRADO='"+grado+"' AND TURNO='"+turno+"' AND AÑO=YEAR(CURDATE())");
			Alumno_Grado alumno;
			while(rs.next()){
				alumno = new Alumno_Grado(rs.getString("GRADO"),rs.getString("TURNO"),rs.getInt("DNI"),rs.getInt("AÑO"));
				alumnos.agregarAlumno_Grado(alumno);
			}
			stm.close();
			rs.close();
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println("ERROR SQL!!!");
		}
		return alumnos;
	}
	
	public static Alumnos_Grados getAllAlumnos_GradoAño(String grado, String turno,int año) throws Exception{
		Alumnos_Grados alumnos = new Alumnos_Grados();
		try{
			Statement stm = Conexion.conectar().createStatement();
			ResultSet rs = stm.executeQuery("SELECT * FROM ALUMNOS_GRADO WHERE GRADO='"+grado+"' AND TURNO='"+turno+"' AND AÑO="+año);
			Alumno_Grado alumno;
			while(rs.next()){
				alumno = new Alumno_Grado(rs.getString("GRADO"),rs.getString("TURNO"),rs.getInt("DNI"),rs.getInt("AÑO"));
				alumnos.agregarAlumno_Grado(alumno);
			}
			stm.close();
			rs.close();
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println("ERROR SQL!!!");
		}
		return alumnos;
	}
	
	public static Alumno_Grado getOneAlumno_Grado(int dni) throws Exception{
		Alumno_Grado a=null;
		try{
			Statement stm = Conexion.conectar().createStatement();
			ResultSet rs = stm.executeQuery("SELECT * FROM ALUMNOS_GRADO WHERE DNI="+dni+" AND AÑO=YEAR(CURDATE())");
			while(rs.next()){
				a = new Alumno_Grado(rs.getString("GRADO"),rs.getString("TURNO"),rs.getInt("DNI"),rs.getInt("AÑO"));
			}
			stm.close();rs.close();Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println(sqle);
		}
		return a;
	}
	
	public static Alumno getOneAlumno(int dni) throws Exception{
		Alumno a=null;
		try{
			Statement stm = Conexion.conectar().createStatement();
			ResultSet rs = stm.executeQuery("SELECT * FROM ALUMNOS WHERE DNI="+dni);
			while(rs.next()){
				a = new Alumno(rs.getInt("DNI"),rs.getString("NOMBRE"),rs.getString("APELLIDO"),rs.getString("DOMICILIO"),rs.getString("TELEFONO"),rs.getString("FECHA_NAC"),rs.getString("LUGAR_NAC"),rs.getInt("DNI_TUTOR"),rs.getInt("DNI_MADRE"),rs.getInt("CANT_HER_MAY"),rs.getInt("CANT_HER_MEN"),rs.getString("IGLESIA"),rs.getString("ESC"), false , false); //modificado Ale
			}
			stm.close();
			rs.close();
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println("ERROR SQL!!!");
		}	
		return a;
	}
	
	//PARA EL COBRO DE CUOTAS - DETERMINA EL TIPO DE COBRO DEL ALUMNO EN EL AÑO
	public static String getTipoCobro(int dni, int año) throws Exception{
		
		String tipo = "REGULAR";
		
		try{
			Statement stm = Conexion.conectar().createStatement();
									
			ResultSet rs = stm.executeQuery("SELECT A1.IND_GRUPO, A1.IND_SUBSIDIO, IFNULL(M.DNI,0) as MAESTRODNI FROM ALUMNOS A INNER JOIN ALUMNOS_SUBSIDIO A1 ON A.DNI = A1.DNI LEFT JOIN MAESTROS M on (M.DNI = A.DNI_TUTOR or M.DNI = DNI_MADRE) WHERE A.DNI = " + dni + " AND AÑO = " + año);
			
			int grupo = 0;
			int subsidio = 0;
			int maestroDni = 0;
			
			while(rs.next()){
				grupo = rs.getInt("IND_GRUPO");
				subsidio = rs.getInt("IND_SUBSIDIO");
				maestroDni = rs.getInt("MAESTRODNI");				
			}
			
			if (grupo == 1) tipo = "GRUPO";
			if (subsidio == 1) tipo = "SUBSIDIO";
			if (maestroDni != 0) tipo = "HIJO MAESTRO";
			
			stm.close();
			rs.close();
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println("ERROR SQL!!!");
		}	
		return tipo;
	}	
	//PARA EL COBRO DE CUOTAS - DETERMINA EL TIPO DE COBRO DEL ALUMNO
	
	public static Alumnos getAll() {
		Alumnos lista = new Alumnos();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM ALUMNOS ORDER BY APELLIDO");
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
	
	public static Alumnos getAllByTurnoYAño(String turno, int año) {
		Alumnos lista = new Alumnos();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			
			//System.out.println("SELECT A.DNI, A.NOMBRE, A.APELLIDO, A.DOMICILIO, A.TELEFONO, A.FECHA_NAC, A.LUGAR_NAC, A.DNI_TUTOR, A.DNI_MADRE, A.CANT_HER_MAY, A.CANT_HER_MEN, A.IGLESIA, A.ESC, ASUB.IND_GRUPO, ASUB.IND_SUBSIDIO FROM ALUMNOS A INNER JOIN ALUMNOS_GRADO AG ON AG.DNI = A.DNI AND AG.AÑO = " + año + " AND AG.TURNO = '" + turno + "' INNER JOIN ALUMNOS_SUBSIDIO ASUB ON ASUB.DNI = AG.DNI AND ASUB.AÑO = AG.AÑO ORDER BY A.APELLIDO");
			
			ResultSet rs = stmt.executeQuery("SELECT A.DNI, A.NOMBRE, A.APELLIDO, A.DOMICILIO, A.TELEFONO, A.FECHA_NAC, A.LUGAR_NAC, A.DNI_TUTOR, A.DNI_MADRE, A.CANT_HER_MAY, A.CANT_HER_MEN, A.IGLESIA, A.ESC, ASUB.IND_GRUPO, ASUB.IND_SUBSIDIO FROM ALUMNOS A INNER JOIN ALUMNOS_GRADO AG ON AG.DNI = A.DNI AND AG.AÑO = " + año + " AND AG.TURNO = " +  "'" + turno + "' INNER JOIN ALUMNOS_SUBSIDIO ASUB ON ASUB.DNI = AG.DNI AND ASUB.AÑO = AG.AÑO ORDER BY A.APELLIDO");
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
	
	// metodo que devuelve la lista de alumnos de un determinado grado, en el año actual
	public static Alumnos getByGrado(String grado) {
		Alumnos lista = new Alumnos();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT A.DNI, A.NOMBRE, A.APELLIDO, A.DOMICILIO, A.TELEFONO, A.FECHA_NAC, A.LUGAR_NAC, A.DNI_TUTOR, A.DNI_MADRE, A.CANT_HER_MAY, A.CANT_HER_MEN, A.IGLESIA, A.ESC, A.IND_GRUPO, A.IND_SUBSIDIO FROM ALUMNOS A, ALUMNOS_GRADO AG WHERE A.DNI = AG.DNI AND AG.GRADO = '" + grado + "' AND AG.AÑO = YEAR(current_date) ORDER BY APELLIDO;");
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
	
	public static Alumnos getAllByGradoTurnoYAño(String grado, String turno, int año) {
		Alumnos lista = new Alumnos();
		try {
			Statement stmt = Conexion.conectar().createStatement();			
			
			ResultSet rs = stmt.executeQuery("SELECT A.DNI, A.NOMBRE, A.APELLIDO, A.DOMICILIO, A.TELEFONO, A.FECHA_NAC, A.LUGAR_NAC, A.DNI_TUTOR, A.DNI_MADRE, A.CANT_HER_MAY, A.CANT_HER_MEN, A.IGLESIA, A.ESC, ASUB.IND_GRUPO, ASUB.IND_SUBSIDIO FROM ALUMNOS A INNER JOIN ALUMNOS_GRADO AG ON AG.DNI = A.DNI AND AG.GRADO = '" + grado + "' AND AG.AÑO = " + año + " AND AG.TURNO = '" + turno + "' INNER JOIN ALUMNOS_SUBSIDIO ASUB ON ASUB.DNI = AG.DNI AND ASUB.AÑO = AG.AÑO ORDER BY A.APELLIDO");
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
	
	public static void getByAño(int año) {   //SIN TERMINAR
		
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT A.APELLIDO, A.NOMBRE, AG.GRADO, AG.AÑO FROM ALUMNOS A, ALUMNOS_GRADO AG WHERE A.DNI = AG.DNI AND AG.AÑO = " + año + " ORDER BY APELLIDO;");
			while (rs.next()) {
				
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}
	
	//modificado Ale
	public static Alumno getOne(int dni) throws SQLException, Exception {
			
		Alumno a = new Alumno();
		
		Statement stmt = Conexion.conectar().createStatement();
					
		ResultSet rs = stmt.executeQuery("SELECT * FROM ALUMNOS WHERE DNI="+dni);
			
		while(rs.next()){
				a = new Alumno(rs.getInt("DNI"),rs.getString("NOMBRE"),rs.getString("APELLIDO"),rs.getString("DOMICILIO"),rs.getString("TELEFONO"),rs.getString("FECHA_NAC"),rs.getString("LUGAR_NAC"),rs.getInt("DNI_TUTOR"),rs.getInt("DNI_MADRE"),rs.getInt("CANT_HER_MAY"),rs.getInt("CANT_HER_MEN"),rs.getString("IGLESIA"),rs.getString("ESC"), false , false); //modificado Ale
		}

		stmt.close();
		Conexion.desconectar();
	
		return a;
	}
	//modificado Ale
	
	public static Alumno getOne(int dni, int año) throws SQLException, Exception {
		Alumno a = new Alumno();
		int i = 0;
		
			Statement stmt = Conexion.conectar().createStatement();
			
			//System.out.println("SELECT A.DNI, A.NOMBRE, A.APELLIDO, A.DOMICILIO, A.TELEFONO, A.FECHA_NAC, A.LUGAR_NAC, A.DNI_TUTOR, A.DNI_MADRE, A.CANT_HER_MAY, A.CANT_HER_MEN, A.IGLESIA, A.ESC, ASUB.IND_GRUPO, ASUB.IND_SUBSIDIO FROM ALUMNOS A INNER JOIN ALUMNOS_SUBSIDIO ASUB ON ASUB.DNI = A.DNI AND ASUB.AÑO = " + año + " WHERE A.DNI = " + dni );
			
			ResultSet rs = stmt.executeQuery("SELECT A.DNI, A.NOMBRE, A.APELLIDO, A.DOMICILIO, A.TELEFONO, A.FECHA_NAC, A.LUGAR_NAC, A.DNI_TUTOR, A.DNI_MADRE, A.CANT_HER_MAY, A.CANT_HER_MEN, A.IGLESIA, A.ESC, ASUB.IND_GRUPO, ASUB.IND_SUBSIDIO FROM ALUMNOS A INNER JOIN ALUMNOS_SUBSIDIO ASUB ON ASUB.DNI = A.DNI AND ASUB.AÑO = " + año + " WHERE A.DNI = " + dni );
			
			while (rs.next()) {
				a = new Alumno(rs.getInt("dni"), rs.getString("nombre"), rs.getString("apellido"), rs.getString("domicilio"), rs.getString("telefono"), rs.getString("fecha_nac"), rs.getString("lugar_nac"), rs.getInt("dni_tutor"), rs.getInt("dni_madre"), rs.getInt("cant_her_may"), rs.getInt("cant_her_men"), rs.getString("iglesia"), rs.getString("esc"), rs.getBoolean("ind_grupo"), rs.getBoolean("ind_subsidio"));
				i = 1;
			}
			
			if (i == 0) {
				throw new SQLException();
			}
			stmt.close();
			Conexion.desconectar();
	
		return a;
	}
	
	public static boolean esAlumno(int dni) throws SQLException, Exception {	
		boolean b = false;
		
		Statement stmt = Conexion.conectar().createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM ALUMNOS WHERE DNI = '" + dni + "'");
			
		while (rs.next()) {
			b = true;	
		}
		stmt.close();
		Conexion.desconectar();
	
		return b;
	}
	
	public static Alumnos getHermanos(Alumno a) {
		Alumnos lista = new Alumnos();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM ALUMNOS WHERE DNI_TUTOR = '" + a.getDni_tutor() + "' AND DNI_MADRE = '" + a.getDni_madre() + "' AND DNI <> '" + a.getDni() + "' ORDER BY APELLIDO");
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
	
	public static int deleteOne(int dni) {
		int i = 0;
		try {
			Statement stmt = Conexion.conectar().createStatement();
			i = stmt.executeUpdate("DELETE FROM ALUMNOS WHERE DNI = '" + dni + "'");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}
	
	public static int boolToByte(boolean b) {
		byte r = (b == true? (byte)1 : (byte)0);
		return r;
	}
	
	public static void insertOne(Alumno a, int año) throws SQLException, Exception {
			Statement stmt = Conexion.conectar().createStatement();
			
			stmt.executeUpdate("INSERT INTO ALUMNOS VALUES ('" + a.getDni() + "','" + a.getNombre() + "','" + a.getApellido() + "','" + a.getDomicilio() + "','" + a.getTelefono() + "','" + a.getFecha_nac() + "','" + a.getLugar_nac() + "','" + a.getDni_tutor() + "','" + a.getDni_madre() + "','" + a.getCant_her_may() + "','" + a.getCant_her_men() + "','" + a.getIglesia() + "','" + a.getEsc() + "')"); //modificado Ale
					
			//System.out.println("INSERT INTO ALUMNOS_SUBSIDIO VALUES (" + año + ", " + a.getDni() + " , " + boolToByte(a.isInd_grupo()) + " , " + boolToByte(a.isInd_subsidio()) + ")"); //modificado Ale;
			
			stmt.executeUpdate("INSERT INTO ALUMNOS_SUBSIDIO VALUES (" + año + ", " + a.getDni() + " , " + boolToByte(a.isInd_grupo()) + " , " + boolToByte(a.isInd_subsidio()) + ")"); //modificado Ale						
												
			stmt.close();
			Conexion.desconectar();
	}
	
	public static int deleteAlumnoFromGrado(int dni) {
		int i = 0;
		try {
			Statement stmt = Conexion.conectar().createStatement();
			i = stmt.executeUpdate("DELETE FROM ALUMNOS_GRADO WHERE DNI = '" + dni + "'");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}
	
	public static void updateOne(int dni, String nombre, String apellido, String domicilio, String telefono,
			String fecha_nac, String lugar_nac, int dni_tutor, int dni_madre,
			int cant_her_may, int cant_her_men, String iglesia,
			String esc, int año, boolean ind_grupo, boolean ind_subsidio) throws SQLException, Exception {
			Statement stmt = Conexion.conectar().createStatement();
			
			stmt.executeUpdate("UPDATE ALUMNOS SET NOMBRE = '" + nombre + "', APELLIDO = '" + apellido + "', DOMICILIO = '" + domicilio + "', TELEFONO = '" + telefono + "', FECHA_NAC = '" + fecha_nac + "', LUGAR_NAC = '" + lugar_nac + "', DNI_TUTOR = '" + dni_tutor + "', DNI_MADRE = '" + dni_madre + "', CANT_HER_MAY = '" + cant_her_may + "', CANT_HER_MEN = '" + cant_her_men + "', IGLESIA = '" + iglesia + "', ESC = '" + esc + "' WHERE DNI = '" + dni + "'"); //Modificado Ale
			
			stmt.executeUpdate("UPDATE ALUMNOS_SUBSIDIO SET IND_GRUPO = " + boolToByte(ind_grupo) + ", IND_SUBSIDIO = " + boolToByte(ind_subsidio) + " WHERE DNI = " + dni + " AND AÑO = " + año); //Modificado Ale	
			
			
			stmt.close();
			Conexion.desconectar();
	}
	
	//devuelve solo alumnos sin subsidio, para el alta de planes de pago
	public static Alumnos getAlumnosPlanPago(String grado, String turno, int año) {
		Alumnos lista = new Alumnos();
		int i = 0;
		
		try {
			Statement stmt = Conexion.conectar().createStatement();			
									
			ResultSet rs = stmt.executeQuery("SELECT A.DNI, A.NOMBRE, A.APELLIDO, A.DOMICILIO, A.TELEFONO, A.FECHA_NAC, A.LUGAR_NAC, A.DNI_TUTOR, A.DNI_MADRE, A.CANT_HER_MAY, A.CANT_HER_MEN, A.IGLESIA, A.ESC, ASUB.IND_GRUPO, ASUB.IND_SUBSIDIO, IFNULL(M.DNI,0) as MAESTRODNI FROM ALUMNOS A INNER JOIN ALUMNOS_GRADO AG ON AG.DNI = A.DNI AND AG.GRADO = '" + grado + "' AND AG.AÑO = " + año + " AND AG.TURNO = '" + turno + "' INNER JOIN ALUMNOS_SUBSIDIO ASUB ON ASUB.DNI = AG.DNI AND ASUB.AÑO = AG.AÑO LEFT JOIN MAESTROS M ON (M.DNI = A.DNI_TUTOR OR M.DNI = A.DNI_MADRE) GROUP BY A.DNI ORDER BY A.APELLIDO");
			Alumno tmp;
			while (rs.next()) {
				tmp = new Alumno(rs.getInt("dni"), rs.getString("nombre"), rs.getString("apellido"), rs.getString("domicilio"), rs.getString("telefono"), rs.getString("fecha_nac"), rs.getString("lugar_nac"), rs.getInt("dni_tutor"), rs.getInt("dni_madre"), rs.getInt("cant_her_may"), rs.getInt("cant_her_men"), rs.getString("iglesia"), rs.getString("esc"), rs.getBoolean("ind_grupo"), rs.getBoolean("ind_subsidio"));
				i = rs.getInt("MAESTRODNI");
								
				if (!(tmp.isInd_subsidio() || i == 0)){
					lista.agregarAlumno(tmp);
				}
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	//devuelve solo alumnos sin subsidio, para el alta de planes de pago
	
	public static int checkPromocion(int dni, int año) throws Exception{
		
		int i = 0;
		
		try{
			Statement stm = Conexion.conectar().createStatement();
			
			//System.out.println("SELECT IFNULL(GB1.ORDEN, 0) - GB.ORDEN AS DIFERENCIA FROM ALUMNOS_GRADO AG  INNER JOIN GRADOS_BASE GB ON AG.GRADO = GB.GRADO AND AG.TURNO = GB.TURNO LEFT JOIN ALUMNOS_GRADO AG1 ON AG1.DNI = AG.DNI AND AG1.TURNO = AG.TURNO AND AG1.AÑO = '" + (año+1) + "' LEFT JOIN GRADOS_BASE GB1 ON AG1.GRADO = GB1.GRADO AND AG1.TURNO = GB1.TURNO WHERE AG.AÑO = '" + año + "' AND AG.DNI = " + dni );
			
			ResultSet rs = stm.executeQuery("SELECT IFNULL(GB1.ORDEN, 0) - GB.ORDEN AS DIFERENCIA FROM ALUMNOS_GRADO AG  INNER JOIN GRADOS_BASE GB ON AG.GRADO = GB.GRADO AND AG.TURNO = GB.TURNO LEFT JOIN ALUMNOS_GRADO AG1 ON AG1.DNI = AG.DNI AND AG1.TURNO = AG.TURNO AND AG1.AÑO = '" + (año+1) + "' LEFT JOIN GRADOS_BASE GB1 ON AG1.GRADO = GB1.GRADO AND AG1.TURNO = GB1.TURNO WHERE AG.AÑO = '" + año + "' AND AG.DNI = " + dni );
			
			while(rs.next()){
				i = rs.getInt("DIFERENCIA");
			}
			
			stm.close();
			rs.close();
			Conexion.desconectar();
			
		}catch(SQLException sqle){
			System.out.println(sqle);
		}
		return i;
	}
	
	public static void promGrado(int dni, int año) throws SQLException, Exception {
		
	Statement stmt = Conexion.conectar().createStatement();
	
	//inserta el alumno para el grado/año siguiente
	stmt.executeUpdate("INSERT INTO ALUMNOS_GRADO SELECT GB1.GRADO, AG.TURNO, AG.AÑO+1, AG.DNI FROM ALUMNOS_GRADO AG INNER JOIN GRADOS_BASE GB ON GB.GRADO = AG.GRADO AND GB.TURNO = AG.TURNO INNER JOIN GRADOS_BASE GB1 ON GB1.TURNO = GB.TURNO AND GB1.ORDEN = GB.ORDEN + 2 WHERE DNI = " + dni + " AND AG.AÑO = " + año);

	//insertan los mismos subsidios que el año en curso para el siguiente año
	stmt.executeUpdate("INSERT INTO ALUMNOS_SUBSIDIO SELECT AÑO+1, DNI, IND_GRUPO, IND_SUBSIDIO FROM ALUMNOS_SUBSIDIO WHERE DNI = " + dni + " AND AÑO = " + año);
	
	AccionesCertificado.insertOne(dni, año+1);
			
	stmt.close();
	Conexion.desconectar();				
	}
	
	public static void repetirGrado(int dni, int año) throws SQLException, Exception {
		
	Statement stmt = Conexion.conectar().createStatement();
	
	//inserta el alumno para el mismo grado y el año siguiente
	stmt.executeUpdate("INSERT INTO ALUMNOS_GRADO SELECT AG.GRADO, AG.TURNO, AG.AÑO+1, AG.DNI FROM ALUMNOS_GRADO AG WHERE DNI = " + dni + " AND AG.AÑO = " + año);

	//insertan los mismos subsidios que el año en curso para el siguiente año
	stmt.executeUpdate("INSERT INTO ALUMNOS_SUBSIDIO SELECT AÑO+1, DNI, IND_GRUPO, IND_SUBSIDIO FROM ALUMNOS_SUBSIDIO WHERE DNI = " + dni + " AND AÑO = " + año);
	
	AccionesCertificado.insertOne(dni, año+1);
			
	stmt.close();
	Conexion.desconectar();				
	}


	public static void main(String[] args) {	// getAll(), getOne(), insertOne(), updateOne() y deleteOne()  probadas correctamente
	
		try {

		//	Alumno a = getOne(38545642);
		//	System.out.println(a.toString());
		//	boolean b = esAlumno(3704173);
		//	System.out.println(b);
		//	Alumno aa = new Alumno(6, "2", "2", "2", null, "1992-05-04", "1", 5, 4, 1, 1, null, "Primaria", true, false);
		//	System.out.println(aa);
		//	insertOne(aa);
		//	updateOne(3, "2", "2", "2", null, "1992-05-04", "1", 54896521, 55486952, 1, 1, "MONSEÑOR BONEO", "secundaria", false, true);
		//	deleteOne(3);
		//	Alumnos al = getAllByGradoTurnoYAño("6to", "tarde", 2014);
		//	Alumnos al = getHermanos(a);
		//	al.listar();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
