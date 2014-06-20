package datos;

import java.util.ArrayList;

public class Certificados {
	
	ArrayList<Certificado> lista;
	
	public Certificados() {
		lista = new ArrayList<Certificado>();
	}
	
	public ArrayList<Certificado> getLista() {
		return lista;
	}
	
	public void agregarCertificado(Certificado c) {
		lista.add(c);
	}
	
	public void listar() {
		for (Certificado c : lista) {
			System.out.println(c);
		}
	}
	
}
