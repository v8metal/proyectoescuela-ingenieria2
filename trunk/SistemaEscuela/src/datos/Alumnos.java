package datos;

import java.util.*;

public class Alumnos {
	
	ArrayList<Alumno> lista;
	
	public Alumnos() {
		lista = new ArrayList<Alumno>();
	}
	
	public ArrayList<Alumno> getLista() {
		return lista;
	}
	
	public void agregarAlumno(Alumno a) {
		lista.add(a);
	}
	
	public void listar() {
		for (Alumno a : lista) {
			System.out.println(a);
		}
	}
	
}
