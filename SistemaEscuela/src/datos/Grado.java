package datos;

public class Grado {

	private String grado;
	private String turno;
	private boolean bimestre;
	private String salon;
	private Integer año;
	private Integer maestrotit;
	private Integer maestropar;
	
	public Grado() {
		
	}
	
	public Grado(String grado,String turno,boolean bimestre, String salon, int año, int maestrotit,int maestropar) {
		this.grado = grado;
		this.turno = turno;
		this.bimestre = bimestre;
		this.salon = salon;
		this.año = año;
		this.maestrotit = maestrotit;
		this.maestropar = maestropar;
	}	
	
	public Grado(String grado,String turno,boolean bimestre, String salon) {
		this.grado = grado;
		this.turno = turno;
		this.bimestre = bimestre;
		this.salon = salon;
	}
	
	public String getGrado() {
		return grado;
	}
	
	public String getTurno() {
		return turno;
	}
	
	public boolean getBimestre() {
		return bimestre;
	}
	
	public String getSalon() {
		return salon;
	}
	
	public int getAño() {
		return año;
	}
	
	public int getMaestrotit() {
		return maestrotit;
	}
	
	public int getMaestropar() {
		return maestropar;
	}
		
	public String getEvaluacion(){
		
		if(bimestre){
			return "Bimestral";
		}
		else return "Trimestral";
	}
	
	public String toString() {
		return grado + "|"  + turno + "|" + bimestre + "|" + salon + "|" + año + "|" + maestrotit + "|" + maestropar;
	}

}
