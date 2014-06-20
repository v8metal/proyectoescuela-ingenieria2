package datos;

import java.util.ArrayList;

public class Entrevistas {

	ArrayList<Entrevista> lista;
	
	public Entrevistas() {
		lista = new ArrayList<Entrevista>();
	}
	
	public ArrayList<Entrevista> getLista() {
		return lista;
	}
	
	public void agregarEntrevista(Entrevista e) {
		lista.add(e);
	}
	
	public void listar() {
		for (Entrevista a : lista) {
			System.out.println(a);
		}
	}
	
	public void listar2() {
		for (Entrevista a : lista) {
			System.out.println(a.toString());
		}
	}

}
