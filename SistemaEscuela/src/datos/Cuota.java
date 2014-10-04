package datos;

public class Cuota {

	private int cod_pago;
	private int dni;
	private int a�o;
	private int periodo;
	String fecha;
	double pago;
	
	public Cuota() {	
	}
	
	public Cuota(int cod_pago, int dni, int a�o, int periodo, String fecha, double pago) {	
		
		this.cod_pago = cod_pago;
		this.dni = dni;
		this.a�o = a�o;
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
	
	public int getA�o() {
		return a�o;
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
