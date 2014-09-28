package datos;

import java.util.ArrayList;

public class PreciosInscrip {
private ArrayList<PrecioInscrip>precios;
	
	public PreciosInscrip(){
		precios = new ArrayList<PrecioInscrip>();
	}
	
	public ArrayList<PrecioInscrip>getPrecios(){
		return precios;
	}
	
	public void agregarPrecio(PrecioInscrip p){
		precios.add(p);
	}
}