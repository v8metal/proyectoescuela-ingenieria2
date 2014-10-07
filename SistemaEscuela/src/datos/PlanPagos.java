package datos;

import java.util.ArrayList;

public class PlanPagos {

ArrayList<PlanPago> lista;
	
	public PlanPagos() {
		lista = new ArrayList<PlanPago>();
	}
	
	public ArrayList<PlanPago> getLista() {
		return lista;
	}
	
	public void agregarCuota(PlanPago pp) {
		lista.add(pp);
	}
	
	public void listar() {
		for (PlanPago p : lista) {
			System.out.println(p);
		}
	}
	
}