package booking.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import static common.JDBCTemplate.*;

import booking.model.dao.BookingDao;
import booking.model.vo.BookingCheck;
import booking.model.vo.BookingForHost;


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

	public int insertBooking(String checkin, String checkout, String petSitterId, String userId, String etc, String service) {
		Connection conn = getConnection();
		int result = bdao.insertBooking(conn, checkin, checkout, petSitterId, userId, etc, service);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

}
