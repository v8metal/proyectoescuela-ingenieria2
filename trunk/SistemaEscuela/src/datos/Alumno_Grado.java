package datos;

import datos.Alumno_Grado;

public class Alumno_Grado {
	private String grado;
	private String turno;
	private int dni;
	private int año;

	
	public Alumno_Grado(){
		
	}

	public Alumno_Grado(String grado, String turno, int dni, int año) {
		super();
		this.grado = grado;
		this.turno = turno;
		this.dni = dni;
		this.año = año;
	}

	public String getGrado() {
		return grado;
	}

	public void setGrado(String grado) {
		this.grado = grado;
	}

	public String getTurno() {
		return turno;
	}

	public void setTurno(String turno) {
		this.turno = turno;
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

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Alumno_Grado other = (Alumno_Grado) obj;
		if (año != other.año)
			return false;
		if (dni != other.dni)
			return false;
		if (grado == null) {
			if (other.grado != null)
				return false;
		} else if (!grado.equals(other.grado))
			return false;
		if (turno == null) {
			if (other.turno != null)
				return false;
		} else if (!turno.equals(other.turno))
			return false;
		return true;
	}

	public String toString() {
		return "Alumno_Grado [grado=" + grado + ", turno=" + turno + ", dni="
				+ dni + ", año=" + año + "]";
	}

	
}
