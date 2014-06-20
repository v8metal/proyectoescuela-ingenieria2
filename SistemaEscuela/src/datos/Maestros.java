package datos;

import java.util.*;

public class Maestros {

	ArrayList<Maestro> lista;
	
	public Maestros() {
		lista = new ArrayList<Maestro>();
	}
	
	public ArrayList<Maestro> getLista() {
		return lista;
	}
	
	public void agregarMaestro(Maestro a) {
		lista.add(a);
	}
	
	public void listar() {
		for (Maestro a : lista) {
			System.out.println(a);
		}
	}
	
}
