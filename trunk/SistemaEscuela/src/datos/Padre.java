package datos;

public class Padre {
	
	private int dni;
	private String nombre;
	private String apellido;
	private String lugar_nac;
	private String fecha_nac;
	private String domicilio;
	private String telefono;
	private String ocupacion;
	private String dom_lab;
	private String tel_lab;
	private String est_civil;
	
	public Padre() {
		
	}

	public Padre(int dni, String nombre, String apellido, String lugar_nac,
			String fecha_nac, String domicilio, String telefono,
			String ocupacion, String dom_lab, String tel_lab, String est_civil) {
		super();
		this.dni = dni;
		this.nombre = nombre;
		this.apellido = apellido;
		this.lugar_nac = lugar_nac;
		this.fecha_nac = fecha_nac;
		this.domicilio = domicilio;
		this.telefono = telefono;
		this.ocupacion = ocupacion;
		this.dom_lab = dom_lab;
		this.tel_lab = tel_lab;
		this.est_civil = est_civil;
	}

	public int getDni() {
		return dni;
	}

	public void setDni(int dni) {
		this.dni = dni;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getApellido() {
		return apellido;
	}

	public void setApellido(String apellido) {
		this.apellido = apellido;
	}

	public String getLugar_nac() {
		return lugar_nac;
	}

	public void setLugar_nac(String lugar_nac) {
		this.lugar_nac = lugar_nac;
	}

	public String getFecha_nac() {
		return fecha_nac;
	}

	public void setFecha_nac(String fecha_nac) {
		this.fecha_nac = fecha_nac;
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

	public String getOcupacion() {
		return ocupacion;
	}

	public void setOcupacion(String ocupacion) {
		this.ocupacion = ocupacion;
	}

	public String getDom_lab() {
		return dom_lab;
	}

	public void setDom_lab(String dom_lab) {
		this.dom_lab = dom_lab;
	}

	public String getTel_lab() {
		return tel_lab;
	}

	public void setTel_lab(String tel_lab) {
		this.tel_lab = tel_lab;
	}

	public String getEst_civil() {
		return est_civil;
	}

	public void setEst_civil(String est_civil) {
		this.est_civil = est_civil;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Padre other = (Padre) obj;
		if (apellido == null) {
			if (other.apellido != null)
				return false;
		} else if (!apellido.equals(other.apellido))
			return false;
		if (dni != other.dni)
			return false;
		if (dom_lab == null) {
			if (other.dom_lab != null)
				return false;
		} else if (!dom_lab.equals(other.dom_lab))
			return false;
		if (domicilio == null) {
			if (other.domicilio != null)
				return false;
		} else if (!domicilio.equals(other.domicilio))
			return false;
		if (est_civil == null) {
			if (other.est_civil != null)
				return false;
		} else if (!est_civil.equals(other.est_civil))
			return false;
		if (fecha_nac == null) {
			if (other.fecha_nac != null)
				return false;
		} else if (!fecha_nac.equals(other.fecha_nac))
			return false;
		if (lugar_nac == null) {
			if (other.lugar_nac != null)
				return false;
		} else if (!lugar_nac.equals(other.lugar_nac))
			return false;
		if (nombre == null) {
			if (other.nombre != null)
				return false;
		} else if (!nombre.equals(other.nombre))
			return false;
		if (ocupacion == null) {
			if (other.ocupacion != null)
				return false;
		} else if (!ocupacion.equals(other.ocupacion))
			return false;
		if (tel_lab == null) {
			if (other.tel_lab != null)
				return false;
		} else if (!tel_lab.equals(other.tel_lab))
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
		return "Padre [dni=" + dni + ", nombre=" + nombre + ", apellido="
				+ apellido + ", lugar_nac=" + lugar_nac + ", fecha_nac="
				+ fecha_nac + ", domicilio=" + domicilio + ", telefono="
				+ telefono + ", ocupacion=" + ocupacion + ", dom_lab="
				+ dom_lab + ", tel_lab=" + tel_lab + ", est_civil=" + est_civil
				+ "]";
	}
	
}
