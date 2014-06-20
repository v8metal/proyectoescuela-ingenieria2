package datos;

import java.util.*;

public class Usuarios {
	
	ArrayList<Usuario> lista;
	
	public Usuarios() {
		lista = new ArrayList<Usuario>();
	}
	
	public ArrayList<Usuario> getLista() {
		return lista;
	}
	
	public void agregarUsuario(Usuario u) {
		lista.add(u);
	}
	
	public void listar() {
		for (Usuario u : lista) {
			System.out.println(u);
		}
	}
	
}