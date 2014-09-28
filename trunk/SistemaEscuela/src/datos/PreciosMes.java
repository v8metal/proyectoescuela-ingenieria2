package datos;

import java.util.ArrayList;

public class PreciosMes {
private ArrayList<PrecioMes>precios;
	
	public PreciosMes(){
		precios = new ArrayList<PrecioMes>();
	}
	
	public ArrayList<PrecioMes>getPrecios(){
		return precios;
	}
	
	public void agregarPrecio(PrecioMes p){
		precios.add(p);
	}
}
