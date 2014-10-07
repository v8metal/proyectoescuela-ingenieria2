package datos;

import java.util.ArrayList;

public class PagosPlanPago {

ArrayList<PagoPlanPago> lista;
	
	public PagosPlanPago() {
		lista = new ArrayList<PagoPlanPago>();
	}
	
	public ArrayList<PagoPlanPago> getLista() {
		return lista;
	}
	
	public void agregarPago(PagoPlanPago ppp) {
		lista.add(ppp);
	}
	
	public void listar() {
		for (PagoPlanPago p : lista) {
			System.out.println(p);
		}
	}
	
}
