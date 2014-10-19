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
		
		//System.out.println("INSERT INTO TARDANZAS VALUES("+ t.getDni() + ",'" + t.getFecha()+ "','"+ t.getObservaciones()+"','" + t.getTipo() + "','"+ t.getIndicador()+"')");
		
		int i = stm.executeUpdate("INSERT INTO TARDANZAS VALUES("+ t.getDni() + ",'" + t.getFecha()+ "','"+ t.getObservaciones()+"','" + t.getTipo() + "','"+ t.getIndicador()+"')");
		stm.close();
		Conexion.desconectar();
		return i;
	}
	
	public static Tardanzas getAllTardanzas(String grado, String turno, int año) throws Exception{
		Tardanzas tardanzas = new Tardanzas();
		try{
			Statement stm = Conexion.conectar().createStatement();
						
			ResultSet rs = stm.executeQuery("SELECT T.DNI, T.FECHA, T.OBSERVACIONES FROM TARDANZAS T INNER JOIN ALUMNOS_GRADO AG ON AG.DNI = T.DNI AND AG.AÑO = " + año + " AND AG.GRADO = '"+ grado +"' WHERE T.TIPO = 'T' AND T.FECHA BETWEEN '" + año + "-01-01' AND '" + año + "-12-31'ORDER BY FECHA");
			Tardanza t;
			while(rs.next()){
				t = new Tardanza(rs.getInt("DNI"),rs.getString("FECHA"),rs.getString("OBSERVACIONES"),"T","");
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
			i=stm.executeUpdate("DELETE FROM TARDANZAS WHERE TIPO = 'T' AND DNI="+dni+" AND FECHA='"+fecha+"'");
			stm.close();
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println("error sql!!!");
		}
		return i;
	}
	
	public static int modificarTardanza(Tardanza t, String fecha) throws Exception{
		int i=0;
		try{
			Statement stm = Conexion.conectar().createStatement();
			
			//System.out.println("UPDATE TARDANZAS SET FECHA='"+ t.getFecha()+ "',OBSERVACIONES='"+t.getObservaciones() +"' WHERE TIPO = 'T' AND DNI='"+ t.getDni() +"' AND FECHA='" + fecha +"'");
			
			i = stm.executeUpdate("UPDATE TARDANZAS SET FECHA='"+ t.getFecha()+ "',OBSERVACIONES='"+t.getObservaciones() +"' WHERE TIPO = 'T' AND DNI='"+ t.getDni() +"' AND FECHA='" + fecha +"'");
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
			ResultSet rs = stm.executeQuery("SELECT * FROM TARDANZAS WHERE TIPO = 'T' AND DNI="+dni+" AND FECHA='"+fecha+"'");
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
