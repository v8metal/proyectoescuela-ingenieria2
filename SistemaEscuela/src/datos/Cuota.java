package datos;

public class Cuota {

	private int cod_pago;
	private int dni;
	private int año;
	private int periodo;
	String fecha;
	double pago;
	
	public Cuota() {	
	}
	
	public Cuota(int cod_pago, int dni, int año, int periodo, String fecha, double pago) {	
		
		this.cod_pago = cod_pago;
		this.dni = dni;
		this.año = año;
		this.periodo = periodo;
		this.fecha = fecha;
		this.pago = pago; 
	}
	
	public int getCod_pago() {
		return cod_pago;
	}
	
	public int getDni() {
		return dni;
	}
	
	public int getAño() {
		return año;
	}
	
	public int getPeriodo() {
		return periodo;
	}
	
	public String getFecha() {
		return fecha;
	}
	
	public double getPago() {
		return pago;
	}
	
}
