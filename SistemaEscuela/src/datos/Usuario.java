package datos;

public class Usuario {
	
	private String usuario;
	private String contrase�a;
	private int cod_maest;
	
	public Usuario() {
		
	}

	public Usuario(String usuario, String contrase�a, int cod_maest) {
		super();
		this.usuario = usuario;
		this.contrase�a = contrase�a;
		this.cod_maest = cod_maest;
	}

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public String getContrase�a() {
		return contrase�a;
	}

	public void setContrase�a(String contrase�a) {
		this.contrase�a = contrase�a;
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
		if (contrase�a == null) {
			if (other.contrase�a != null)
				return false;
		} else if (!contrase�a.equals(other.contrase�a))
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
		return "Usuario [usuario=" + usuario + ", contrase�a=" + contrase�a
				+ ", cod_maest=" + cod_maest + "]";
	}
	
}
