package datos;

import java.util.ArrayList;

import datos.Alumno_Grado;

public class Alumnos_Grados {
private ArrayList<Alumno_Grado>alumnos_grados;
	
	public Alumnos_Grados(){
		alumnos_grados=new ArrayList<Alumno_Grado>();
	}
	
	public ArrayList<Alumno_Grado>getAlumnos_Grados(){
		return alumnos_grados;
	}
	
	public void agregarAlumno_Grado(Alumno_Grado a){
		alumnos_grados.add(a);
	}
}
