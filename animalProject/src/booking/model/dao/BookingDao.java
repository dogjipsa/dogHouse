package booking.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import static common.JDBCTemplate.*;


import booking.model.vo.BookingCheck;
import booking.model.vo.BookingForHost;

public class BookingDao {

	public ArrayList<BookingCheck> selectBkList(Connection conn, String userid) {
		ArrayList<BookingCheck> list = new ArrayList<>();
		BookingCheck bc = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "SELECT B.BOOKING_NO, B.CHECKIN_DATE, B.CHECKOUT_DATE, B.BOOKING_PROGRESS, B.PUSER_ID, M.PRICE, M.ADDRESS, P.PET_NAME, B.SERVICE_KIND FROM BOOKING B JOIN MEMBER M ON (B.PUSER_ID = M.USER_ID) JOIN PET P ON (B.PET_NO = P.PET_NO) WHERE B.USER_ID = ?";
		
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userid);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				bc = new BookingCheck();
				bc.setBookingNo(rset.getInt(1));
				bc.setCheckInDate(rset.getDate(2));
				bc.setCheckOutDate(rset.getDate(3));
				bc.setBookingProgress(rset.getString(4));
				bc.setPuserId(rset.getString(5));
				bc.setPrice(rset.getInt(6));
				bc.setAddress(rset.getString(7));
				bc.setPetName(rset.getString(8));
				bc.setServiceKind(rset.getString(9));
				
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

	public ArrayList<BookingForHost> selectBkForHostList(Connection conn, String userid) {
		ArrayList<BookingForHost> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "";
		return list;
	}
	
}
