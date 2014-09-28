package datos;


public class PrecioMes {
	private int a�o;
	private int mes;
	private int regular;
	private int grupo;
	private int hijos;
	private int recargo;
	
	public PrecioMes(){
		
	}

	
	public PrecioMes(int a�o, int mes, int regular, int grupo,
		
		int hijos, int recargo) {
		super();
		this.a�o = a�o;
		this.mes = mes;
		this.regular = regular;
		this.grupo = grupo;
		this.hijos = hijos;
		this.recargo = recargo;
	}
	
	

	public int getA�o() {
		return a�o;
	}


	public void setA�o(int a�o) {
		this.a�o = a�o;
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
			return p.a�o==a�o && p.mes==mes;
		}
		return false;
	}
	
	public String toString(){
		return "[A�O: "+a�o+", MES:"+mes+", PRECIO REGULAR: "+regular+", PRECIO DE GRUPO: "+grupo+", PRECIO HIJOS: "+hijos+", RECARGO: "+recargo+"]";
	}
}