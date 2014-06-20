package datos;

import java.util.*;

public class Materias {

	ArrayList<Materia> lista;
	
	public Materias() {
		lista = new ArrayList<Materia>();
	}
	
	public ArrayList<Materia> getLista() {
		return lista;
	}
	
	public void agregarMateria(Materia a) {
		lista.add(a);
	}
	
	public void listar() {
		for (Materia a : lista) {
			System.out.println(a);
		}
	}
	
}
