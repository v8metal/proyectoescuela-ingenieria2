package conexion;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import conexion.Conexion;
import datos.Precio;
import datos.Precios;

public class AccionesPrecio {
	public static int altaPrecio(Precio precio) throws Exception{
		Statement stm = Conexion.conectar().createStatement();
		int i = stm.executeUpdate("INSERT INTO PRECIOS VALUES("+precio.getA�o()+","+precio.getMes()+","+precio.getPrec_reg()+","+precio.getPrec_grupo()+","+precio.getReinsc_ant()+","+precio.getReinsc()+")");
		stm.close();
		Conexion.desconectar();
		return i;
	}
	
	public static Precios getAllPrecios(int a�o) throws Exception{
		Precios precios = new Precios();
		try{
			Statement stm = Conexion.conectar().createStatement();
			ResultSet rs = stm.executeQuery("SELECT * FROM PRECIOS WHERE A�O="+a�o);
			Precio p;
			while(rs.next()){
				p = new Precio(rs.getInt("A�O"),rs.getInt("MES"),rs.getInt("PREC_REG"),rs.getInt("PREC_GRUPO"),rs.getInt("REINSC_ANT"),rs.getInt("REINSC"));
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
	
	public static int borrarPrecio(int a�o, int mes) throws Exception{
		int p =0;
		try{
			Statement stm = Conexion.conectar().createStatement();
			int c=stm.executeUpdate("DELETE FROM CUOTAS WHERE A�O="+a�o);
			p = stm.executeUpdate("DELETE FROM PRECIOS WHERE A�O="+a�o+" AND MES="+mes);
			Conexion.desconectar();
		}catch(SQLException sqle){
			System.out.println("ERROR SQL!!");
		}
		return p;
	}
	
	public static int modificarPrecio(Precio p,int mes) throws Exception{
		int i=0;
		try{
			Statement stm = Conexion.conectar().createStatement();
			i = stm.executeUpdate("UPDATE PRECIOS SET A�O="+p.getA�o()+",MES="+p.getMes()+",PREC_REG="+p.getPrec_reg()+",PREC_GRUPO="+p.getPrec_grupo()+",REINSC_ANT="+p.getReinsc_ant()+",REINSC="+p.getReinsc()+" WHERE MES="+mes);
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
	
	public static Precio getOnePrecio(int a�o, int mes) throws Exception{
		Precio p=null;
		try {
			Statement stm = Conexion.conectar().createStatement();
			ResultSet rs = stm.executeQuery("SELECT * FROM PRECIOS WHERE A�O="+a�o+" AND MES="+mes);
			while(rs.next()){
				p = new Precio(rs.getInt("A�O"),rs.getInt("MES"),rs.getInt("PREC_REG"),rs.getInt("PREC_GRUPO"),rs.getInt("REINSC_ANT"),rs.getInt("REINSC"));
			}
			stm.close();
			rs.close();
			Conexion.desconectar();
			
		} catch (SQLException e) {
			System.out.println("ERROR SQL!!!");
		}
		return p;
	}
}
