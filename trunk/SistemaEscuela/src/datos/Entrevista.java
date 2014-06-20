package datos;

public class Entrevista {

	private String fecha;
	private String hora;
	private int maestro;
	private String nombre;
	private String descripcion;	
	
	public Entrevista() {
		// TODO Auto-generated constructor stub
	}
	
	public Entrevista(String fecha, String hora, int maestro, String nombre, String descripcion) {
		this.fecha = fecha;
		this.hora = hora;
		this.maestro = maestro;
		this.nombre = nombre;
		this.descripcion = descripcion;				
	}
	
	public String getFecha() {
		return fecha;
	}
	
	public String getHora() {
		return hora;
	}
	
	public int getMaestro() {
		return maestro;
	}
	
	public String getNombre() {
		return nombre;
	}
	
	public String getDescripcion() {
		return descripcion;
	}	
	
	public String toString() {
		return fecha + " " + hora + " " +maestro + " " + nombre + " " + descripcion;
	}

}
