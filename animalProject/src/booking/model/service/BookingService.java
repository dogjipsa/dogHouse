package booking.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import static common.JDBCTemplate.*;

import booking.model.dao.BookingDao;
import booking.model.vo.Booking;
import booking.model.vo.BookingCheck;
import booking.model.vo.BookingCheckDate;
import booking.model.vo.BookingForHost;
import pet.model.vo.Pet;


public class BookingService {
	
	private BookingDao bdao = new BookingDao(); 
	
	public ArrayList<BookingCheck> selectBkList(String userid, int start, int end) {
		Connection conn = getConnection();
		ArrayList<BookingCheck> list = bdao.selectBkList(conn, userid, start, end);
		close(conn);
		return list;
	}

	public ArrayList<BookingForHost> selectBkForHostList(String userid, int start, int end) {
		Connection conn = getConnection();
		ArrayList<BookingForHost> list = bdao.selectBkForHostList(conn, userid, start, end);
		close(conn);
		return list;
	}

	public int getTotalListCount(String userid) {
		Connection conn = getConnection();
		int count = bdao.getTotalListCount(conn, userid);
		close(conn);
		return count;
	}

	public int getTotalHostServiceListCount(String userid) {
		Connection conn = getConnection();
		int count = bdao.getTotalHostServiceListCount(conn, userid);
		close(conn);
		return count;
	}

	public int insertBooking(String checkin, String checkout,Pet pet,Booking booking) {
		Connection conn = getConnection();
		int result = bdao.insertBooking(conn, checkin, checkout, pet, booking);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public int selectBookingNo(String checkin, String checkout, String petSitterId, String userId) {
		Connection conn = getConnection();
		int bookingNo = bdao.selectBooking(conn, checkin, checkout, petSitterId, userId);
		close(conn);
		return bookingNo;
	}

	

	public Booking selectBooking(int bookingNo) {
		Connection conn = getConnection();
		Booking booking = bdao.selectBooking(conn, bookingNo);
		close(conn);
		return booking;
	}
	
	public int selectDates(String checkin, String checkout) {
		Connection conn = getConnection();
		int dates = bdao.selectDates(conn, checkin, checkout);
		close(conn);
		return dates;
	}

	public int updateBookingStatus(int bno) {
		Connection conn = getConnection();
		int result = bdao.updateBookingStatus(conn, bno);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public ArrayList<Booking> bookingAlert(String puserid) {
		Connection conn = getConnection();
		ArrayList<Booking> list = bdao.bookingAlert(conn, puserid);
		System.out.println("service 단에서 " + list + ", " + puserid);
		close(conn);
		return list;
	}

	public int bookingCount(String puserid) {
		Connection conn = getConnection();
		int count = bdao.bookingCount(conn, puserid);
		if(count > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return count;
	}

	public int updateBookingStatusFour(int bookingNo) {
		Connection conn = getConnection();
		int result = bdao.updateBookingStatusFour(conn, bookingNo);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public ArrayList<BookingCheckDate> selectCheckDate(String petSitterId) {
		Connection conn = getConnection();
		ArrayList<BookingCheckDate> checkDate = bdao.selectCheckDate(conn, petSitterId); 
		close(conn);
		return checkDate;
	}

	public int selectCheckDateCount(String petSitterId) {
		Connection conn = getConnection();
		int count = bdao.selectCheckDateCount(conn, petSitterId); 
		close(conn);
		return count;
	}

	public int selectEachCount(int bookingNo, String checkIn, String checkOut, String petSitterId) {
		Connection conn = getConnection();
		int count = bdao.selectEachCount(conn, bookingNo,checkIn,checkOut,petSitterId); 
		close(conn);
		return count;
	}
}
