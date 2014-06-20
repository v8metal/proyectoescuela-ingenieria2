package conexion;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import conexion.Conexion;
import datos.Maestros;
import datos.Materia;
import datos.Materias;
import datos.Usuario;
import datos.Usuarios;

public class AccionesUsuario {
	
	public static Integer validarUsuario(String usuario, String contraseña) {
		
		Integer code = -1;
		
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT COD_MAEST FROM USUARIOS WHERE USUARIO = '" + usuario + "' AND CONTRASEÑA = '" + contraseña + "'");
			
			while (rs.next()) {
				code = rs.getInt("COD_MAEST");
				if (code.equals(null)){
					code = 0;
				}
			}
			stmt.close();
			Conexion.desconectar();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return code;
	}
	
	public static boolean validarCuentaMaestro(int cod_maest) {
		boolean b = false;
		
		try {
			
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM SISTEMA_ALUMNADO.USUARIOS WHERE COD_MAEST = '" + cod_maest + "'");
			
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
			ResultSet rs = stmt.executeQuery("SELECT * FROM SISTEMA_ALUMNADO.USUARIOS WHERE COD_MAEST > 0");
			
			while (rs.next()) {
				i++;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return i;
	}    
	
	public static void registrar(String usuario, String contraseña, int codigo) throws SQLException, Exception {
		Statement stmt = Conexion.conectar().createStatement();
		stmt.executeUpdate("INSERT INTO USUARIOS VALUES ('" + usuario + "','" + contraseña + "','" + codigo + "')");
		
		stmt.close();
		Conexion.desconectar();
	}
	
	public static void updateUser(String usuario, String contraseña) throws SQLException, Exception {
		
		Statement stmt = Conexion.conectar().createStatement();		
		
		stmt.executeUpdate("UPDATE USUARIOS SET CONTRASEÑA = '" + contraseña + "' WHERE USUARIO = '" + usuario + "'");
			
		stmt.close();
		Conexion.desconectar();		
	}
	
	public static Usuarios getAll() {
		Usuarios lista = new Usuarios();
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM USUARIOS WHERE COD_MAEST > 0");
			Usuario tmp;
			
			while (rs.next()) {
				tmp = new Usuario(rs.getString("usuario"), rs.getString("contraseña"), rs.getInt("cod_maest"));
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
	public static boolean esUsuario(String usuario, String contraseña) {
		boolean b = false;
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM USUARIOS WHERE USUARIO = '" + usuario + "' AND CONTRASEÑA = '" + contraseña + "'");
			
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
	
	public static boolean esAdministrador(String usuario, String contraseña) {
		boolean b = false;
		try {
			Statement stmt = Conexion.conectar().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM USUARIOS WHERE USUARIO = '" + usuario + "' AND CONTRASEÑA = '" + contraseña + "' AND COD_MAEST IS NULL");
			
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