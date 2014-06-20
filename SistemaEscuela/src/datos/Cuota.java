package datos;

import datos.Cuota;

public class Cuota {
	private int dni;
	private int a�o;
	private String periodo;
	private int reinscripcion;
	private int reinscripcion_ant;
	
	public Cuota(){
		
	}

	public Cuota(int dni, int a�o, String periodo, int reinscripcion,
			int reinscripcion_ant) {
		super();
		this.dni = dni;
		this.a�o = a�o;
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

	public int getA�o() {
		return a�o;
	}

	public void setA�o(int a�o) {
		this.a�o = a�o;
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
		if (a�o != other.a�o)
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
		return "Cuota [dni=" + dni + ", a�o=" + a�o + ", periodo=" + periodo
				+ ", reinscripcion=" + reinscripcion + ", reinscripcion_ant="
				+ reinscripcion_ant + "]";
	}
}
