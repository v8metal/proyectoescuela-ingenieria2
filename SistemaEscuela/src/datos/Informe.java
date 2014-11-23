package datos;

public class Informe {

	private String grado;
	private String turno;
	private int a�o;
	private int dni;
	private String marzo;
	private String mitad;
	private String fin;
	
	public Informe() {	
	}
	
	public Informe(String grado, String turno, int a�o, int dni, String marzo, String mitad, String fin) {
		this.grado = grado;
		this.turno = turno;
		this.a�o = a�o;
		this.dni = dni;
		this.marzo = marzo;
		this.mitad = mitad;
		this.fin = fin;
	}
	
	public String getGrado() {
		return grado;
	}
	
	public String getTurno() {
		return turno;
	}
	
	public int getA�o() {
		return a�o;
	}
	
	public int getDni() {
		return dni;
	}
	
	public String getMarzo() {
		return marzo;
	}
	
	public String getMitad() {
		return mitad;
	}
	
	public String getFin() {
		return fin;
	}
	
}
