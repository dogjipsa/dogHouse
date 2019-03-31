package booking.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import static common.JDBCTemplate.*;

import booking.model.vo.Booking;
import booking.model.vo.BookingCheck;
import booking.model.vo.BookingForHost;

public class BookingDao {

	public ArrayList<BookingCheck> selectBkList(Connection conn, String userid, int start, int end) {
		ArrayList<BookingCheck> list = new ArrayList<>();
		BookingCheck bc = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "SELECT X.RNUM, X.BOOKING_NO, X.CHECKIN_DATE, X.CHECKOUT_DATE, X.BOOKING_PROGRESS, X.PUSER_ID, X.PRICE, X.ADDRESS, X.PET_NAME, X.SERVICE_KIND FROM (SELECT  ROWNUM AS RNUM, S.BOOKING_NO, S.CHECKIN_DATE, S.CHECKOUT_DATE, S.BOOKING_PROGRESS, S.PUSER_ID, S.PRICE, S.ADDRESS, S.PET_NAME, S.SERVICE_KIND FROM (SELECT B.BOOKING_NO, B.CHECKIN_DATE, B.CHECKOUT_DATE, B.BOOKING_PROGRESS, B.PUSER_ID, M.PRICE, M.ADDRESS, P.PET_NAME, B.SERVICE_KIND FROM BOOKING B JOIN MEMBER M ON (B.PUSER_ID = M.USER_ID) JOIN PET P ON (B.PET_NO = P.PET_NO) WHERE B.USER_ID = ? ORDER BY 1 DESC) S WHERE ROWNUM <= ?) X WHERE X.RNUM >= ?";
		
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userid);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				bc = new BookingCheck();
				bc.setBookingNo(rset.getInt(2));
				bc.setCheckInDate(rset.getDate(3));
				bc.setCheckOutDate(rset.getDate(4));
				bc.setBookingProgress(rset.getString(5));
				bc.setPuserId(rset.getString(6));
				bc.setPrice(rset.getInt(7));
				bc.setAddress(rset.getString(8));
				bc.setPetName(rset.getString(9));
				bc.setServiceKind(rset.getString(10));
				
				list.add(bc);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public ArrayList<BookingForHost> selectBkForHostList(Connection conn, String userid, int start, int end) {
		ArrayList<BookingForHost> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		BookingForHost b = null;
		
		String query = "SELECT X.RNUM, X.BOOKING_NO, X.SERVICE_KIND, X.PET_NO, X.USER_NAME, X.ADDRESS, X.CHECKIN_DATE, X.CHECKOUT_DATE, X.BOOKING_PROGRESS, X.PRICE, X.BOOKING_ETC FROM (SELECT ROWNUM AS RNUM, S.BOOKING_NO, S.SERVICE_KIND, S.PET_NO, S.USER_NAME, S.ADDRESS, S.CHECKIN_DATE, S.CHECKOUT_DATE, S.BOOKING_PROGRESS, S.PRICE, S.BOOKING_ETC FROM (SELECT B.BOOKING_NO, B.SERVICE_KIND, P.PET_NO, M.USER_NAME,M.ADDRESS, B.CHECKIN_DATE, B.CHECKOUT_DATE,B.BOOKING_PROGRESS, H.PRICE, B.BOOKING_ETC FROM BOOKING B JOIN MEMBER M ON (B.USER_ID = M.USER_ID) JOIN PET P ON (M.USER_ID = P.USER_ID) JOIN MEMBER H ON (B.PUSER_ID = H.USER_ID) WHERE PUSER_ID = ? ORDER BY 1 DESC) S WHERE ROWNUM <= ?) X WHERE X.RNUM >= ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userid);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				b = new BookingForHost();
				b.setBookingNo(rset.getInt(2));
				b.setServiceKind(rset.getString(3));
				b.setPetNo(rset.getInt(4));
				b.setUserName(rset.getString(5));
				b.setAddress(rset.getString(6));
				b.setCheckInDate(rset.getDate(7));
				b.setCheckOutDate(rset.getDate(8));
				b.setProgress(rset.getString(9));
				b.setPrice(rset.getInt(10));
				b.setEtc(rset.getString(11));
				
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int getTotalListCount(Connection conn, String userid) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int count = 0;
		String query = "SELECT COUNT(*) FROM BOOKING WHERE USER_ID = ?";
		
		try {
			
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userid);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				count = rset.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return count;
	}

	public int getTotalHostServiceListCount(Connection conn, String userid) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int count = 0;
		String query = "SELECT COUNT(*) FROM BOOKING WHERE PUSER_ID = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userid);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				count = rset.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return count;
	}

	public int insertBooking(Connection conn, String checkin, String checkout, String petSitterId, String userId,
			String etc, String service) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "insert into booking values(seq_bookingno.nextval, to_date(?, 'YYYY/MM/DD HH24:MI'), to_date(?, 'YYYY/MM/DD HH24:MI'), (select pet_no from pet where user_id = ?), ?,0,?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, checkin);
			pstmt.setString(2, checkout);
			pstmt.setString(3, userId);
			pstmt.setString(4, userId);
			pstmt.setString(5, etc);
			pstmt.setString(6, service);//serviceKind 입력 받아야 함.
			pstmt.setString(7, petSitterId);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int selectBooking(Connection conn, String checkin, String checkout, String petSitterId, String userId) {
		int bookingNo = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select booking_no from booking where checkin_date = to_date(?, 'YYYY/MM/DD HH24:MI') and checkout_date = to_date(?, 'YYYY/MM/DD HH24:MI') and puser_id = ? and user_id = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, checkin);
			pstmt.setString(2, checkout);
			pstmt.setString(3, petSitterId);
			pstmt.setString(4, userId);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				bookingNo = rset.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return bookingNo;
	}

	public int updateBookingProgressOne(Connection conn, int bookingNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "update booking set booking_progress = '1' where booking_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bookingNo);
		
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public Booking selectBooking(Connection conn, int bookingNo) {
		Booking booking = new Booking();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from booking where booking_no = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bookingNo);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				booking.setBookingNo(rset.getInt("booking_no"));
				booking.setCheckInDate(rset.getDate("checkin_date"));
				booking.setCheckOutDate(rset.getDate("checkout_date"));
				booking.setPetNo(rset.getInt("pet_no"));
				booking.setUserId(rset.getString("user_id"));
				booking.setBookingProgress(rset.getString("booking_progress"));
				booking.setBookingEtc(rset.getString("booking_etc"));
				booking.setServiceKind(rset.getString("service_kind"));
				booking.setPuserId(rset.getString("puser_id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return booking;
	}
	
	public int selectDates(Connection conn, String checkin, String checkout) {
		int dates = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select trunc(to_date(?, 'YYYY/MM/DD HH24:MI') - to_date(?, 'YYYY/MM/DD HH24:MI')) from dual";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, checkout);
			pstmt.setString(2, checkin);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				dates = rset.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return dates;
	}
	
}
