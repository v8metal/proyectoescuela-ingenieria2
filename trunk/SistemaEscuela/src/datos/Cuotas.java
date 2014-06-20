package datos;

import java.util.ArrayList;

import datos.Cuota;

public class Cuotas {
private ArrayList<Cuota>cuotas;
	
	public Cuotas(){
		cuotas = new ArrayList<Cuota>();
	}
	
	public ArrayList<Cuota>getCuotas(){
		return cuotas;
	}
	
	public void agregarCuota(Cuota c){
		cuotas.add(c);
	}
}
