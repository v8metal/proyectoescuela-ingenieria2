package datos;

import java.util.ArrayList;

public class Precios {
private ArrayList<Precio>precios;
	
	public Precios(){
		precios = new ArrayList<Precio>();
	}
	
	public ArrayList<Precio>getPrecios(){
		return precios;
	}
	
	public void agregarPrecio(Precio p){
		precios.add(p);
	}
}
