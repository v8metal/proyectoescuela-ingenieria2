package datos;

public class Estado {
	
	private int dni;
	private String fecha;
	private boolean activo;
	
	public Estado() {
		
	}
	
	public Estado(int dni, String fecha, boolean activo) {
		super();
		this.dni = dni;
		this.fecha = fecha;
		this.activo = activo;
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

	public boolean isActivo() {
		return activo;
	}

	public void setActivo(boolean activo) {
		this.activo = activo;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Estado other = (Estado) obj;
		if (activo != other.activo)
			return false;
		if (dni != other.dni)
			return false;
		if (fecha == null) {
			if (other.fecha != null)
				return false;
		} else if (!fecha.equals(other.fecha))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Estado [dni=" + dni + ", fecha=" + fecha + ", activo=" + activo
				+ "]";
	}

}
