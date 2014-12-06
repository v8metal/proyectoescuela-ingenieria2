package datos;

public class Mensaje {
	
	private int cod_mensaje;
	private String tipo;
	private String mensaje;

	public Mensaje() {
	
	}
	
	public Mensaje(int cod_mensaje, String tipo, String mensaje) {
		
		this.cod_mensaje = cod_mensaje;
		this.tipo = tipo;
		this.mensaje = mensaje;
		
	}	
	
	public int getcod_mensaje() {
		return cod_mensaje;
	}
	
	public String getTipo() {
		return tipo;
	}
	
	public String getMensaje() {
		return mensaje;
	}
	
}
