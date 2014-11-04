package datos;

public class Entrevista {

	private String fecha;
	private String hora;
	private int dniMaestro;
	private String nombre;
	private String descripcion;	
	
	public Entrevista() {
		// TODO Auto-generated constructor stub
	}
	
	public Entrevista(String fecha, String hora, int dniMaestro, String nombre, String descripcion) {
		this.fecha = fecha;
		this.hora = hora;
		this.dniMaestro =dniMaestro;
		this.nombre = nombre;
		this.descripcion = descripcion;				
	}
	
	public String getFecha() {
		return fecha;
	}
	
	public String getHora() {
		return hora;
	}
	
	public int getdniMaestro() {
		return dniMaestro;
	}
	
	public String getNombre() {
		return nombre;
	}
	
	public String getDescripcion() {
		return descripcion;
	}	
	
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	public String toString() {
		return fecha + " " + hora + " " + dniMaestro + " " + nombre + " " + descripcion;
	}

}
