package datos;

public class Observacion {
	
	private int dni;
	private int a�o;
	private String observaciones;
	
	public Observacion() {
		
	}

	public Observacion(int dni, int a�o, String observaciones) {
		super();
		this.dni = dni;
		this.a�o = a�o;
		this.observaciones = observaciones;
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

	public String getObservaciones() {
		return observaciones;
	}

	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Observacion other = (Observacion) obj;
		if (a�o != other.a�o)
			return false;
		if (dni != other.dni)
			return false;
		if (observaciones == null) {
			if (other.observaciones != null)
				return false;
		} else if (!observaciones.equals(other.observaciones))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Observaciones [dni=" + dni + ", a�o=" + a�o
				+ ", observaciones=" + observaciones + "]";
	}

}
