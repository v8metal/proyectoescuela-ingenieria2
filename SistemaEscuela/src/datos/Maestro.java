	package datos;

public class Maestro {
	
	private int dni;
	private String apellido;
	private String nombre;	
	private String domicilio;
	private String telefono;
	private int estado;
	
	public Maestro() {
		
	}

	public Maestro(int dni, String apellido, String nombre, String domicilio, String telefono, int estado) {
		this.dni = dni;		
		this.apellido = apellido;
		this.nombre = nombre;		
		this.domicilio = domicilio;
		this.telefono = telefono;
		this.estado = estado;
	}


	public int getDni() {
		return dni;
	}

	public String getApellido() {
		return apellido;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getDomicilio() {
		return domicilio;
	}


	public String getTelefono() {
		return telefono;
	}
	
	public int getEstado() {
		return estado;
	}

	public void setEstado(int estado) {
		this.estado = estado;
	}
	
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Maestro other = (Maestro) obj;
		if (apellido == null) {
			if (other.apellido != null)
				return false;
		} else if (!apellido.equals(other.apellido))
			return false;		
		if (dni != other.dni)
			return false;
		if (domicilio == null) {
			if (other.domicilio != null)
				return false;
		} else if (!domicilio.equals(other.domicilio))
			return false;
		if (nombre == null) {
			if (other.nombre != null)
				return false;
		} else if (!nombre.equals(other.nombre))
			return false;
		if (telefono == null) {
			if (other.telefono != null)
				return false;
		} else if (!telefono.equals(other.telefono))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Maestro [dni=" + dni + ", apellido=" + apellido
				+ ", nombre=" + nombre + ", domicilio="
				+ domicilio + ", telefono=" + telefono + "]";
	}

}
