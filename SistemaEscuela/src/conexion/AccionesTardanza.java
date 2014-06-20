package conexion;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import conexion.Conexion;
import datos.Tardanza;
import datos.Tardanzas;

public class AccionesTardanza {
	public static int altaTardanza(Tardanza t) throws Exception{
		Statement stm = Conexion.conectar().createStatement();
		int i = stm.executeUpdate("INSERT INTO TARDANZAS VALUES("+t.getDni()+",curdate(),'"+t.getObservaciones()+"','"+t.getTipo()+"','"+t.getIndicador()+"')");
		stm.close();
		Conexion.desconectar();
		return i;
	}
	
	public static Tardanzas getAllTardanzas(int dni) throws Exception{
		Tardanzas tardanzas = new Tardanzas();
		try{
			Statement stm = Conexion.conectar().createStatement();
			ResultSet rs = stm.executeQuery("SELECT * FROM TARDANZAS WHERE DNI="+dni+" AND INDICADOR='T'");
			Tardanza t;
			while(rs.next()){
				t = new Tardanza(rs.getInt("DNI"),rs.getString("FECHA"),rs.getString("OBSERVACIONES"),rs.getString("TIPO"),rs.getString("INDICADOR"));
				tardanzas.agregarTardanza(t);
			}
			stm.close();
			rs.close();
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println(sqle);
		}
		return tardanzas;
	}
	
	public static int bajaTardanza(int dni, String fecha) throws Exception{
		int i=0;
		try{
			Statement stm = Conexion.conectar().createStatement();
			i=stm.executeUpdate("DELETE FROM TARDANZAS WHERE DNI="+dni+" AND FECHA='"+fecha+"'");
			stm.close();
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println("error sql!!!");
		}
		return i;
	}
	
	public static int modificarTardanza(Tardanza t, int dni, String fecha) throws Exception{
		int i=0;
		try{
			Statement stm = Conexion.conectar().createStatement();
			i = stm.executeUpdate("UPDATE TARDANZAS SET DNI="+t.getDni()+",FECHA='"+t.getFecha()+"',OBSERVACIONES='"+t.getObservaciones()+"',TIPO='"+t.getTipo()+"' WHERE DNI='"+dni+"' AND FECHA='"+fecha+"'");
			stm.close();
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println(sqle);
		}
		return i;
	}
	
	public static Tardanza getOneTardanza(int dni, String fecha) throws Exception{
		Tardanza t =null;
		try{
			Statement stm = Conexion.conectar().createStatement();
			ResultSet rs = stm.executeQuery("SELECT * FROM TARDANZAS WHERE DNI="+dni+" AND FECHA='"+fecha+"'");
			while(rs.next()){
				t = new Tardanza(rs.getInt("DNI"),rs.getString("FECHA"),rs.getString("OBSERVACIONES"),rs.getString("TIPO"),rs.getString("INDICADOR"));
			}	
			stm.close();rs.close();Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println("ERROR SQL!!!");
		}
		return t;
	}
	
	public static Tardanzas getAllAsistencias(int dni) throws Exception{
		Tardanzas tardanzas = new Tardanzas();
		try{
			Statement stm = Conexion.conectar().createStatement();
			ResultSet rs = stm.executeQuery("SELECT * FROM TARDANZAS WHERE DNI="+dni+" AND INDICADOR='A'");
			Tardanza t;
			while(rs.next()){
				t = new Tardanza(rs.getInt("DNI"),rs.getString("FECHA"),rs.getString("OBSERVACIONES"),rs.getString("TIPO"),rs.getString("INDICADOR"));
				tardanzas.agregarTardanza(t);
			}
			stm.close();
			rs.close();
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println(sqle);
		}
		return tardanzas;
	}
	
}
