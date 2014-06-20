package datos;

import datos.Cuota;

public class Cuota {
	private int dni;
	private int año;
	private String periodo;
	private int reinscripcion;
	private int reinscripcion_ant;
	
	public Cuota(){
		
	}

	public Cuota(int dni, int año, String periodo, int reinscripcion,
			int reinscripcion_ant) {
		super();
		this.dni = dni;
		this.año = año;
		this.periodo = periodo;
		this.reinscripcion = reinscripcion;
		this.reinscripcion_ant = reinscripcion_ant;
	}

	public int getDni() {
		return dni;
	}

	public void setDni(int dni) {
		this.dni = dni;
	}

	public int getAño() {
		return año;
	}

	public void setAño(int año) {
		this.año = año;
	}

	public String getPeriodo() {
		return periodo;
	}

	public void setPeriodo(String periodo) {
		this.periodo = periodo;
	}

	public int getReinscripcion() {
		return reinscripcion;
	}

	public void setReinscripcion(int reinscripcion) {
		this.reinscripcion = reinscripcion;
	}

	public int getReinscripcion_ant() {
		return reinscripcion_ant;
	}

	public void setReinscripcion_ant(int reinscripcion_ant) {
		this.reinscripcion_ant = reinscripcion_ant;
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Cuota other = (Cuota) obj;
		if (año != other.año)
			return false;
		if (dni != other.dni)
			return false;
		if (periodo == null) {
			if (other.periodo != null)
				return false;
		} else if (!periodo.equals(other.periodo))
			return false;
		if (reinscripcion != other.reinscripcion)
			return false;
		if (reinscripcion_ant != other.reinscripcion_ant)
			return false;
		return true;
	}

	public String toString() {
		return "Cuota [dni=" + dni + ", año=" + año + ", periodo=" + periodo
				+ ", reinscripcion=" + reinscripcion + ", reinscripcion_ant="
				+ reinscripcion_ant + "]";
	}
}
