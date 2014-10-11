package conexion;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import datos.Entrevista;
import datos.Entrevistas;

public class AccionesEntrevista {
	
	public static Entrevistas getAllEntrevistas_Maestro(int dni_maest) throws Exception{
		Entrevistas entrevistas = new Entrevistas();
		try{
			Statement stm = Conexion.conectar().createStatement();
			ResultSet rs = stm.executeQuery("SELECT * FROM ENTREVISTAS WHERE DNI_MAEST="+ dni_maest+" AND YEAR(FECHA)=YEAR(CURDATE())");
			Entrevista e;
			while(rs.next()){
				e = new Entrevista(rs.getString("FECHA"),rs.getString("HORA"),rs.getInt("DNI_MAEST"),rs.getString("NOMBRE_ALUM"),rs.getString("DESCRIP"));
				entrevistas.agregarEntrevista(e);
			}
			stm.close();
			rs.close();
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println(sqle);
		}
		return entrevistas;
	}
	
	public static Entrevistas getAll() {
		
		Entrevistas lista = new Entrevistas();
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM ENTREVISTAS" );
			Entrevista tmp;
			
			while (rs.next()) {
				tmp = new Entrevista(rs.getString("FECHA"),rs.getString("HORA") ,rs.getInt("DNI_MAEST"), rs.getString("NOMBRE_ALUM"), rs.getString("DESCRIP"));
				lista.agregarEntrevista(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}

	public static Entrevista getOne(String fecha, String nombre) {
		
		Entrevista entrevista = new Entrevista();
				
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM ENTREVISTAS WHERE FECHA = '" + fecha + "' AND NOMBRE_ALUM = '" + nombre + "'" );
			
			while (rs.next()) {
				entrevista = new Entrevista(rs.getString("FECHA"),rs.getString("HORA"), rs.getInt("DNI_MAEST"), rs.getString("NOMBRE_ALUM"), rs.getString("DESCRIP"));				
			}			
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return entrevista;
	}
	
	public static void updateOne(String fecha_update, String hora_update, String fecha, String hora, int dni_maestro) throws SQLException, Exception {	
		Statement stmt = Conexion.conectar().createStatement();
		stmt.executeUpdate("UPDATE ENTREVISTAS SET FECHA = '" + fecha_update + "', HORA ='" + hora_update + "' WHERE FECHA = '" + fecha + "' AND HORA = '" + hora + "' AND DNI_MAEST = " + dni_maestro);
			
		stmt.close();
		Conexion.desconectar();		
	}
	
	public static void insertOne(Entrevista e) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();
		stmt.executeUpdate("INSERT INTO ENTREVISTAS VALUES ('" + e.getFecha() + "','"+ e.getHora()+ "'," + e.getdniMaestro() + ", '" + e.getNombre() + "', '" + e.getDescripcion() + "')");
			
		stmt.close();
		Conexion.desconectar();		
	}
	
	public static int deleteOne(String fecha, String nombre) {
		
		int i = 0;

		try {
			Statement stmt = Conexion.conectar().createStatement();
			i = stmt.executeUpdate("DELETE FROM ENTREVISTAS WHERE FECHA = '" + fecha + "' AND NOMBRE_ALUM = '" + nombre + "'" );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}
	
	public static Entrevista getOneEntrevista(String fecha,String hora, int dni_maest ) throws Exception{
		Entrevista e=null;
		try{
			Statement stm = Conexion.conectar().createStatement();
			ResultSet rs = stm.executeQuery("SELECT * FROM ENTREVISTAS WHERE FECHA='"+fecha+"' AND DNI_MAEST="+dni_maest+" AND HORA='"+hora+"'");
			while(rs.next()){
				e = new Entrevista(rs.getString("FECHA"),rs.getString("HORA"), rs.getInt("DNI_MAEST"), rs.getString("NOMBRE_ALUM"), rs.getString("DESCRIP"));
			}
			stm.close();rs.close();Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println(sqle);
		}
		return e;
	}
	
	public static int borrarEntrevista(String fecha, int dni_maest, String hora) throws Exception{
		int i =0;
		try{
			Statement stm = Conexion.conectar().createStatement();
			i=stm.executeUpdate("DELETE FROM ENTREVISTAS WHERE DNI_MAEST="+dni_maest+" AND FECHA='"+fecha+"' AND HORA='"+hora+"'");
			stm.close();
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println("ERROR SQL!!");
		}
		return i;
	}
	
	public static int modificarEntrevista(Entrevista e, String fecha, int dni_maest, String hora) throws Exception{
		int i=0;
		try{
			Statement stm = Conexion.conectar().createStatement();
			i = stm.executeUpdate("UPDATE ENTREVISTAS SET FECHA=curdate()"+",HORA=curtime()"+",DNI_MAEST="+e.getdniMaestro()+",NOMBRE_ALUM='"+e.getNombre()+"',DESCRIP='"+e.getDescripcion()+"' WHERE FECHA='"+fecha+"' AND dni_MAEST="+dni_maest+" AND HORA='"+hora+"'");
			stm.close();
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println("ERROR SQL!!!");
		}
		return i;
	}
	
}
