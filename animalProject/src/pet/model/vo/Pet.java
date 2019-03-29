package pet.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Pet implements Serializable {
	private static final long serialVersionUID = 1313275459825387673L;
	
	private int petNo;
	private String petName;
	private String breeds;
	private Date petDate;
	private String petSize;
	private String petGender;
	private String petNeutralize;
	private String petCharater;
	private String userId;
	private String originFileName;
	private String renameFileName;
	
	public Pet() {
	}
	
	public Pet(int petNo, String petName, String breeds, Date petDate, String petSize, String petGender,
			String petNeutralize, String petCharater, String userId, String originFileName, String renameFileName) {
		super();
		this.petNo = petNo;
		this.petName = petName;
		this.breeds = breeds;
		this.petDate = petDate;
		this.petSize = petSize;
		this.petGender = petGender;
		this.petNeutralize = petNeutralize;
		this.petCharater = petCharater;
		this.userId = userId;
		this.originFileName = originFileName;
		this.renameFileName = renameFileName;
	}

	public int getPetNo() {
		return petNo;
	}

	public void setPetNo(int petNo) {
		this.petNo = petNo;
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

	public String getPetSize() {
		return petSize;
	}

	public void setPetSize(String petSize) {
		this.petSize = petSize;
	}

	public String getPetGender() {
		return petGender;
	}

	public void setPetGender(String petGender) {
		this.petGender = petGender;
	}

	public String getPetNeutralize() {
		return petNeutralize;
	}

	public void setPetNeutralize(String petNeutralize) {
		this.petNeutralize = petNeutralize;
	}

	public String getPetCharater() {
		return petCharater;
	}

	public void setPetCharater(String petCharater) {
		this.petCharater = petCharater;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getOriginFileName() {
		return originFileName;
	}

	public void setOriginFileName(String originFileName) {
		this.originFileName = originFileName;
	}

	public String getRenameFileName() {
		return renameFileName;
	}

	public void setRenameFileName(String renameFileName) {
		this.renameFileName = renameFileName;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return petNo + ", " + petName + ", " + breeds + ", " + petDate + ", " + petSize + ", " + petGender + ", "
				+ petNeutralize + ", " + petCharater + ", " + userId + ", " + originFileName + ", " + renameFileName;
	}
	
}