package datos;

import java.util.ArrayList;

public class MateriasGrado {

	ArrayList <Materia> lista;
	
	public MateriasGrado() {
		lista = new ArrayList<Materia>();
	}
	
	public ArrayList<Materia> getLista() {
		return lista;
	}
		
	public void agregarMateria(Materia m) {
		lista.add(m);
	}
	
	public void listar() {
		for (Materia m : lista) {
			System.out.println(m.getMateria());
		}
	}
	
	public boolean contains(Materia m){
		
		boolean b = false;
		
		for (Materia m1 : lista){
			
			if (m1.getMateria().equals(m.getMateria())){
				
				b = true;
			}
			
		}
		
		return b;
	}
}
