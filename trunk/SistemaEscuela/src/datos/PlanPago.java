package datos;

public class PlanPago {

	private int cod_plan;
	private int dni;
	private int a�oini;
	private int a�ofin;
	private int periodoini;
	private int periodofin;
	private String fecha;
	private String observaciones;
	
	public PlanPago() {	
		
	}
	
	public PlanPago(int cod_plan, int dni, int a�oini, int a�ofin, int periodoini, int periodofin,String fecha, String observaciones) {
		
		this.cod_plan = cod_plan;
		this.dni = dni;
		this.a�oini = a�oini;
		this.a�ofin = a�ofin;
		this.periodoini = periodoini;
		this.periodofin = periodofin;
		this.fecha = fecha;
		this.observaciones = observaciones;
	}
	
	public int getCod_plan() {
		return cod_plan;
	}
	
	public int getDni() {
		return dni;
	}
	
	public int getA�oini() {
		return a�oini;
	}
	
	public int getA�ofin() {
		return a�ofin;
	}
	
	public int getPeriodoini() {
		return periodoini;
	}
	
	public int getPeriodofin() {
		return periodofin;
	}
	
	public String getFecha() {
		return fecha;
	}
	
	public String getObservaciones() {
		return observaciones;
	}
	
}