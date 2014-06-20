package datos;

public class Alumno {
	
	private int dni;
	private String nombre;
	private String apellido;
	private String domicilio;
	private String telefono;
	private String fecha_nac;
	private String lugar_nac;
	private int dni_tutor;
	private int dni_madre;
	private int cant_her_may;
	private int cant_her_men;
	private String iglesia;
	private String esc;
	private boolean ind_grupo;
	private boolean ind_subsidio;
	
	public Alumno() {
		
	}

	public Alumno(int dni, String nombre, String apellido, String domicilio,
			String telefono, String fecha_nac, String lugar_nac, int dni_tutor,
			int dni_madre, int cant_her_may, int cant_her_men, String iglesia,
			String esc, boolean ind_grupo, boolean ind_subsidio) {
		super();
		this.dni = dni;
		this.nombre = nombre;
		this.apellido = apellido;
		this.domicilio = domicilio;
		this.telefono = telefono;
		this.fecha_nac = fecha_nac;
		this.lugar_nac = lugar_nac;
		this.dni_tutor = dni_tutor;
		this.dni_madre = dni_madre;
		this.cant_her_may = cant_her_may;
		this.cant_her_men = cant_her_men;
		this.iglesia = iglesia;
		this.esc = esc;
		this.ind_grupo = ind_grupo;
		this.ind_subsidio = ind_subsidio;
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

	public String getFecha_nac() {
		return fecha_nac;
	}

	public void setFecha_nac(String fecha_nac) {
		this.fecha_nac = fecha_nac;
	}

	public String getLugar_nac() {
		return lugar_nac;
	}

	public void setLugar_nac(String lugar_nac) {
		this.lugar_nac = lugar_nac;
	}

	public int getDni_tutor() {
		return dni_tutor;
	}

	public void setDni_tutor(int dni_tutor) {
		this.dni_tutor = dni_tutor;
	}

	public int getDni_madre() {
		return dni_madre;
	}

	public void setDni_madre(int dni_madre) {
		this.dni_madre = dni_madre;
	}

	public int getCant_her_may() {
		return cant_her_may;
	}

	public void setCant_her_may(int cant_her_may) {
		this.cant_her_may = cant_her_may;
	}

	public int getCant_her_men() {
		return cant_her_men;
	}

	public void setCant_her_men(int cant_her_men) {
		this.cant_her_men = cant_her_men;
	}

	public String getIglesia() {
		return iglesia;
	}

	public void setIglesia(String iglesia) {
		this.iglesia = iglesia;
	}

	public String getEsc() {
		return esc;
	}

	public void setEsc(String esc) {
		this.esc = esc;
	}

	public boolean isInd_grupo() {
		return ind_grupo;
	}

	public void setInd_grupo(boolean ind_grupo) {
		this.ind_grupo = ind_grupo;
	}

	public boolean isInd_subsidio() {
		return ind_subsidio;
	}

	public void setInd_subsidio(boolean ind_subsidio) {
		this.ind_subsidio = ind_subsidio;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Alumno other = (Alumno) obj;
		if (apellido == null) {
			if (other.apellido != null)
				return false;
		} else if (!apellido.equals(other.apellido))
			return false;
		if (cant_her_may != other.cant_her_may)
			return false;
		if (cant_her_men != other.cant_her_men)
			return false;
		if (dni != other.dni)
			return false;
		if (dni_madre != other.dni_madre)
			return false;
		if (dni_tutor != other.dni_tutor)
			return false;
		if (domicilio == null) {
			if (other.domicilio != null)
				return false;
		} else if (!domicilio.equals(other.domicilio))
			return false;
		if (esc == null) {
			if (other.esc != null)
				return false;
		} else if (!esc.equals(other.esc))
			return false;
		if (fecha_nac == null) {
			if (other.fecha_nac != null)
				return false;
		} else if (!fecha_nac.equals(other.fecha_nac))
			return false;
		if (iglesia == null) {
			if (other.iglesia != null)
				return false;
		} else if (!iglesia.equals(other.iglesia))
			return false;
		if (ind_grupo != other.ind_grupo)
			return false;
		if (ind_subsidio != other.ind_subsidio)
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
		if (telefono == null) {
			if (other.telefono != null)
				return false;
		} else if (!telefono.equals(other.telefono))
			return false;
		return true;
	}

	public String toString() {
		return "Alumno [dni=" + dni + ", nombre=" + nombre + ", apellido="
				+ apellido + ", domicilio=" + domicilio + ", telefono="
				+ telefono + ", fecha_nac=" + fecha_nac + ", lugar_nac="
				+ lugar_nac + ", dni_tutor=" + dni_tutor + ", dni_madre="
				+ dni_madre + ", cant_her_may=" + cant_her_may
				+ ", cant_her_men=" + cant_her_men + ", iglesia=" + iglesia
				+ ", esc=" + esc + ", ind_grupo=" + ind_grupo
				+ ", ind_subsidio=" + ind_subsidio + "]";
	}

}	