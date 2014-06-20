package datos;

import java.util.ArrayList;

import datos.Tardanza;

public class Tardanzas {
	private ArrayList<Tardanza>tardanzas;

	public Tardanzas(){
		tardanzas = new ArrayList<Tardanza>();
	}

	public ArrayList<Tardanza> getTardanzas(){
		return tardanzas;
	}

	public void agregarTardanza(Tardanza tardanza){
		tardanzas.add(tardanza);
	}
}
