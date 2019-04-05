package booking.model.vo;

import java.io.Serializable;

public class BookingCheckDate implements Serializable {
	private static final long serialVersionUID = -1453563657211102936L;
	
	private String checkInDate;
	private String checkOutDate;
	private int bookingNo;
	public BookingCheckDate() {}
	public BookingCheckDate(String checkInDate, String checkOutDate, int bookingNo) {
		super();
		this.checkInDate = checkInDate;
		this.checkOutDate = checkOutDate;
		this.bookingNo = bookingNo;
	}
	public String getCheckInDate() {
		return checkInDate;
	}
	public void setCheckInDate(String checkInDate) {
		this.checkInDate = checkInDate;
	}
	public String getCheckOutDate() {
		return checkOutDate;
	}
	public void setCheckOutDate(String checkOutDate) {
		this.checkOutDate = checkOutDate;
	}
	public int getBookingNo() {
		return bookingNo;
	}
	public void setBookingNo(int bookingNo) {
		this.bookingNo = bookingNo;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return checkInDate + ", " + checkOutDate + ", " + bookingNo;
	}
	
	
	
	
}
