package pet.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class SubInfo implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7608042225473809412L;
	private String petName;
	private String breeds;
	private Date petDate;
	private String phone;
	private String renameFileName;
	
	public SubInfo() {
		// TODO Auto-generated constructor stub
	}

	public String getPetName() {
		return petName;
	}

	public void setPetName(String petName) {
		this.petName = petName;
	}

	public String getBreeds() {
		return breeds;
	}

	public void setBreeds(String breeds) {
		this.breeds = breeds;
	}

	public Date getPetDate() {
		return petDate;
	}

	public void setPetDate(Date petDate) {
		this.petDate = petDate;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getRenameFileName() {
		return renameFileName;
	}

	public void setRenameFileName(String renameFileName) {
		this.renameFileName = renameFileName;
	}

	@Override
	public String toString() {
		return petName + ", " + breeds + ", " + petDate + ", " + phone + ", " + renameFileName;
	}
	
	
}
