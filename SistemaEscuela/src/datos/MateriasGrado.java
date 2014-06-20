package datos;

import java.util.ArrayList;

public class MateriasGrado {

	ArrayList <Integer> lista;
	
	public MateriasGrado() {
		lista = new ArrayList<Integer>();
	}
	
	public ArrayList<Integer> getLista() {
		return lista;
	}
		
	public void agregarMateria(Integer m) {
		lista.add(m);
	}
	
	public void listar() {
		for (Integer m : lista) {
			System.out.println(m);
		}
	}
}
