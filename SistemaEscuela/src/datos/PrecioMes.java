package datos;


public class PrecioMes {
	private int año;
	private int mes;
	private int regular;
	private int grupo;
	private int hijos;
	private int recargo;
	
	public PrecioMes(){
		
	}

	
	public PrecioMes(int año, int mes, int regular, int grupo,
		
		int hijos, int recargo) {
		super();
		this.año = año;
		this.mes = mes;
		this.regular = regular;
		this.grupo = grupo;
		this.hijos = hijos;
		this.recargo = recargo;
	}
	
	

	public int getAño() {
		return año;
	}


	public void setAño(int año) {
		this.año = año;
	}


	public int getMes() {
		return mes;
	}


	


	public int getRegular() {
		return regular;
	}


	public int getGrupo() {
		return grupo;
	}

	public int getHijos() {
		return hijos;
	}


	public int getRecargo() {
		return recargo;
	}


	public boolean equals(Object o){
		if(o!=null && o instanceof PrecioMes){
			PrecioMes p = (PrecioMes) o;
			return p.año==año && p.mes==mes;
		}
		return false;
	}
	
	public String toString(){
		return "[AÑO: "+año+", MES:"+mes+", PRECIO REGULAR: "+regular+", PRECIO DE GRUPO: "+grupo+", PRECIO HIJOS: "+hijos+", RECARGO: "+recargo+"]";
	}
}