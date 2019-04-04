package manager.model.vo;

import java.io.Serializable;

public class Manager implements Serializable {
	private static final long serialVersionUID = 1278529267096630351L;
	
	private String managerId;
	private String managerName;
	private String managerPassword;
	
	public Manager() {}

	public Manager(String managerId, String managerName, String managerPassword) {
		this.managerId = managerId;
		this.managerName = managerName;
		this.managerPassword = managerPassword;
	}

	public String getManagerId() {
		return managerId;
	}

	public void setManagerId(String managerId) {
		this.managerId = managerId;
	}

	public String getManagerName() {
		return managerName;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}

	public String getManagerPassword() {
		return managerPassword;
	}

	public void setManagerPassword(String managerPassword) {
		this.managerPassword = managerPassword;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return
				this.managerId + ", " + this.managerName + ", " + this.managerPassword;
				
	}

}
