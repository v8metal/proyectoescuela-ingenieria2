package conexion;

import java.sql.ResultSet;
import java.sql.Statement;

import datos.Mensaje;

public class AccionesMensaje {

	public static Mensaje getOne(int cod_mensaje) {

		Mensaje mensaje = new Mensaje();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM MENSAJES WHERE COD_MENSAJE = " + cod_mensaje);
						
			while (rs.next()) {
				mensaje = new Mensaje(rs.getInt("COD_MENSAJE"), rs.getString("TIPO"), rs.getString("MENSAJE"));				
			}
			
			stmt.close();
			Conexion.desconectar();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mensaje;
	}
	
	public static void main(String[] args) {
		
		System.out.println(AccionesMensaje.getOne(3).getMensaje());
		
	}
	
}
