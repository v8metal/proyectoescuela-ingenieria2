package datos;

import datos.Maestro_Grado;

public class Maestro_Grado {
	private String grado;
	private String turno;
	private int año;
	private int cod_maestro_tit;
	private int cod_maestro_par;
	
	public Maestro_Grado(){
		
	}

	public Maestro_Grado(String grado, String turno, int año,
			int cod_maestro_tit, int cod_maestro_par) {
		super();
		this.grado = grado;
		this.turno = turno;
		this.año = año;
		this.cod_maestro_tit = cod_maestro_tit;
		this.cod_maestro_par = cod_maestro_par;
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

	public int getAño() {
		return año;
	}

	public void setAño(int año) {
		this.año = año;
	}

	public int getCod_maestro_tit() {
		return cod_maestro_tit;
	}

	public void setCod_maestro_tit(int cod_maestro_tit) {
		this.cod_maestro_tit = cod_maestro_tit;
	}

	public int getCod_maestro_par() {
		return cod_maestro_par;
	}

	public void setCod_maestro_par(int cod_maestro_par) {
		this.cod_maestro_par = cod_maestro_par;
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Maestro_Grado other = (Maestro_Grado) obj;
		if (año != other.año)
			return false;
		if (cod_maestro_par != other.cod_maestro_par)
			return false;
		if (cod_maestro_tit != other.cod_maestro_tit)
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
		return "Maestro_Grado [grado=" + grado + ", turno=" + turno + ", año="
				+ año + ", cod_maestro_tit=" + cod_maestro_tit
				+ ", cod_maestro_par=" + cod_maestro_par + "]";
	}
	
}
