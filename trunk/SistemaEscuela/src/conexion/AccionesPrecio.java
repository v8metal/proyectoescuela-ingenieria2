package conexion;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import conexion.Conexion;
import datos.PrecioMes;
import datos.PreciosMes;
import datos.PrecioInscrip;
import datos.PreciosInscrip;

public class AccionesPrecio {

	public static int altaPrecioMes(PrecioMes p) throws Exception{
		Statement stm = Conexion.conectar().createStatement();
		
		int i = stm.executeUpdate("INSERT INTO PRECIOS_MENSUALES VALUES("+p.getA�o()+","+p.getMes()+","+p.getRegular()+","+p.getGrupo()+","+p.getHijos()+","+p.getRecargo()+")");
		stm.close();
		Conexion.desconectar();
		return i;
	}
	
	public static PreciosMes getAllMes(int a�o) throws Exception{
		PreciosMes precios = new PreciosMes();
		try{
			Statement stm = Conexion.conectar().createStatement();
		ResultSet rs = stm.executeQuery("SELECT * FROM PRECIOS_MENSUALES WHERE A�O="+a�o);
		PrecioMes p;
		
		while(rs.next()){
			p = new PrecioMes(rs.getInt("A�O"),rs.getInt("MES"),rs.getInt("REGULAR"),rs.getInt("GRUPO"),rs.getInt("HIJOS"),rs.getInt("RECARGO"));
			precios.agregarPrecio(p);
		}
		
		stm.close();
		rs.close();
		Conexion.desconectar();

		}catch(SQLException sqle){
			System.out.println("ERROR SQL!");
		}
		return precios;
	}
	
	public static PrecioMes getUltimoMes(int a�o) throws Exception{
		
		PrecioMes p = null;
		
		try{
								
			Statement stm = Conexion.conectar().createStatement();
			ResultSet rs = stm.executeQuery("SELECT * FROM PRECIOS_MENSUALES WHERE mes = (SELECT MAX(MES) FROM PRECIOS_MENSUALES WHERE A�O = "+ a�o + ") AND A�O = " + a�o);
			
			while(rs.next()){
				p = new PrecioMes(rs.getInt("A�O"),rs.getInt("MES"),rs.getInt("REGULAR"),rs.getInt("GRUPO"),rs.getInt("HIJOS"),rs.getInt("RECARGO"));
				
			}
			stm.close();
			rs.close();
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println("ERROR SQL!");
		}
		return p;
	}
	
	public static PreciosInscrip getAllInscrip(int a�o) throws Exception{
		PreciosInscrip precios = new PreciosInscrip();
		try{
			Statement stm = Conexion.conectar().createStatement();
			ResultSet rs = stm.executeQuery("SELECT * FROM PRECIOS_INSCRIPCION WHERE A�O="+a�o);
			PrecioInscrip p;
			while(rs.next()){
				p = new PrecioInscrip(rs.getInt("A�O"),rs.getString("FECHA_MAX"),rs.getInt("PRECIO"),rs.getInt("RECARGO"));
				precios.agregarPrecio(p);
			}
			stm.close();
			rs.close();
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println("ERROR SQL!");
		}
		return precios;
	}
	
	
	
	public static int borrarMes(int a�o, int mes) throws Exception{
		int p =0;
		try{
			Statement stm = Conexion.conectar().createStatement();			
			p = stm.executeUpdate("DELETE FROM PRECIOS_MENSUALES WHERE A�O="+a�o+" AND MES >="+mes);
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println("ERROR SQL!!");
		}
		return p;
	}
	
	public static int modificarMes(PrecioMes p,int mes) throws Exception{
		int i=0;
		try{
			Statement stm = Conexion.conectar().createStatement();					
			i = stm.executeUpdate("UPDATE PRECIOS_MENSUALES SET REGULAR="+p.getRegular()+",GRUPO="+p.getGrupo()+",HIJOS="+p.getHijos()+",RECARGO="+p.getRecargo()+" WHERE A�O = "+ p.getA�o() + " AND MES>=" + mes);
			stm.close();
			try {
				Conexion.desconectar();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}catch(SQLException sqle){
			System.out.println("ERROR SQL!!!");
		}
		return i;
	}
	
	public static PrecioMes getOneMes(int a�o, int mes) throws Exception{
		PrecioMes p=null;
		try {
			Statement stm = Conexion.conectar().createStatement();
			ResultSet rs = stm.executeQuery("SELECT * FROM PRECIOS_MENSUALES WHERE A�O="+a�o+" AND MES="+mes);
			while(rs.next()){
				p = new PrecioMes(rs.getInt("A�O"),rs.getInt("MES"),rs.getInt("REGULAR"),rs.getInt("GRUPO"),rs.getInt("HIJOS"),rs.getInt("RECARGO"));
			}
			stm.close();
			rs.close();
			Conexion.desconectar();
			
		} catch (SQLException e) {
			System.out.println("ERROR SQL!!!");
		}
		return p;
	}
	
	public static int altaPrecioInscrip(PrecioInscrip p) throws Exception{
		
		Statement stm = Conexion.conectar().createStatement();		
		int i = stm.executeUpdate("INSERT INTO PRECIOS_INSCRIPCION VALUES("+p.getA�o()+", '"+p.getFecha_max()+"',"+ p.getPrecio() +","+ p.getRecargo() + ")");
		stm.close();
		Conexion.desconectar();
		return i;
	}
	
	public static PrecioInscrip getOneInscrip(int a�o) throws Exception{
		
		PrecioInscrip p=null;
		try {
			Statement stm = Conexion.conectar().createStatement();
							
			ResultSet rs = stm.executeQuery("SELECT * FROM PRECIOS_INSCRIPCION WHERE A�O="+a�o);
			while(rs.next()){
				p = new PrecioInscrip(rs.getInt("A�O"),rs.getString("FECHA_MAX"),rs.getInt("PRECIO"),rs.getInt("RECARGO"));
			}
			stm.close();
			rs.close();
			Conexion.desconectar();
			
		} catch (SQLException e) {
			System.out.println("ERROR SQL!!!");
		}
		return p;
	}
	
	public static int modificarInscrip(PrecioInscrip p) throws Exception{
		int i=0;
		try{
			Statement stm = Conexion.conectar().createStatement();
			
			//System.out.println("UPDATE PRECIOS_INSCRIPCION SET FECHA_MAX= '"+p.getFecha_max()+"' ,PRECIO= " + p.getPrecio() +", RECARGO= "+ p.getRecargo() + " WHERE A�O = "+ p.getA�o());
			
			i = stm.executeUpdate("UPDATE PRECIOS_INSCRIPCION SET FECHA_MAX= '"+p.getFecha_max()+"' ,PRECIO= " + p.getPrecio() +", RECARGO= "+ p.getRecargo() + " WHERE A�O = "+ p.getA�o());
			stm.close();
			try {
				Conexion.desconectar();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}catch(SQLException sqle){
			System.out.println("ERROR SQL!!!");
		}
		return i;
	}
	
	public static int borrarInscrip(int a�o) throws Exception{
		int p =0;
		try{
			Statement stm = Conexion.conectar().createStatement();			
			p = stm.executeUpdate("DELETE FROM PRECIOS_INSCRIPCION WHERE A�O="+a�o);
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println("ERROR SQL!!");
		}
		return p;
	}
}

