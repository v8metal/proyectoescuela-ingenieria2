package datos;

import java.util.*;

public class Padres {

	ArrayList<Padre> lista;
	
	public Padres() {
		lista = new ArrayList<Padre>();
	}
	
	public ArrayList<Padre> getLista() {
		return lista;
	}
	
	public void agregarPadre(Padre p) {
		lista.add(p);
	}
	
	public void listar() {
		for (Padre p : lista) {
			System.out.println(p);
		}
	}
	
}