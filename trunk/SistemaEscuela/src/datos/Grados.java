package datos;

import java.util.*;

public class Grados {

	ArrayList<Grado> lista;
	ArrayList<Grado> listaTM;
	ArrayList<Grado> listaTT;
	
	public Grados() {
		lista = new ArrayList<Grado>();
		listaTM = new ArrayList<Grado>();
		listaTT = new ArrayList<Grado>();
	}
	
	public ArrayList<Grado> getLista() {
		return lista;
	}
	
	public ArrayList<Grado> getListaTM() {
		
		return listaTM;		
	}
	
	public ArrayList<Grado> getListaTT() {
		
		return listaTT;
	}	
	
	public void agregarGrado(Grado g) {
		
		lista.add(g);
		
		if (g.getTurno().equals("MAÑANA")){
			listaTM.add(g);
		}else{
			listaTT.add(g);
		}
	}
	
	public void listar() {
		for (Grado a : lista) {
			System.out.println(a);
		}
	}
	
	public void listar2() {
		for (Grado a : lista) {
			System.out.println(a.toString());
		}
	}
	
}