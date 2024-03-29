package datos;

public class Sancion {
	
	private int dni;
	private String grado;
	private String turno;
	private String fecha;
	private String hora;
	private String motivo;
	
	public Sancion() {
		// TODO Auto-generated constructor stub
	}
	
	public Sancion(int dni, String fecha, String hora, String motivo) {
		this.dni = dni;
		this.fecha = fecha;
		this.hora = hora;
		this.motivo = motivo;
	}
	
	public Sancion(int dni, String grado, String turno, String fecha, String hora, String motivo) {
		
		this.dni = dni;
		
		if(grado.equals("1er")){
			this.grado = "1� GRADO";
		}else if(grado.equals("2do")){
			this.grado = "2� GRADO";
		}else if(grado.equals("3er")){
			this.grado = "3� GRADO";
		}else if(grado.equals("4to")){
			this.grado = "4� GRADO";
		}else if(grado.equals("5to")){
			this.grado = "5� GRADO";
		}else if(grado.equals("6to")){
			this.grado = "6� GRADO";		
		}else if(grado.equals("7mo")){
			this.grado = "7� GRADO";
		}else{
			this.grado = grado;
		}
		
		this.turno = turno;
		this.fecha = fecha;
		this.hora = hora;
		this.motivo = motivo;
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
	
	public String getMotivo() {
		return motivo;
	}	
	
	public String toString() {
		return dni + " | " + fecha + " | " + hora + " | " + motivo;
	}

}