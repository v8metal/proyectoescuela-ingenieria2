package datos;

import java.util.ArrayList;

public class Citaciones {
	
ArrayList<Citacion> lista;
	
	public Citaciones() {
		lista = new ArrayList<Citacion>();
	}
	
	public ArrayList<Citacion> getLista() {
		return lista;
	}
	
	public void agregarCitacion(Citacion c) {
		lista.add(c);
	}
	
	public void listar() {
		for (Citacion a : lista) {
			System.out.println(a);
		}
	}
	
	public void listar2() {
		for (Citacion a : lista) {
			System.out.println(a.toString());
		}
	}
}
