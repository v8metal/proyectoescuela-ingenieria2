package conexion;

import java.sql.ResultSet;
//import java.sql.SQLException;
import java.sql.Statement;

import conexion.Conexion;
import datos.Cuota;
import datos.Cuotas;

public class AccionesCuota {
	
	public static double getPagosDoublelMes(int dni, int año, int mes) throws Exception{
		
		double i = 0;
				
		Statement stm = Conexion.conectar().createStatement();	
			
		ResultSet rs = stm.executeQuery("SELECT " + dni +" , PERIODO, IFNULL(SUM(PAGO),0) AS PAGOS FROM PAGOS_CUOTA WHERE AÑO = " + año + " AND periodo = " + mes + " AND DNI = " + dni + " GROUP BY DNI, PERIODO");
		
		while(rs.next()){
			i = rs.getDouble("PAGOS");
		}
			
		stm.close();			
		Conexion.desconectar();		
			
		
		return i;
	}
	
	public static int getPagosTotalMes(int dni, int año, int mes) throws Exception{
		
		int i = 0;
				
		Statement stm = Conexion.conectar().createStatement();	
			
		ResultSet rs = stm.executeQuery("SELECT " + dni +" , PERIODO, IFNULL(SUM(PAGO),0) AS PAGOS FROM PAGOS_CUOTA WHERE AÑO = " + año + " AND periodo = " + mes + " AND DNI = " + dni + " GROUP BY DNI, PERIODO");
		
		while(rs.next()){
			i = rs.getInt("PAGOS");
		}
			
		stm.close();			
		Conexion.desconectar();		
			
		
		return i;
	}
	
	public static Cuotas getPagosMes(int dni, int año, int mes) throws Exception{
		
		Cuotas cuotas = new Cuotas();
				
		Statement stm = Conexion.conectar().createStatement();	
		
		//System.out.println("SELECT COD_PAGO, DNI, AÑO, PERIODO, FECHA, PAGO, IFNULL(OBSERVACIONES, '') AS OBSERVACIONES FROM PAGOS_CUOTA WHERE DNI = " + dni + " AND AÑO = " + año + " AND PERIODO = " + mes);
		
		ResultSet rs = stm.executeQuery("SELECT COD_PAGO, DNI, AÑO, PERIODO, FECHA, PAGO, IFNULL(OBSERVACIONES, '') AS OBSERVACIONES FROM PAGOS_CUOTA WHERE DNI = " + dni + " AND AÑO = " + año + " AND PERIODO = " + mes);
		
		Cuota p;
		
		while(rs.next()){
			p = new Cuota(rs.getInt("COD_PAGO"),rs.getInt("DNI"), rs.getInt("AÑO"), rs.getInt("PERIODO"),rs.getString("FECHA"), rs.getDouble("PAGO"),rs.getString("OBSERVACIONES")) ;
			cuotas.agregarCuota(p);
		}
			
		stm.close();
		Conexion.desconectar();
		
		return cuotas;
	}
	
	public static Cuota getOnePago(int cod_pago) throws Exception{
		
		Cuota c = null;
				
		Statement stm = Conexion.conectar().createStatement();	
		
		//System.out.println("SELECT COD_PAGO, DNI, AÑO, PERIODO, FECHA, PAGO, IFNULL(OBSERVACIONES, '') AS OBSERVACIONES FROM PAGOS_CUOTA WHERE COD_PAGO = " + cod_pago );
		
		ResultSet rs = stm.executeQuery("SELECT COD_PAGO, DNI, AÑO, PERIODO, FECHA, PAGO, IFNULL(OBSERVACIONES, '') AS OBSERVACIONES FROM PAGOS_CUOTA WHERE COD_PAGO = " + cod_pago );
						
		while(rs.next()){
			c = new Cuota(rs.getInt("COD_PAGO"),rs.getInt("DNI"), rs.getInt("AÑO"), rs.getInt("PERIODO"),rs.getString("FECHA"), rs.getDouble("PAGO"),rs.getString("OBSERVACIONES")) ;		
		}
			
		stm.close();
		Conexion.desconectar();
		
		return c;
	}
	
	public static int insertOnePago(Cuota c) throws Exception{
		
		int i = 0;
		
		Statement stmt = Conexion.conectar().createStatement();	
		
		//System.out.println("INSERT INTO PAGOS_CUOTA VALUES (" + 0 + " , " + c.getDni() + " , " + c.getAño() + ", " + c.getPeriodo() + " , '" + c.getFecha() + "' , " + c.getPago() +")");
		
		stmt.executeUpdate("INSERT INTO PAGOS_CUOTA VALUES (" + 0 + " , " + c.getDni() + " , " + c.getAño() + ", " + c.getPeriodo() + " , '" + c.getFecha() + "' , " + c.getPago() +", '" + c.getObservaciones() + "')");
		
		stmt.close();
		Conexion.desconectar();
		
		return i;
	}
	
	public static int updateOnePago(Cuota c) throws Exception{
		
		int i = 0;
		
		Statement stmt = Conexion.conectar().createStatement();	
		
		//System.out.println("UPDATE PAGOS_CUOTA SET FECHA = '" + c.getFecha() + "' , PAGO = " + c.getPago() + " WHERE COD_PAGO = " + c.getCod_pago());
		
		stmt.executeUpdate("UPDATE PAGOS_CUOTA SET FECHA = '" + c.getFecha() + "' , PAGO = " + c.getPago() + ", OBSERVACIONES = '"+ c.getObservaciones() + "' WHERE COD_PAGO = " + c.getCod_pago());
		
		stmt.close();
		Conexion.desconectar();
		
		return i;
	}

	public static int deleteOnePago(int cod_pago) throws Exception{
		
		int i = 0;
		
		Statement stmt = Conexion.conectar().createStatement();	
		
		//System.out.println("DELETE FROM PAGOS_CUOTA WHERE COD_PAGO = " + cod_pago);
		
		stmt.executeUpdate("DELETE FROM PAGOS_CUOTA WHERE COD_PAGO = " + cod_pago);
		
		stmt.close();
		Conexion.desconectar();
		
		return i;
	}
			
}
