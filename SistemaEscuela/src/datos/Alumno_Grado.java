package datos;

import datos.Alumno_Grado;

public class Alumno_Grado {
	private String grado;
	private String turno;
	private int dni;
	private int a�o;

	
	public Alumno_Grado(){
		
	}

	public Alumno_Grado(String grado, String turno, int dni, int a�o) {
		super();
		this.grado = grado;
		this.turno = turno;
		this.dni = dni;
		this.a�o = a�o;
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

	public int getA�o() {
		return a�o;
	}

	public void setA�o(int a�o) {
		this.a�o = a�o;
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Alumno_Grado other = (Alumno_Grado) obj;
		if (a�o != other.a�o)
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
				+ dni + ", a�o=" + a�o + "]";
	}

	
}
