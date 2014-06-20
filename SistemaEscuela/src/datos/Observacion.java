package datos;

public class Observacion {
	
	private int dni;
	private int año;
	private String observaciones;
	
	public Observacion() {
		
	}

	public Observacion(int dni, int año, String observaciones) {
		super();
		this.dni = dni;
		this.año = año;
		this.observaciones = observaciones;
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
		if (año != other.año)
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
		return "Observaciones [dni=" + dni + ", año=" + año
				+ ", observaciones=" + observaciones + "]";
	}

}
