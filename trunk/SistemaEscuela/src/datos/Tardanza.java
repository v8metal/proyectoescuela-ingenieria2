package datos;

import datos.Tardanza;

public class Tardanza {
	private int dni;
	private String fecha;
	private String observaciones;
	private String tipo;
	private String indicador;
	
	public Tardanza(){
		
	}
	
	public Tardanza(int dni, String fecha, String observaciones, String tipo,
			String indicador) {
		super();
		this.dni = dni;
		this.fecha = fecha;
		this.observaciones = observaciones;
		this.tipo = tipo;
		this.indicador = indicador;
	}
	public int getDni() {
		return dni;
	}
	public void setDni(int dni) {
		this.dni = dni;
	}
	public String getFecha() {
		return fecha;
	}
	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
	public String getObservaciones() {
		return observaciones;
	}
	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public String getIndicador() {
		return indicador;
	}
	public void setIndicador(String indicador) {
		this.indicador = indicador;
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Tardanza other = (Tardanza) obj;
		if (dni != other.dni)
			return false;
		if (fecha == null) {
			if (other.fecha != null)
				return false;
		} else if (!fecha.equals(other.fecha))
			return false;
		if (indicador == null) {
			if (other.indicador != null)
				return false;
		} else if (!indicador.equals(other.indicador))
			return false;
		if (observaciones == null) {
			if (other.observaciones != null)
				return false;
		} else if (!observaciones.equals(other.observaciones))
			return false;
		if (tipo == null) {
			if (other.tipo != null)
				return false;
		} else if (!tipo.equals(other.tipo))
			return false;
		return true;
	}

	public String toString() {
		return "Tardanza [dni=" + dni + ", fecha=" + fecha + ", observaciones="
				+ observaciones + ", tipo=" + tipo + ", indicador=" + indicador
				+ "]";
	}
}
