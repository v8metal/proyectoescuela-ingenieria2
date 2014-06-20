package datos;

public class Maestro {
	
	private int cod_maest;
	private String apellido;
	private String nombre;
	private int dni;
	private String domicilio;
	private String telefono;
	
	public Maestro() {
		
	}

	public Maestro(int cod_maest, String apellido, String nombre, int dni,
			String domicilio, String telefono) {
		super();
		this.cod_maest = cod_maest;
		this.apellido = apellido;
		this.nombre = nombre;
		this.dni = dni;
		this.domicilio = domicilio;
		this.telefono = telefono;
	}

	public int getCod_maest() {
		return cod_maest;
	}

	public void setCod_maest(int cod_maest) {
		this.cod_maest = cod_maest;
	}

	public String getApellido() {
		return apellido;
	}

	public void setApellido(String apellido) {
		this.apellido = apellido;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public int getDni() {
		return dni;
	}

	public void setDni(int dni) {
		this.dni = dni;
	}

	public String getDomicilio() {
		return domicilio;
	}

	public void setDomicilio(String domicilio) {
		this.domicilio = domicilio;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	@Override
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
		if (cod_maest != other.cod_maest)
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
		return "Maestro [cod_maest=" + cod_maest + ", apellido=" + apellido
				+ ", nombre=" + nombre + ", dni=" + dni + ", domicilio="
				+ domicilio + ", telefono=" + telefono + "]";
	}

}
