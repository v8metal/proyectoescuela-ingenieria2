package datos;

public class Grado {

	private String grado;
	private String turno;
	private Integer evaluacion;
	private boolean bimestre;	
	private String salon;
	private Integer año;
	private Integer maestrotit;
	private Integer maestropar;
	
	public Grado() {
		
	}
	
	public Grado(String grado,String turno,int evaluacion,boolean bimestre, String salon, int año, int maestrotit,int maestropar) {
		this.grado = grado;
		this.turno = turno;
		this.evaluacion = evaluacion;
		this.bimestre = bimestre;		
		this.salon = salon;
		this.año = año;
		this.maestrotit = maestrotit;
		this.maestropar = maestropar;
	}	
	
	public Grado(String grado,String turno, int evaluacion, boolean bimestre, String salon) {
		this.grado = grado;
		this.turno = turno;
		this.evaluacion = evaluacion;
		this.bimestre = bimestre;
		this.salon = salon;
		this.año = 0;
		this.maestrotit = 0;
		this.maestropar = 0;
	}
	
	public Grado(String grado,String turno) {
		this.grado = grado;
		this.turno = turno;
		this.evaluacion = null;
		this.bimestre = false;
		this.salon = null;
		this.año = null;
		this.maestrotit = null;
		this.maestropar = null;
	}
	
	//para el cobro de cuotas
	public Grado(String grado,String turno, int año) {
		this.grado = grado;
		this.turno = turno;
		this.evaluacion = null;
		this.bimestre = false;
		this.salon = null;
		this.año = año;
		this.maestrotit = null;
		this.maestropar = null;
	}
	//para el cobro de cuotas
	
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
	
	public Integer getEvaluacion() {
		return evaluacion;
	}
	
	public String getEvaluacionNombre(){
		
		   String evaluacionNombre = "";
		   
		   if (evaluacion == 0 )

			   evaluacionNombre = "Informe";
		   	   
		   if (evaluacion == 1 )
	   		   
	   		   evaluacionNombre = "Cualitativa";
		   	   
		   if (evaluacion == 2 )
	  		   
	  		   evaluacionNombre = "Numérica";		   
		   
		   return evaluacionNombre;		    
	}
	
	public String getPeriodo(){
		
		if(bimestre){
			return "Bimestral";
		}
		else return "Trimestral";
	}
	
	public String toString() {
		return grado + "|"  + turno + "|" + "|" + evaluacion + "|" + bimestre + "|" + salon + "|" + año + "|" + maestrotit + "|" + maestropar;
	}

}
