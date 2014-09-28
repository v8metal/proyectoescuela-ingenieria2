package datos;

public class PrecioInscrip {
	private int a�o;
	private String fecha_max;
	private int precio;
	private int recargo;

	public PrecioInscrip() {
		
	}
	
	public PrecioInscrip(int a�o, String fecha_max, int precio, int recargo) {
		this.a�o = a�o;
		this.fecha_max = fecha_max;
		this.precio = precio;
		this.recargo = recargo;
	}
	
	public int getA�o() {
		return a�o;
	}
	
	public String getFecha_max() {
		return fecha_max;
	}
	
	public int getPrecio() {
		return precio;
	}
	
	public int getRecargo() {
		return recargo;
	}
	
	
	public String toString() {
		return "A�O = " + a�o + " FECHA MAXIMA= " + fecha_max + " PRECIO = " + precio + " RECARGO = " + recargo;
	}

}
