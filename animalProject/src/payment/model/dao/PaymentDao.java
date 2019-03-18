package payment.model.dao;

import static common.JDBCTemplate.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import booking.model.vo.Booking;
import payment.model.vo.Payment;

public class PaymentDao {

	public int insertPayment(Connection conn, int bookingNo, String pMethod) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query="insert into payment values(?,sysdate,?,y)";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bookingNo);
			pstmt.setString(2, pMethod);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public ArrayList<Payment> selectList(Connection conn, String userid) {
		ArrayList<Payment> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "SELECT * FROM PAYMENT WHERE BOOKING_NO IN (SELECT BOOKING_NO FROM BOOKING WHERE USER_ID = ?)";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userid);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Payment p = new Payment();
				p.setBookingNo(rset.getInt(1));
				p.setPaymentDate(rset.getDate(2));
				p.setPaymentMethod(rset.getString(3));
				p.setPaymentYn(rset.getString(4));
				
				list.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public Booking selectBooking(Connection conn, int bookingNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Booking b = null;
		String query = "SELECT * FROM BOOKING WHERE BOOKING_NO = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bookingNo);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				b = new Booking();
				b.setBookingNo(rset.getInt(1));
				b.setCheckInDate(rset.getDate(2));
				b.setCheckOutDate(rset.getDate(3));
				b.setPetNo(rset.getInt(4));
				b.setUserId(rset.getString(5));
				b.setBookingProgress(rset.getString(6));
				b.setBookingEtc(rset.getString(7));
				b.setServiceKind(rset.getString(8));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return b;
	}

}
