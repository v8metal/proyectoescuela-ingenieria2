package conexion;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import conexion.Conexion;
import datos.Cuota;
import datos.Cuotas;

public class AccionesCuota {
	public static int altaCuota(Cuota x) throws Exception{
		Statement stm = Conexion.conectar().createStatement();
		int i =stm.executeUpdate("INSERT INTO CUOTAS VALUES("+x.getDni()+","+x.getA�o()+",'"+x.getPeriodo()+"',"+x.getReinscripcion()+","+x.getReinscripcion_ant()+")");
		stm.close();
		Conexion.desconectar();
		return i;
	}

	public static Cuotas getAll(int dni) throws Exception{
		Cuotas cuotas = new Cuotas();
		try{
			Statement stm = Conexion.conectar().createStatement();
			ResultSet rs = stm.executeQuery("SELECT * FROM CUOTAS WHERE DNI="+dni);
			Cuota c;
			while(rs.next()){
				c = new Cuota(rs.getInt("DNI"),rs.getInt("A�O"),rs.getString("PERIODO"),rs.getInt("REINSC"),rs.getInt("REINSC_ANT"));
				cuotas.agregarCuota(c);
			}
			stm.close();
			rs.close();
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println("ERROR SQL!");
		}
		return cuotas;
	}

	public static int modificar(Cuota c, int dni, int a�o, String periodo) throws Exception{
		int i =0;
	    try{
	    	 Statement stm = Conexion.conectar().createStatement();
	    	 i = stm.executeUpdate("UPDATE CUOTAS SET DNI="+c.getDni()+",A�O="+c.getA�o()+",PERIODO='"+c.getPeriodo()+"',REINSC="+c.getReinscripcion()+",REINSC_ANT="+c.getReinscripcion_ant()+" WHERE DNI="+dni+" AND A�O="+a�o+" AND PERIODO='"+periodo+"'");
	 	     stm.close();
	 	     Conexion.desconectar();
	    }catch(SQLException sqle){
	    	System.out.println(sqle);
	    }
	   
	    return i;
	}
	
	public static Cuota getOneCuota(int dni, int a�o, String periodo) throws Exception{
		Cuota c =null;
		try{
		Statement stm = Conexion.conectar().createStatement();
		ResultSet rs=stm.executeQuery("SELECT * FROM CUOTAS WHERE DNI="+dni+" AND A�O="+a�o+" AND PERIODO='"+periodo+"'");
		while(rs.next()){
			c = new Cuota(rs.getInt("DNI"),rs.getInt("A�O"),rs.getString("PERIODO"),rs.getInt("REINSC"),rs.getInt("REINSC_ANT"));
		}
		stm.close();
		rs.close();
		Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println(sqle);
		}
		return c;
	}
}
