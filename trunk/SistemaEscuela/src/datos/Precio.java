package datos;


public class Precio {
	private int a�o;
	private int mes;
	private int prec_reg;
	private int prec_grupo;
	private int reinsc_ant;
	private int reinsc;
	
	public Precio(){
		
	}

	
	public Precio(int a�o, int mes, int prec_reg, int prec_grupo,
			int reinsc_ant, int reinsc) {
		super();
		this.a�o = a�o;
		this.mes = mes;
		this.prec_reg = prec_reg;
		this.prec_grupo = prec_grupo;
		this.reinsc_ant = reinsc_ant;
		this.reinsc = reinsc;
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


	public void setMes(int mes) {
		this.mes = mes;
	}


	public int getPrec_reg() {
		return prec_reg;
	}


	public void setPrec_reg(int prec_reg) {
		this.prec_reg = prec_reg;
	}


	public int getPrec_grupo() {
		return prec_grupo;
	}


	public void setPrec_grupo(int prec_grupo) {
		this.prec_grupo = prec_grupo;
	}


	public int getReinsc_ant() {
		return reinsc_ant;
	}


	public void setReinsc_ant(int reinsc_ant) {
		this.reinsc_ant = reinsc_ant;
	}


	public int getReinsc() {
		return reinsc;
	}


	public void setReinsc(int reinsc) {
		this.reinsc = reinsc;
	}


	public boolean equals(Object o){
		if(o!=null && o instanceof Precio){
			Precio p = (Precio) o;
			return p.a�o==a�o && p.mes==mes;
		}
		return false;
	}
	
	public String toString(){
		return "[A�O: "+a�o+", MES:"+mes+", PRECIO REGULAR: "+prec_reg+", PRECIO DE GRUPO: "+prec_grupo+", REINSCRIPCI�N ANTICIPADA: "+reinsc_ant+", REINSCRIPCI�N: "+reinsc+"]";
	}
}