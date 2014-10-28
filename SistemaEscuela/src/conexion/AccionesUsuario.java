package conexion;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import conexion.Conexion;
import datos.Usuario;
import datos.Usuarios;

public class AccionesUsuario {
	
	public static Integer validarUsuario(String usuario, String contrase�a) {
		
		Integer dni = 0;
		
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT DNI_MAESTRO FROM USUARIOS WHERE USUARIO = '" + usuario + "' AND CONTRASE�A = '" + contrase�a + "'");
			
			while (rs.next()) {
				dni = rs.getInt("DNI_MAESTRO");				
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
			ResultSet rs = stmt.executeQuery("SELECT * FROM SISTEMA_ALUMNADO.USUARIOS WHERE DNI_MAESTRO = '" + dni + "'");
			
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
			ResultSet rs = stmt.executeQuery("SELECT * FROM SISTEMA_ALUMNADO.USUARIOS WHERE DNI_MAESTRO > 1");
			
			while (rs.next()) {
				i++;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return i;
	}    
	
	public static void registrar(String usuario, String contrase�a, int codigo) throws SQLException, Exception {
		Statement stmt = Conexion.conectar().createStatement();
		stmt.executeUpdate("INSERT INTO USUARIOS VALUES ('" + usuario + "','" + contrase�a + "','" + codigo + "')");
		
		stmt.close();
		Conexion.desconectar();
	}
	
	public static void updateUser(String usuario, String user) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();		
		
		stmt.executeUpdate("UPDATE USUARIOS SET USUARIO = '" + user + "' WHERE USUARIO = '" + usuario + "'");
			
		stmt.close();
		Conexion.desconectar();		
	}
	
	public static void updatePass(String usuario, String contrase�a) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();		
		
		stmt.executeUpdate("UPDATE USUARIOS SET CONTRASE�A = '" + contrase�a + "' WHERE USUARIO = '" + usuario + "'");
			
		stmt.close();
		Conexion.desconectar();		
	}
	
	public static Usuarios getAll() {
		Usuarios lista = new Usuarios();
		try {
			Statement stmt = Conexion.conectar().createStatement();
<<<<<<< .mine
			ResultSet rs = stmt.executeQuery("SELECT * FROM USUARIOS WHERE DNI_MAESTRO > 1");
=======
			ResultSet rs = stmt.executeQuery("SELECT * FROM USUARIOS WHERE DNI_MAESTRO <> 1");
>>>>>>> .r52
			Usuario tmp;
			
			while (rs.next()) {
				tmp = new Usuario(rs.getString("usuario"), rs.getString("contrase�a"), rs.getInt("DNI_MAESTRO"));
				lista.agregarUsuario(tmp);
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public static int deleteOne(String usuario) throws SQLException, Exception {
		int i = 0;
		try {
			Statement stmt = Conexion.conectar().createStatement();
			i = stmt.executeUpdate("DELETE FROM USUARIOS WHERE USUARIO = '" + usuario + "'");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}
	
	/*	
	public static int getCodigo(String apellido, String nombres){
		
		int cod = -1;
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT COD_MAEST FROM MAESTROS WHERE APELLIDO = '" + apellido + "' AND NOMBRE = '" + nombres + "'");
			
			while (rs.next()) {
				cod = rs.getInt("cod_maest");
			}
	
			stmt.close();
			Conexion.desconectar();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return cod;
	}		*/

/*	
	public static boolean esUsuario(String usuario, String contrase�a) {
		boolean b = false;
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM USUARIOS WHERE USUARIO = '" + usuario + "' AND CONTRASE�A = '" + contrase�a + "'");
			
			while (rs.next()) {
				b = true;
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return b;
	}
	
	public static boolean esAdministrador(String usuario, String contrase�a) {
		boolean b = false;
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM USUARIOS WHERE USUARIO = '" + usuario + "' AND CONTRASE�A = '" + contrase�a + "' AND COD_MAEST IS NULL");
			
			while (rs.next()) {
				b = true;
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return b;
	}
	
	public static int getCodMaestroByUsername(String username) throws SQLException, Exception {
		int codigo = 0;
		int i = 0;
		
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT COD_MAEST FROM USUARIOS WHERE USUARIO = '" + username + "'");
		
			while (rs.next()) {
				codigo = rs.getInt("cod_maest");
				i = 1;
			}
		
			if (i == 0) {
				throw new SQLException();
			}
			stmt.close();
			Conexion.desconectar();

		return codigo;
		
	}
*/
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