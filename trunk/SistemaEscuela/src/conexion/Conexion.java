package conexion;

import java.sql.*;

public class Conexion {
	
	private static Connection con = null;
	private static String BD_driver = "com.mysql.jdbc.Driver";
	private static String BD_url = "jdbc:mysql://localhost/sistema_alumnado";
	private static String BD_user = "root";
	private static String BD_password = "aus2011";
	
	public static Connection conectar() throws Exception {
		try {
			if (con == null) {
				Class.forName(BD_driver);
				con = DriverManager.getConnection(BD_url, BD_user, BD_password);
			}
		} catch (ClassNotFoundException e) {
			System.out.println("Error!");
		} catch (SQLException e) {
			System.out.println(e);
		}
		return con;
	}
	
	public static void desconectar() throws Exception {
		try {
			if (con != null) {
				con.close();
				con = null;
			}
		} catch (SQLException e) {
			System.out.println(e);
		}
	}
	
}