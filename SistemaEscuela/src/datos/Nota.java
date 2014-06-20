package datos;

public class Nota {
	
	private String grado;
	private String turno;
	private int a�o;
	private int dni;
	private int cod_materia;
	private String periodo;
	private int calific;
	
	public Nota() {
		
	}

	public Nota(String grado, String turno, int a�o, int dni, int cod_materia,
			String periodo, int calific) {
		super();
		this.grado = grado;
		this.turno = turno;
		this.a�o = a�o;
		this.dni = dni;
		this.cod_materia = cod_materia;
		this.periodo = periodo;
		this.calific = calific;
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

	public int getA�o() {
		return a�o;
	}

	public void setA�o(int a�o) {
		this.a�o = a�o;
	}

	public int getDni() {
		return dni;
	}

	public void setDni(int dni) {
		this.dni = dni;
	}

	public int getCod_materia() {
		return cod_materia;
	}

	public void setCod_materia(int cod_materia) {
		this.cod_materia = cod_materia;
	}

	public String getPeriodo() {
		return periodo;
	}

	public void setPeriodo(String periodo) {
		this.periodo = periodo;
	}

	public int getCalific() {
		return calific;
	}

	public void setCalific(int calific) {
		this.calific = calific;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Nota other = (Nota) obj;
		if (a�o != other.a�o)
			return false;
		if (calific != other.calific)
			return false;
		if (cod_materia != other.cod_materia)
			return false;
		if (dni != other.dni)
			return false;
		if (grado == null) {
			if (other.grado != null)
				return false;
		} else if (!grado.equals(other.grado))
			return false;
		if (periodo == null) {
			if (other.periodo != null)
				return false;
		} else if (!periodo.equals(other.periodo))
			return false;
		if (turno == null) {
			if (other.turno != null)
				return false;
		} else if (!turno.equals(other.turno))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Nota [grado=" + grado + ", turno=" + turno + ", a�o=" + a�o
				+ ", dni=" + dni + ", cod_materia=" + cod_materia
				+ ", periodo=" + periodo + ", calific=" + calific + "]";
	}
	
}
