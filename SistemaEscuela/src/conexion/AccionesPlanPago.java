package conexion;

import java.sql.ResultSet;
import java.sql.Statement;

import datos.PagoPlanPago;
import datos.PagosPlanPago;
import datos.PlanPago;


public class AccionesPlanPago {

	
		public static int checkPlanPagosMes(int dni, int año, int mes) throws Exception{
		
		int cod_plan = 0;
		int añoini= 0;
		int añofin= 0;
		
		Statement stm = Conexion.conectar().createStatement();	
		
		System.out.println("SELECT COD_PLAN, AÑOINI, AÑOFIN FROM PLAN_CUOTAS WHERE " + año + " BETWEEN AÑOINI AND AÑOFIN AND DNI = " + dni);
		
		ResultSet rs = stm.executeQuery("SELECT COD_PLAN, AÑOINI, AÑOFIN FROM PLAN_CUOTAS WHERE " + año + " BETWEEN AÑOINI AND AÑOFIN AND DNI = " + dni);
		
		while(rs.next()){
			cod_plan = rs.getInt("COD_PLAN");
			añoini = rs.getInt("AÑOINI");
			añofin = rs.getInt("AÑOFIN");
		}
		
				
		if(cod_plan != 0) {
			
			System.out.println("añoini= " + añoini);
			System.out.println("añofin= " + añofin);
			
			if(añoini == añofin){ //si el plan de pagos abarca un mismo año
				
				rs.close();
				
				System.out.println("SELECT COD_PLAN FROM PLAN_CUOTAS WHERE "+ mes + " BETWEEN PERIODOINI AND PERIODOFIN " +" AND AÑOFIN = "+ año + " AND COD_PLAN = " + cod_plan);
				
				rs = stm.executeQuery("SELECT COD_PLAN FROM PLAN_CUOTAS WHERE "+ mes + " BETWEEN PERIODOINI AND PERIODOFIN " +" AND AÑOFIN = "+ año + " AND COD_PLAN = " + cod_plan);
				
			}else{			
			
				if(año < añofin){ //si el año  es menor al fin del PP
				
					rs.close();				
					rs = stm.executeQuery("SELECT COD_PLAN FROM PLAN_CUOTAS WHERE "+ mes + ">= PERIODOINI AND COD_PLAN = " + cod_plan);
			
				}else{
				
			
					if(año == añofin){			
				
					rs.close();				
					rs = stm.executeQuery("SELECT COD_PLAN FROM PLAN_CUOTAS WHERE "+ mes + "<= PERIODOFIN AND COD_PLAN = " + cod_plan);
				
					}
			
				}
			
			}
		
			cod_plan = 0;
			
			while(rs.next()){
				cod_plan = rs.getInt("COD_PLAN");				
			}
	
			
			System.out.println("cod_plan= "+ cod_plan);
		}
		
		rs.close();
		stm.close();
		return cod_plan;
		
	}

	public static int insertOnePlan(PlanPago p) throws Exception{
		
		int i = 0;
		
		Statement stmt = Conexion.conectar().createStatement();	
		
		System.out.println("INSERT INTO PLAN_CUOTAS VALUES (" + 0 + " , " + p.getDni() + " , " + p.getAñoini() + " , " + p.getAñofin() + ", " + ", " + p.getPeriodoini() + " , " + p.getPeriodofin()+" , '" + p.getFecha() + "' , '" + p.getObservaciones() + "')");
		
		stmt.executeUpdate("INSERT INTO PLAN_CUOTAS VALUES (" + 0 + " , " + p.getDni() + " , " + p.getAñoini() + ", " + p.getAñofin() + ", " + p.getPeriodoini() + " , " + p.getPeriodofin()+" , '" + p.getFecha() + "' , '" + p.getObservaciones() + "')");
		
		stmt.close();
		Conexion.desconectar();
		
		return i;
	}
	
	public static PlanPago getOnePlan(int cod_plan) throws Exception{
		
		PlanPago p = null;
				
		Statement stm = Conexion.conectar().createStatement();	
		
		System.out.println("SELECT COD_PLAN, DNI, AÑOINI, AÑOFIN, PERIODOINI, PERIODOFIN, FECHA_ALTA , IFNULL(OBSERVACIONES, '') AS OBSERVACIONES FROM PLAN_CUOTAS WHERE COD_PLAN = " + cod_plan );
		
		ResultSet rs = stm.executeQuery("SELECT COD_PLAN, DNI, AÑOINI, AÑOFIN, PERIODOINI, PERIODOFIN, FECHA_ALTA , IFNULL(OBSERVACIONES, '') AS OBSERVACIONES FROM PLAN_CUOTAS WHERE COD_PLAN = " + cod_plan );
						
		while(rs.next()){
			p = new PlanPago(rs.getInt("COD_PLAN"),rs.getInt("DNI"), rs.getInt("AÑOINI"), rs.getInt("AÑOFIN"), rs.getInt("PERIODOINI"), rs.getInt("PERIODOFIN"),rs.getString("FECHA_ALTA"),rs.getString("OBSERVACIONES")) ;		
		}
			
		stm.close();
		Conexion.desconectar();
		
		return p;
	}
	
	public static int updatePlanPago(PlanPago p) throws Exception{
		
		int i = 0;
		
		Statement stmt = Conexion.conectar().createStatement();	
		
		System.out.println("UPDATE PLAN_CUOTAS SET AÑOINI= "+ p.getAñoini() + ", AÑOFIN= " + p.getAñofin() +", PERIODOINI = " + p.getPeriodoini() + " , PERIODOFIN	 = " + p.getPeriodofin() + ", OBSERVACIONES = '"+ p.getObservaciones() + "' WHERE COD_PLAN = " + p.getCod_plan());
		
		stmt.executeUpdate("UPDATE PLAN_CUOTAS SET AÑOINI= "+ p.getAñoini() + ", AÑOFIN= " + p.getAñofin() +", PERIODOINI = " + p.getPeriodoini() + " , PERIODOFIN	 = " + p.getPeriodofin() + ", OBSERVACIONES = '"+ p.getObservaciones() + "' WHERE COD_PLAN = " + p.getCod_plan());
		
		stmt.close();
		Conexion.desconectar();
		
		return i;
	}
	
	public static int deletePagosPlanPago(int cod_plan) throws Exception{
		
		int i = 0;
		
		Statement stmt = Conexion.conectar().createStatement();	
		
		//System.out.println("DELETE FROM PAGOS_CUOTA WHERE COD_PAGO = " + cod_pago);
		
		stmt.executeUpdate("DELETE FROM PLAN_PAGOS WHERE COD_PLAN = " + cod_plan);
		
		stmt.close();
		Conexion.desconectar();
		
		return i;
	}
	
	public static int deletePlanPago(int cod_plan) throws Exception{
		
		int i = 0;
		
		Statement stmt = Conexion.conectar().createStatement();	
		
		//System.out.println("DELETE FROM PAGOS_CUOTA WHERE COD_PAGO = " + cod_pago);
		
		stmt.executeUpdate("DELETE FROM PLAN_CUOTAS WHERE COD_PLAN = " + cod_plan);
		
		stmt.close();
		Conexion.desconectar();
		
		return i;
	}
	
	public static PagosPlanPago getPagospp(int cod_plan) throws Exception{
		
		PagosPlanPago pagospp = new PagosPlanPago();
				
		Statement stm = Conexion.conectar().createStatement();	
			
		ResultSet rs = stm.executeQuery("SELECT COD_PLAN, COD_PAGO, DNI, FECHA_PAGO, PAGO, IFNULL(OBSERVACIONES, '') AS OBSERVACIONES  FROM PLAN_PAGOS WHERE COD_PLAN = " + cod_plan);
		
		PagoPlanPago pp = null;
		
		while(rs.next()){
			pp = new PagoPlanPago(rs.getInt("COD_PLAN"),rs.getInt("COD_PAGO"), rs.getInt("DNI"),rs.getString("FECHA_PAGO"), rs.getDouble("PAGO"),rs.getString("OBSERVACIONES"));
			pagospp.agregarPago(pp);
		}
			
		stm.close();			
		Conexion.desconectar();		
			
		
		return pagospp;
	}
	
	public static double getTotalPlanPago(int cod_plan) throws Exception{
		
		double d = 0;
				
		Statement stm = Conexion.conectar().createStatement();	
			
		ResultSet rs = stm.executeQuery("SELECT IFNULL(SUM(PAGO),0) AS TOTAL FROM PLAN_PAGOS WHERE COD_PLAN = " + cod_plan);
		
		while(rs.next()){
			d = rs.getDouble("TOTAL");
			
		}
			
		stm.close();			
		Conexion.desconectar();		
			
		
		return d;
	}	
	
	public static PagoPlanPago getOnePagopp(int cod_plan, int cod_pago) throws Exception{
		
		PagoPlanPago p = null;
				
		Statement stm = Conexion.conectar().createStatement();	
		
		System.out.println("SELECT COD_PLAN, COD_PAGO, DNI, FECHA_PAGO, PAGO, IFNULL(OBSERVACIONES, '') AS OBSERVACIONES FROM PLAN_PAGOS WHERE COD_PLAN = " + cod_plan  + " AND COD_PAGO = " + cod_pago);
		
		ResultSet rs = stm.executeQuery("SELECT COD_PLAN, COD_PAGO, DNI, FECHA_PAGO, PAGO, IFNULL(OBSERVACIONES, '') AS OBSERVACIONES FROM PLAN_PAGOS WHERE COD_PLAN = " + cod_plan  + " AND COD_PAGO = " + cod_pago);
						
		while(rs.next()){
			p = new PagoPlanPago(rs.getInt("COD_PLAN"),rs.getInt("COD_PAGO"), rs.getInt("DNI"), rs.getString("FECHA_PAGO"),rs.getDouble("PAGO"),rs.getString("OBSERVACIONES")) ;		
		}
			
		stm.close();
		Conexion.desconectar();
		
		return p;
	}
	
	public static int insertOnePagopp(PagoPlanPago pagopp) throws Exception{
		
		int i = 0;
		
		Statement stmt = Conexion.conectar().createStatement();	
		
		System.out.println("INSERT INTO PLAN_PAGOS VALUES ( " + pagopp.getCod_plan() + " , " + pagopp.getCod_pago() + " , " + pagopp.getDni() + " , '" + pagopp.getFecha() + "' , " + pagopp.getPago() + ", '" + pagopp.getObservaciones() + "' )");
		
		stmt.executeUpdate("INSERT INTO PLAN_PAGOS VALUES ( " + pagopp.getCod_plan() + " , " + pagopp.getCod_pago() + " , " + pagopp.getDni() + " , '" + pagopp.getFecha() + "' , " + pagopp.getPago() + ", '" + pagopp.getObservaciones() + "' )"); 
		
		stmt.close();
		Conexion.desconectar();
		
		return i;
	}
	
	public static int updatePagopp(PagoPlanPago Pagopp) throws Exception{
		
		int i = 0;
		
		Statement stmt = Conexion.conectar().createStatement();	
		
		System.out.println("UPDATE PLAN_PAGOS SET FECHA_PAGO = '"+ Pagopp.getFecha() + "' , PAGO = " + Pagopp.getPago() +", OBSERVACIONES = '" + Pagopp.getObservaciones() + "' WHERE COD_PLAN = " + Pagopp.getCod_plan() + " AND COD_PAGO = " + Pagopp.getCod_pago());
		
		stmt.executeUpdate("UPDATE PLAN_PAGOS SET FECHA_PAGO = '"+ Pagopp.getFecha() + "' , PAGO = " + Pagopp.getPago() +", OBSERVACIONES = '" + Pagopp.getObservaciones() + "' WHERE COD_PLAN = " + Pagopp.getCod_plan() + " AND COD_PAGO = " + Pagopp.getCod_pago());
		
		stmt.close();
		Conexion.desconectar();
		
		return i;
	}
	
	public static int borrarPagopp(int cod_plan, int cod_pago) throws Exception{
		
		int i = 0;
		
		Statement stmt = Conexion.conectar().createStatement();	
		
		System.out.println("DELETE FROM PLAN_PAGOS WHERE COD_PLAN = " + cod_plan + " AND COD_PAGO= " + cod_pago);
		
		stmt.executeUpdate("DELETE FROM PLAN_PAGOS WHERE COD_PLAN = " + cod_plan + " AND COD_PAGO= " + cod_pago);
		
		stmt.close();
		Conexion.desconectar();
		
		return i;
	}
	
	
}
