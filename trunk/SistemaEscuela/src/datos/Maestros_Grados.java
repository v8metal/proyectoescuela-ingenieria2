package datos;

import java.util.ArrayList;

import datos.Maestro_Grado;

public class Maestros_Grados {
	private ArrayList<Maestro_Grado>maestros_grados;
	
	public Maestros_Grados(){
		maestros_grados= new ArrayList<Maestro_Grado>();
	}
	
	public ArrayList<Maestro_Grado> getMaestros_Grados(){
		return maestros_grados;
	}
	
	public void agregarMaestro_Grado(Maestro_Grado maestro_grado){
		maestros_grados.add(maestro_grado);
	}
}
