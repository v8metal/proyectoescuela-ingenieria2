package datos;

public class PrecioInscrip {
	private int año;
	private String fecha_max;
	private int precio;
	private int recargo;

	public PrecioInscrip() {
		
	}
	
	public PrecioInscrip(int año, String fecha_max, int precio, int recargo) {
		this.año = año;
		this.fecha_max = fecha_max;
		this.precio = precio;
		this.recargo = recargo;
	}
	
	public int getAño() {
		return año;
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
		return "AÑO = " + año + " FECHA MAXIMA= " + fecha_max + " PRECIO = " + precio + " RECARGO = " + recargo;
	}

}
