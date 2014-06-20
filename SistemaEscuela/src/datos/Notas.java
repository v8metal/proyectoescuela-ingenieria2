package datos;

import java.util.*;

public class Notas {

	ArrayList<Nota> lista;
	
	public Notas() {
		lista = new ArrayList<Nota>();
	}
	
	public ArrayList<Nota> getLista() {
		return lista;
	}
	
	public void agregarNota(Nota a) {
		lista.add(a);
	}
	
	public void listar() {
		for (Nota a : lista) {
			System.out.println(a);
		}
	}
	
}
