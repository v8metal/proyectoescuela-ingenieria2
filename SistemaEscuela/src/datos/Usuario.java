package datos;

public class Usuario {
	
	private String usuario;
	private String contraseña;
	private int cod_maest;
	
	public Usuario() {
		
	}

	public Usuario(String usuario, String contraseña, int cod_maest) {
		super();
		this.usuario = usuario;
		this.contraseña = contraseña;
		this.cod_maest = cod_maest;
	}

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public String getContraseña() {
		return contraseña;
	}

	public void setContraseña(String contraseña) {
		this.contraseña = contraseña;
	}

	public int getCod_maest() {
		return cod_maest;
	}

	public void setCod_maest(int cod_maest) {
		this.cod_maest = cod_maest;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Usuario other = (Usuario) obj;
		if (cod_maest != other.cod_maest)
			return false;
		if (contraseña == null) {
			if (other.contraseña != null)
				return false;
		} else if (!contraseña.equals(other.contraseña))
			return false;
		if (usuario == null) {
			if (other.usuario != null)
				return false;
		} else if (!usuario.equals(other.usuario))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Usuario [usuario=" + usuario + ", contraseña=" + contraseña
				+ ", cod_maest=" + cod_maest + "]";
	}
	
}
