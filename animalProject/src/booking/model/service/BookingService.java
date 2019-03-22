package booking.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import static common.JDBCTemplate.*;

import booking.model.dao.BookingDao;
import booking.model.vo.BookingCheck;

public class BookingService {
	
	private BookingDao bdao = new BookingDao(); 
	
	public ArrayList<BookingCheck> selectBkList(String userid) {
		Connection conn = getConnection();
		ArrayList<BookingCheck> list = bdao.selectBkList(conn, userid);
		close(conn);
		return list;
	}

}
