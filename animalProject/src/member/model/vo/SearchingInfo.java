package member.model.vo;

import java.sql.Date;

public class SearchingInfo implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5029360413115380982L;
	private Date petDate;
	private String petSize;
	private String petBreads;

	
	public SearchingInfo() {}


	public SearchingInfo(Date petDate, String petSize, String petBreads) {
		super();
		this.petDate = petDate;
		this.petSize = petSize;
		this.petBreads = petBreads;
	}


	public Date getPetDate() {
		return petDate;
	}


	public void setPetDate(Date petDate) {
		this.petDate = petDate;
	}


	public String getPetSize() {
		return petSize;
	}


	public void setPetSize(String petSize) {
		this.petSize = petSize;
	}


	public String getPetBreads() {
		return petBreads;
	}


	public void setPetBreads(String petBreads) {
		this.petBreads = petBreads;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	


}


