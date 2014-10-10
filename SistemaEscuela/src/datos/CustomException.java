package datos;

public class CustomException extends Exception {

	/* 
	Esta excepción se creó para casos específicos, como querer dar de baja un maestro
	que está asignado a un grado o una materia para el año en curso
	
	También cuando se quiere desasignar un maestro que tiene notas cargas para el año
	en curso 
	
	*/
	 private static final long serialVersionUID = 1L;

}
