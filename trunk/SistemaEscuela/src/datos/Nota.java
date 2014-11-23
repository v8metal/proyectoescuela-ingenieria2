package datos;

public class Nota {
	
	private String grado;
	private String turno;
	private int año;
	private int dni;
	private String materia;
	private String periodo;
	private String calific;
	
	public Nota() {
		
	}

	public Nota(String grado, String turno, int año, int dni, String materia,String periodo, String calific) {		
		this.grado = grado;
		this.turno = turno;
		this.año = año;
		this.dni = dni;
		this.materia = materia;
		this.periodo = periodo;
		this.calific = calific;
	}

	public String getGrado() {
		return grado;
	}

	public String getTurno() {
		return turno;
	}

	public int getAño() {
		return año;
	}

	public int getDni() {
		return dni;
	}

	public String getMateria() {
		return materia;
	}

	public String getPeriodo() {
		return periodo;
	}

	public String getCalific() {
		return calific;
	}
	
	public void setCalific(String calific) {
		this.calific = calific;
	}
	
}
