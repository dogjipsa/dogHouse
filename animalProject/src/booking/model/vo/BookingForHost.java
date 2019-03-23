package booking.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class BookingForHost implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4920180258796752908L;
	private int bookingNo;
	private String serviceKind;
	private String breed;
	private String size;
	private String userName;
	private Date checkInDate;
	private Date checkOutDate;
	private int price;
	private String progress;
	private String etc;
	
	public BookingForHost() {
	}
	
	public BookingForHost(int bookingNo, String serviceKind, String breed, String size, String userName,
			Date checkInDate, Date checkOutDate, int price, String progress, String etc) {
		super();
		this.bookingNo = bookingNo;
		this.serviceKind = serviceKind;
		this.breed = breed;
		this.size = size;
		this.userName = userName;
		this.checkInDate = checkInDate;
		this.checkOutDate = checkOutDate;
		this.price = price;
		this.progress = progress;
		this.etc = etc;
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

	public String getBreed() {
		return breed;
	}

	public void setBreed(String breed) {
		this.breed = breed;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
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

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getProgress() {
		return progress;
	}

	public void setProgress(String progress) {
		this.progress = progress;
	}
	
	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return bookingNo + ", " + serviceKind + ", " + breed + ", " + size + ", " + userName + ", " + checkInDate + ", "
				+ checkOutDate + ", " + price + ", " + progress + ", " + etc;
	}

	
}
