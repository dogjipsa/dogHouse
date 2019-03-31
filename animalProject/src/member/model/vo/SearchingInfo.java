package member.model.vo;

import java.sql.Date;

public class SearchingInfo implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5029360413115380982L;
	private int bookingNo;
	private String serviceKind;
	private String userId;
	private String puserId;
	private Date checkInDate;
	private Date checkOutDate;
	private int petNo;
	private Date petDate;
	private String petSize;
	private String petBreads;
	private String userAddress;
	private String puserAddress;
	private int price;
	private int age;
	private String puserName;
	private String puserPetName;
	private String puserPetBreads;
	private String puserOriginFile;
	private String puserReFile;
	private String puserHouseImage;
	private String puserHouseReImage;
	
	
	public SearchingInfo(){}


	public SearchingInfo(int bookingNo, String serviceKind, String userId, String puserId, Date checkInDate,
			Date checkOutDate, int petNo, Date petDate, String petSize, String petBreads, String userAddress,
			String puserAddress, int price, int age, String puserName, String puserPetName, String puserPetBreads,
			String puserOriginFile, String puserReFile, String puserHouseImage, String puserHouseReImage) {
		super();
		this.bookingNo = bookingNo;
		this.serviceKind = serviceKind;
		this.userId = userId;
		this.puserId = puserId;
		this.checkInDate = checkInDate;
		this.checkOutDate = checkOutDate;
		this.petNo = petNo;
		this.petDate = petDate;
		this.petSize = petSize;
		this.petBreads = petBreads;
		this.userAddress = userAddress;
		this.puserAddress = puserAddress;
		this.price = price;
		this.age = age;
		this.puserName = puserName;
		this.puserPetName = puserPetName;
		this.puserPetBreads = puserPetBreads;
		this.puserOriginFile = puserOriginFile;
		this.puserReFile = puserReFile;
		this.puserHouseImage = puserHouseImage;
		this.puserHouseReImage = puserHouseReImage;
	}


	public int getBookingNo() {
		return bookingNo;
	}


	public void setBookingNo(int bookingNo) {
		this.bookingNo = bookingNo;
	}


	public String getServiceKind() {
		return serviceKind;
	}


	public void setServiceKind(String serviceKind) {
		this.serviceKind = serviceKind;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getPuserId() {
		return puserId;
	}


	public void setPuserId(String puserId) {
		this.puserId = puserId;
	}


	public Date getCheckInDate() {
		return checkInDate;
	}


	public void setCheckInDate(Date checkInDate) {
		this.checkInDate = checkInDate;
	}


	public Date getCheckOutDate() {
		return checkOutDate;
	}


	public void setCheckOutDate(Date checkOutDate) {
		this.checkOutDate = checkOutDate;
	}


	public int getPetNo() {
		return petNo;
	}


	public void setPetNo(int petNo) {
		this.petNo = petNo;
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


	public String getUserAddress() {
		return userAddress;
	}


	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}


	public String getPuserAddress() {
		return puserAddress;
	}


	public void setPuserAddress(String puserAddress) {
		this.puserAddress = puserAddress;
	}


	public int getPrice() {
		return price;
	}


	public void setPrice(int price) {
		this.price = price;
	}


	public int getAge() {
		return age;
	}


	public void setAge(int age) {
		this.age = age;
	}


	public String getPuserName() {
		return puserName;
	}


	public void setPuserName(String puserName) {
		this.puserName = puserName;
	}


	public String getPuserPetName() {
		return puserPetName;
	}


	public void setPuserPetName(String puserPetName) {
		this.puserPetName = puserPetName;
	}


	public String getPuserPetBreads() {
		return puserPetBreads;
	}


	public void setPuserPetBreads(String puserPetBreads) {
		this.puserPetBreads = puserPetBreads;
	}


	public String getPuserOriginFile() {
		return puserOriginFile;
	}


	public void setPuserOriginFile(String puserOriginFile) {
		this.puserOriginFile = puserOriginFile;
	}


	public String getPuserReFile() {
		return puserReFile;
	}


	public void setPuserReFile(String puserReFile) {
		this.puserReFile = puserReFile;
	}


	public String getPuserHouseImage() {
		return puserHouseImage;
	}


	public void setPuserHouseImage(String puserHouseImage) {
		this.puserHouseImage = puserHouseImage;
	}


	public String getPuserHouseReImage() {
		return puserHouseReImage;
	}


	public void setPuserHouseReImage(String puserHouseReImage) {
		this.puserHouseReImage = puserHouseReImage;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	@Override
	public String toString() {
		return "SearchingInfo [bookingNo=" + bookingNo + ", serviceKind=" + serviceKind + ", userId=" + userId
				+ ", puserId=" + puserId + ", checkInDate=" + checkInDate + ", checkOutDate=" + checkOutDate
				+ ", petNo=" + petNo + ", petDate=" + petDate + ", petSize=" + petSize + ", petBreads=" + petBreads
				+ ", userAddress=" + userAddress + ", puserAddress=" + puserAddress + ", price=" + price + ", age="
				+ age + ", puserName=" + puserName + ", puserPetName=" + puserPetName + ", puserPetBreads="
				+ puserPetBreads + ", puserOriginFile=" + puserOriginFile + ", puserReFile=" + puserReFile
				+ ", puserHouseImage=" + puserHouseImage + ", puserHouseReImage=" + puserHouseReImage + "]";
	}

	

}


