package datos;

public class PlanPago {

	private int cod_plan;
	private int dni;
	private int añoini;
	private int añofin;
	private int periodoini;
	private int periodofin;
	private String fecha;
	private String observaciones;
	
	public PlanPago() {	
		
	}
	
	public PlanPago(int cod_plan, int dni, int añoini, int añofin, int periodoini, int periodofin,String fecha, String observaciones) {
		
		this.cod_plan = cod_plan;
		this.dni = dni;
		this.añoini = añoini;
		this.añofin = añofin;
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
	
	public int getAñoini() {
		return añoini;
	}
	
	public int getAñofin() {
		return añofin;
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