package datos;

public class Citacion {
	private int dni;
	private String grado;
	private String turno;
	private String fecha;
	private String hora;
	private String descripcion;	
	
	public Citacion() {
		// TODO Auto-generated constructor stub
	}
	
	public Citacion(int dni, String fecha, String hora, String descripcion) {
		this.dni = dni;	
		this.fecha = fecha;
		this.hora = hora;
		this.descripcion = descripcion;		
	}
	
	public Citacion(int dni, String grado, String turno, String fecha, String hora, String descripcion) {
		this.dni = dni;
		
		if(grado.equals("1er")){
			this.grado = "1º GRADO";
		}else if(grado.equals("2do")){
			this.grado = "2º GRADO";
		}else if(grado.equals("3er")){
			this.grado = "3º GRADO";
		}else if(grado.equals("4to")){
			this.grado = "4º GRADO";
		}else if(grado.equals("5to")){
			this.grado = "5º GRADO";
		}else if(grado.equals("6to")){
			this.grado = "6º GRADO";		
		}else if(grado.equals("7mo")){
			this.grado = "7º GRADO";
		}else{
			this.grado = grado;
		}
		
		this.turno = turno;
		this.fecha = fecha;
		this.hora = hora;
		this.descripcion = descripcion;		
	}
	
	public int getDni() {
		return dni;
	}
	
	public String getGrado() {
		return grado;
	}
	
	public String getTurno() {
		return turno;
	}
	
	public String getFecha() {
		return fecha;
	}
	
	public String getHora() {
		return hora;
	}
	
	public String getDescripcion() {
		return descripcion;
	}
	
	public String toString() {
		return dni + " | " + /*cod_maestro +*/ " | " + fecha + " | " + hora + " | " + descripcion ;
	}
	
}
