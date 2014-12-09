package conexion;

import java.sql.*;
import java.util.Calendar;

import datos.*;
import conexion.Conexion;

public class AccionesMaestro {
	
	public static Maestros_Grados getAll_Maestros_Grados(int dni) throws Exception{
		Maestros_Grados maestros_grados = new Maestros_Grados();
		try{
			Statement stm = Conexion.conectar().createStatement();
			ResultSet rs = stm.executeQuery("SELECT * FROM MAESTROS_GRADO WHERE DNI_MAESTRO_TIT="+ dni +" OR DNI_MAESTRO_PAR="+ dni);
			Maestro_Grado maestro_grado;
			while(rs.next()){
				maestro_grado= new Maestro_Grado(rs.getString("GRADO"),rs.getString("TURNO"),rs.getInt("AÑO"),rs.getInt("DNI_MAESTRO_TIT"),rs.getInt("DNI_MAESTRO_PAR"));
				maestros_grados.agregarMaestro_Grado(maestro_grado);
			}
			stm.close();
			rs.close();
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println(sqle);
		}
		return maestros_grados;
	}
	
	public static Maestros getAll() {
		Maestros lista = new Maestros();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM MAESTROS WHERE ESTADO = 1 ORDER BY APELLIDO");
			Maestro tmp;
			
			while (rs.next()) {
				tmp = new Maestro(rs.getInt("DNI"), rs.getString("apellido"), rs.getString("nombre"), rs.getString("domicilio"), rs.getString("telefono"),rs.getInt("ESTADO"));
				lista.agregarMaestro(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public static Maestros getAllActivos() {
		Maestros lista = new Maestros();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM MAESTROS WHERE DNI <> 1 AND ESTADO = 1 ORDER BY APELLIDO");
			Maestro tmp;
			
			while (rs.next()) {
				tmp = new Maestro(rs.getInt("DNI"), rs.getString("apellido"), rs.getString("nombre"), rs.getString("domicilio"), rs.getString("telefono"),rs.getInt("ESTADO"));
				lista.agregarMaestro(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}

	public static Maestros getAllInactivos() {
		Maestros lista = new Maestros();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM MAESTROS WHERE DNI <> 1 AND ESTADO = 0 ORDER BY APELLIDO");
			Maestro tmp;
			
			while (rs.next()) {
				tmp = new Maestro(rs.getInt("DNI"), rs.getString("apellido"), rs.getString("nombre"), rs.getString("domicilio"), rs.getString("telefono"),rs.getInt("ESTADO"));
				lista.agregarMaestro(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public static Maestro getOne(int dni) throws SQLException, Exception {
		Maestro m = null;
		//int i = 0;
		
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM MAESTROS WHERE DNI = '" + dni + "'");
			
			while (rs.next()) {
				m = new Maestro(rs.getInt("DNI"), rs.getString("apellido"), rs.getString("nombre"), rs.getString("domicilio"), rs.getString("telefono"),rs.getInt("ESTADO"));
				//i = 1;
			}
			
			//if (i == 0) {
			//	throw new SQLException();
			//}
			stmt.close();
			Conexion.desconectar();
	
		return m;
	}
	
	public static int deleteOne(int dni) throws SQLException, Exception {//lanzo la excepcion asi puedo mostrar el error
		int i = 0;
//		try {
			Statement stmt = Conexion.conectar().createStatement();
			//i = stmt.executeUpdate("DELETE FROM USUARIOS WHERE DNI_MAESTRO = '" + dni + "'"); //borra el usuarios, si se genero alguno para acceder
			
			i = stmt.executeUpdate("DELETE FROM MAESTROS WHERE DNI = '" + dni + "'"); //borra el maestro
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		return i;
	}
	
	public static void insertOne(Maestro m) throws SQLException, Exception {
			Statement stmt = Conexion.conectar().createStatement();
			stmt.executeUpdate("INSERT INTO MAESTROS VALUES (" + m.getDni() + ",'" + m.getApellido() + "','" + m.getNombre() + "' , '"+ m.getDomicilio() + "','" + m.getTelefono() + "', " + 1 + ")");
			
			stmt.close();
			Conexion.desconectar();
	}
	
	public static void updateOne(Maestro m) throws SQLException, Exception, CustomException {
			
			Statement stmt = Conexion.conectar().createStatement();
			
			int i = 0;
			
			if (m.getEstado() == 0){ //verifica si el maestro está asignado a algun grado para el año actual
				
				Calendar c = Calendar.getInstance();
												
				ResultSet rs = stmt.executeQuery("SELECT COUNT(1) AS COUNT FROM MAESTROS_GRADO WHERE DNI_MAESTRO_TIT = " + m.getDni() + " OR DNI_MAESTRO_PAR= " + m.getDni() + " AND AÑO= " + Integer.toString(c.get(Calendar.YEAR)) );
				
				while (rs.next()) {
					i = rs.getInt("COUNT");					
				}
				
				
				if (i == 0 ){ //si no está asignado se puede dar de baja lógicamente
					stmt.executeUpdate("UPDATE MAESTROS SET ESTADO = " + m.getEstado() + " WHERE DNI = '" + m.getDni() + "'");
				}else{
					throw new CustomException();
				}
					
										
			}else{ //acá se entra si no se le cambia el estado al maestro
				
				stmt.executeUpdate("UPDATE MAESTROS SET ESTADO = "+ m.getEstado() + ", APELLIDO = '" + m.getApellido() + "', NOMBRE = '" + m.getNombre() + "', DOMICILIO = '" + m.getDomicilio() + "', TELEFONO = '" + m.getTelefono() + "' WHERE DNI = '" + m.getDni() + "'");
			}
			
			stmt.close();
			Conexion.desconectar();
	} 
	
	public static Grados getGradosTitular(int dni) {
		
		int año = Calendar.getInstance().get(Calendar.YEAR);
		Grados lista = new Grados();
		
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT MG.GRADO, MG.TURNO, G.IND_EVALUACION, G.IND_BIM, G.SALON, MG.AÑO, MG.DNI_MAESTRO_TIT, MG.DNI_MAESTRO_PAR FROM MAESTROS_GRADO MG INNER JOIN GRADOS G ON(MG.GRADO = G.GRADO AND MG.TURNO = G.TURNO) WHERE DNI_MAESTRO_TIT = " + dni + " AND AÑO = " + año);
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
	
	public static int getAñoMaestro(String tipo, int dni) throws Exception{
		
		int año = 0;
		
		try{
			
			Statement stm = Conexion.conectar().createStatement();
								
			ResultSet rs = stm.executeQuery("SELECT "+ tipo +"(AÑO) AS AÑO FROM MAESTROS_GRADO WHERE DNI_MAESTRO_TIT = " + dni);
							
			while(rs.next()){
				año = rs.getInt("AÑO");				
			}
			
			stm.close();
			rs.close();
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println("ERROR SQL!!!");
		}
		
		return año;
	}
	
	public static Grados getGradosAño(int dni, int año) throws Exception{

		Grados grados = new Grados();
		
		try{
			Statement stm = Conexion.conectar().createStatement();
									
			ResultSet rs = stm.executeQuery("SELECT GB.GRADO, GB.TURNO, G.IND_EVALUACION, G.IND_BIM, G.SALON, MG.AÑO, MG.DNI_MAESTRO_TIT, MG.DNI_MAESTRO_PAR FROM MAESTROS_GRADO MG INNER JOIN GRADOS G ON G.GRADO = MG.GRADO AND G.TURNO = MG.TURNO INNER JOIN GRADOS_BASE GB ON GB.GRADO = G.GRADO AND GB.TURNO = G.TURNO WHERE MG.DNI_MAESTRO_TIT = "+ dni +" AND MG.AÑO = " + año + " ORDER BY GB.ORDEN");
			
			Grado g = null;
			
			while(rs.next()){
				g = new Grado(rs.getString("GRADO"), rs.getString("TURNO"), rs.getInt("IND_EVALUACION"), rs.getBoolean("IND_BIM"), rs.getString("SALON"), rs.getInt("AÑO"), rs.getInt("DNI_MAESTRO_TIT"),rs.getInt("DNI_MAESTRO_PAR"));
				grados.agregarGrado(g);
			}
			
			stm.close();
			rs.close();
			Conexion.desconectar();
			
		}catch(SQLException sqle){
			System.out.println(sqle);
		}
		return grados;
	}
	
	
	public static void main(String[] args) {	// getAll(), getOne(), insertOne(), updateOne() y deleteOne()  probadas correctamente
		
		try {
			
		//	Maestro m = getOne(1);
		//	System.out.println(m.toString());
		//	Maestro mm = new Maestro(11, "1", "1", "1", "1");
		//	insertOne(mm);
		//	updateOne(11, "2", "3", "3", "3");
		//	deleteOne(11);
		//	Maestros ma = AccionesMaestro.getAll();
		//	ma.listar();
			
			Maestros maestros = AccionesMaestro.getAllActivos();
			
			maestros.listar();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


}