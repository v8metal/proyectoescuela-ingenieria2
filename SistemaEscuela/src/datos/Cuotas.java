package datos;

import java.util.*;

public class Cuotas {

	ArrayList<Cuota> lista;
	
	public Cuotas() {
		lista = new ArrayList<Cuota>();
	}
	
	public ArrayList<Cuota> getLista() {
		return lista;
	}
	
	public void agregarCuota(Cuota p) {
		lista.add(p);
	}
	
	public void listar() {
		for (Cuota p : lista) {
			System.out.println(p);
		}
	}
	
}