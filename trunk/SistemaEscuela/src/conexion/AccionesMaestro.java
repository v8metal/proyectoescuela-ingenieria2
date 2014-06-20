package conexion;

import java.sql.*;
import java.util.Calendar;

import datos.*;
import conexion.Conexion;

public class AccionesMaestro {
	
	public static Maestros_Grados getAll_Maestros_Grados(int cod_maest) throws Exception{
		Maestros_Grados maestros_grados = new Maestros_Grados();
		try{
			Statement stm = Conexion.conectar().createStatement();
			ResultSet rs = stm.executeQuery("SELECT * FROM MAESTROS_GRADO WHERE COD_MAESTRO_TIT="+cod_maest+" OR COD_MAESTRO_PAR="+cod_maest);
			Maestro_Grado maestro_grado;
			while(rs.next()){
				maestro_grado= new Maestro_Grado(rs.getString("GRADO"),rs.getString("TURNO"),rs.getInt("AÑO"),rs.getInt("COD_MAESTRO_TIT"),rs.getInt("COD_MAESTRO_PAR"));
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
			ResultSet rs = stmt.executeQuery("SELECT * FROM MAESTROS ORDER BY APELLIDO");
			Maestro tmp;
			
			while (rs.next()) {
				tmp = new Maestro(rs.getInt("cod_maest"), rs.getString("apellido"), rs.getString("nombre"), rs.getInt("dni"), rs.getString("domicilio"), rs.getString("telefono"));
				lista.agregarMaestro(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public static Maestro getOne(int cod_maest) throws SQLException, Exception {
		Maestro m = null;
		//int i = 0;
		
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM MAESTROS WHERE COD_MAEST = '" + cod_maest + "'");
			
			while (rs.next()) {
				m = new Maestro(rs.getInt("cod_maest"), rs.getString("apellido"), rs.getString("nombre"), rs.getInt("dni"), rs.getString("domicilio"), rs.getString("telefono"));
				//i = 1;
			}
			
			//if (i == 0) {
			//	throw new SQLException();
			//}
			stmt.close();
			Conexion.desconectar();
	
		return m;
	}
	
	public static int deleteOne(int cod_maest) throws SQLException, Exception {			//lanzo la excepcion asi puedo mostrar el error
		int i = 0;
//		try {
			Statement stmt = Conexion.conectar().createStatement();
			i = stmt.executeUpdate("DELETE FROM MAESTROS WHERE COD_MAEST = '" + cod_maest + "'");
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		return i;
	}
	
	public static void insertOne(Maestro m) throws SQLException, Exception {
			Statement stmt = Conexion.conectar().createStatement();
			stmt.executeUpdate("INSERT INTO MAESTROS VALUES ('" + m.getCod_maest() + "','" + m.getApellido() + "','" + m.getNombre() + "','" + m.getDni() + "','" + m.getDomicilio() + "','" + m.getTelefono() + "')");
			
			stmt.close();
			Conexion.desconectar();
	}
	
	public static void updateOne(int cod_maest, String apellido, String nombre, int dni, String domicilio, String telefono) throws SQLException, Exception {
			Statement stmt = Conexion.conectar().createStatement();
			stmt.executeUpdate("UPDATE MAESTROS SET APELLIDO = '" + apellido + "', NOMBRE = '" + nombre + "', DNI = '" + dni + "', DOMICILIO = '" + domicilio + "', TELEFONO = '" + telefono + "' WHERE COD_MAEST = '" + cod_maest + "'");
			
			stmt.close();
			Conexion.desconectar();
	} 
	
	public static Grados getGradosTitular(int cod_maestro) {
		
		int año = Calendar.getInstance().get(Calendar.YEAR);
		Grados lista = new Grados();
		
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT MG.GRADO, MG.TURNO, G.IND_BIM, G.SALON, MG.AÑO, MG.COD_MAESTRO_TIT, MG.COD_MAESTRO_PAR FROM MAESTROS_GRADO MG INNER JOIN GRADOS G ON(MG.GRADO = G.GRADO AND MG.TURNO = G.TURNO) WHERE COD_MAESTRO_TIT = " + cod_maestro + " AND AÑO = " + año);
			Grado tmp;
			
			while (rs.next()) {
				tmp = new Grado(rs.getString("GRADO"), rs.getString("TURNO"), rs.getBoolean("IND_BIM"), rs.getString("SALON"), rs.getInt("AÑO"), rs.getInt("COD_MAESTRO_TIT"),rs.getInt("COD_MAESTRO_PAR"));
				lista.agregarGrado(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
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
			
			Maestros maestros = AccionesMaestro.getAll();
			
			maestros.listar();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


}