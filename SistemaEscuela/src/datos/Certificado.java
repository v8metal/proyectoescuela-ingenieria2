package datos;

public class Certificado {
	
	private int dni;
	private int año;
	private boolean ind_salud;
	private boolean ind_bucal;
	private boolean ind_dni;
	private boolean ind_auditivo;
	private boolean ind_visual;
	private boolean ind_vacunas;
	
	public Certificado() {
		
	}

	public Certificado(int dni, int año, boolean ind_salud, boolean ind_bucal,
			boolean ind_dni, boolean ind_auditivo, boolean ind_visual,
			boolean ind_vacunas) {
		super();
		this.dni = dni;
		this.año = año;
		this.ind_salud = ind_salud;
		this.ind_bucal = ind_bucal;
		this.ind_dni = ind_dni;
		this.ind_auditivo = ind_auditivo;
		this.ind_visual = ind_visual;
		this.ind_vacunas = ind_vacunas;
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

	public boolean isInd_salud() {
		return ind_salud;
	}

	public void setInd_salud(boolean ind_salud) {
		this.ind_salud = ind_salud;
	}

	public boolean isInd_bucal() {
		return ind_bucal;
	}

	public void setInd_bucal(boolean ind_bucal) {
		this.ind_bucal = ind_bucal;
	}

	public boolean isInd_dni() {
		return ind_dni;
	}

	public void setInd_dni(boolean ind_dni) {
		this.ind_dni = ind_dni;
	}

	public boolean isInd_auditivo() {
		return ind_auditivo;
	}

	public void setInd_auditivo(boolean ind_auditivo) {
		this.ind_auditivo = ind_auditivo;
	}

	public boolean isInd_visual() {
		return ind_visual;
	}

	public void setInd_visual(boolean ind_visual) {
		this.ind_visual = ind_visual;
	}

	public boolean isInd_vacunas() {
		return ind_vacunas;
	}

	public void setInd_vacunas(boolean ind_vacunas) {
		this.ind_vacunas = ind_vacunas;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Certificado other = (Certificado) obj;
		if (año != other.año)
			return false;
		if (dni != other.dni)
			return false;
		if (ind_auditivo != other.ind_auditivo)
			return false;
		if (ind_bucal != other.ind_bucal)
			return false;
		if (ind_dni != other.ind_dni)
			return false;
		if (ind_salud != other.ind_salud)
			return false;
		if (ind_vacunas != other.ind_vacunas)
			return false;
		if (ind_visual != other.ind_visual)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Certificado [dni=" + dni + ", año=" + año + ", ind_salud="
				+ ind_salud + ", ind_bucal=" + ind_bucal + ", ind_dni="
				+ ind_dni + ", ind_auditivo=" + ind_auditivo + ", ind_visual="
				+ ind_visual + ", ind_vacunas=" + ind_vacunas + "]";
	}

}
