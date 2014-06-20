package datos;

import java.util.*;

public class EstadoAlumnos {
	
	ArrayList<EstadoAlumno> lista;
	
	public EstadoAlumnos() {
		lista = new ArrayList<EstadoAlumno>();
	}
	
	public ArrayList<EstadoAlumno> getLista() {
		return lista;
	}
	
	public void agregarEstadoAlumno(EstadoAlumno a) {
		lista.add(a);
	}
	
	public void listar() {
		for (EstadoAlumno a : lista) {
			System.out.println(a);
		}
	}
	
}