package datos;

import java.util.ArrayList;

public class Sanciones {

	ArrayList<Sancion> lista;
	
	public Sanciones() {
		lista = new ArrayList<Sancion>();
	}
	
	public ArrayList<Sancion> getLista() {
		return lista;
	}
	
	public void agregarSancion(Sancion a) {
		lista.add(a);
	}
	
	public void listar() {
		for (Sancion a : lista) {
			System.out.println(a);
		}
	}
	
	public void listar2() {
		for (Sancion a : lista) {
			System.out.println(a.toString());
		}
	}

}
