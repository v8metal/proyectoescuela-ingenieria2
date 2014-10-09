package datos;

public class Materia {
	
	private String materia;
	private int estado;
	
	public Materia() {
		
	}

	public Materia(String materia, int estado) {		
		this.materia = materia;
		this.estado = estado;
	}

	public String getMateria() {
		return materia;
	}
	
	public int getEstado() {
		return estado;
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
		if (materia != other.materia)
			return false; else return true; 
	}

	@Override
	public String toString() {
		return "Materias [ nombre=" + materia
				+ "]";
	}

}
