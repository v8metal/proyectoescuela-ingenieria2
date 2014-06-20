package datos;

import java.util.*;

public class Observaciones {
	
	ArrayList<Observacion> lista;
	
	public Observaciones() {
		lista = new ArrayList<Observacion>();
	}
	
	public ArrayList<Observacion> getLista() {
		return lista;
	}
	
	public void agregarObservacion(Observacion a) {
		lista.add(a);
	}
	
	public void listar() {
		for (Observacion a : lista) {
			System.out.println(a);
		}
	}
	
}
