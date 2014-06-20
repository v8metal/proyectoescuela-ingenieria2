package datos;

public class Materia {
	
	private int cod_materia;
	private String nombre;
	
	public Materia() {
		
	}

	public Materia(int cod_materia, String nombre) {
		super();
		this.cod_materia = cod_materia;
		this.nombre = nombre;
	}

	public int getCod_materia() {
		return cod_materia;
	}

	public void setCod_materia(int cod_materia) {
		this.cod_materia = cod_materia;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Materia other = (Materia) obj;
		if (cod_materia != other.cod_materia)
			return false;
		if (nombre == null) {
			if (other.nombre != null)
				return false;
		} else if (!nombre.equals(other.nombre))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Materias [cod_materia=" + cod_materia + ", nombre=" + nombre
				+ "]";
	}

}
