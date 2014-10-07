package datos;

public class PagoPlanPago {

	private int cod_plan;
	private int cod_pago;
	private int dni;
	private String fecha;
	private double pago;
	private String observaciones;
	
	public PagoPlanPago() {
		// TODO Auto-generated constructor stub
	}
	
	public PagoPlanPago(int cod_plan, int cod_pago, int dni, String fecha, double pago, String observaciones) {
		
		this.cod_plan = cod_plan;
		this.cod_pago = cod_pago;
		this.dni = dni;
		this.fecha = fecha;
		this.pago = pago;
		this.observaciones = observaciones;		
	}
	
	public int getCod_plan() {
		return cod_plan;
	}
	
	public int getCod_pago() {
		return cod_pago;
	}
	
	public int getDni() {
		return dni;
	}
	
	public String getFecha() {
		return fecha;
	}
	
	public double getPago() {
		return pago;
	}
	
	public String getObservaciones() {
		return observaciones;
	}
	
}
