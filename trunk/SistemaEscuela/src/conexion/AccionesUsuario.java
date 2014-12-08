package conexion;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import conexion.Conexion;
import datos.Usuario;
import datos.Usuarios;

public class AccionesUsuario {
	
	public static Integer validarUsuario(String usuario, String contraseña) {
		
		Integer tipo = null;
		
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT UT.TIPO FROM USUARIOS U INNER JOIN USUARIOS_TIPO UT ON UT.DNI = U.DNI  WHERE U.USUARIO = '" + usuario + "' AND CONTRASEÑA = '" + contraseña + "'");
			
			while (rs.next()) {
				tipo = rs.getInt("TIPO");				
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return tipo;
	}
	
	public static Integer getDniUsuario(String usuario, String contraseña) {
			
			Integer dni = 0;
			
			try {
				Statement stmt = Conexion.conectar().createStatement();
				ResultSet rs = stmt.executeQuery("SELECT DNI FROM USUARIOS WHERE USUARIO = '" + usuario + "' AND CONTRASEÑA = '" + contraseña + "'");
				
				while (rs.next()) {
					dni = rs.getInt("DNI");				
				}
				stmt.close();
				Conexion.desconectar();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return dni;
		}
		
	public static boolean validarCuentaMaestro(int dni) {
		boolean b = false;
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM SISTEMA_ALUMNADO.USUARIOS WHERE DNI = '" + dni + "'");
			
			while (rs.next()) {
				b = true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return b;
	}
	
	public static int maestrosConCuenta() {
		int i = 0;
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM USUARIOS U INNER JOIN USUARIOS_TIPO UT ON UT.DNI = U.DNI AND UT.TIPO = 1");
			
			while (rs.next()) {
				i++;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return i;
	}    
	
	public static void registrar(int dni, String usuario, String contraseña) throws SQLException, Exception {
		Statement stmt = Conexion.conectar().createStatement();
		stmt.executeUpdate("INSERT INTO USUARIOS VALUES (" + dni + ",'" + usuario + "','" + contraseña + "')");

		//insertar el tipo de usuario, 1 maestro, por ahora lo hacemos manualmente
		
		stmt.executeUpdate("INSERT INTO USUARIOS_TIPO VALUES (" + dni + " , "+ 1 + ")");
		
		stmt.close();
		Conexion.desconectar();
	}
	
	public static void updateUser(String usuario, String user) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();		
		
		stmt.executeUpdate("UPDATE USUARIOS SET USUARIO = '" + user + "' WHERE USUARIO = '" + usuario + "'");
			
		stmt.close();
		Conexion.desconectar();		
	}
	
	public static void updatePass(String usuario, String contraseña) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();		
		
		stmt.executeUpdate("UPDATE USUARIOS SET CONTRASEÑA = '" + contraseña + "' WHERE USUARIO = '" + usuario + "'");
			
		stmt.close();
		Conexion.desconectar();		
	}
	
	public static Usuarios getAll() {
		Usuarios lista = new Usuarios();
		try {
			Statement stmt = Conexion.conectar().createStatement();

			//ResultSet rs = stmt.executeQuery("SELECT * FROM USUARIOS WHERE DNI > 1");

			ResultSet rs = stmt.executeQuery("SELECT * FROM USUARIOS U INNER JOIN USUARIOS_TIPO UT ON UT.DNI = U.DNI AND UT.TIPO = 1");

			Usuario tmp;
			
			while (rs.next()) {
				tmp = new Usuario(rs.getString("usuario"), rs.getString("contraseña"), rs.getInt("DNI"));
				lista.agregarUsuario(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public static int deleteOne(int dni) throws SQLException, Exception {
		int i = 0;
		try {
			Statement stmt = Conexion.conectar().createStatement();
			i = stmt.executeUpdate("DELETE FROM USUARIOS_TIPO WHERE DNI = '" + dni + "'");
			i = stmt.executeUpdate("DELETE FROM USUARIOS WHERE DNI = '" + dni + "'");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}
	
	public static int validarAcceso(int tipo, String objeto) {
		
		int i = 0;
		
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT COUNT(1) AS COUNT FROM OBJETOS_TIPO WHERE TIPO = " + tipo + " AND OBJETO = '" + objeto + "'");
			
			while (rs.next()) {
				i = rs.getInt("COUNT");				
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return i;
	}
	
	public static boolean checkUsuario(String usuario) throws SQLException, Exception {
		
		boolean b = false;
		
		Statement stmt = Conexion.conectar().createStatement();		
		ResultSet rs = stmt.executeQuery("SELECT COUNT(1) AS COUNT FROM USUARIOS WHERE USUARIO = '" + usuario + "'");
			
		while (rs.next()) {
			if (rs.getInt("COUNT") == 1) b = true;				
		}
			
		stmt.close();
		Conexion.desconectar();
		
		return b;
	}

	public static void main(String[] args) {
//		Integer i = validarUsuario("goonza", "nob");
//		System.out.println(i);
		
	//	int cod = getCodigo("ruiz", "alejandro");
	//	System.out.println(cod);
		
	//	String ss = " ";
		
	//	boolean b = ((!ss.equals("")) && (ss.isEmpty()));
	//	System.out.println(b);
		
	//	boolean b = validarCuentaMaestro(8);
	//	System.out.println(b);
/*		int i = maestrosConCuenta();
		System.out.println(i);
		
		Maestros maestros = AccionesMaestro.getAll();
		int ii = (maestros.getLista().size() - maestrosConCuenta());
		System.out.println(ii);     */
		
		Usuarios u = getAll();
		u.listar();
		
	}
}