package datos;

import java.util.ArrayList;

public class MateriasGrado {

	ArrayList <String> lista;
	
	public MateriasGrado() {
		lista = new ArrayList<String>();
	}
	
	public ArrayList<String> getLista() {
		return lista;
	}
		
	public void agregarMateria(String m) {
		lista.add(m);
	}
	
	public void listar() {
		for (String m : lista) {
			System.out.println(m);
		}
	}
}
