package prebooking.model.sevice;

import static common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import prebooking.model.dao.*;
import prebooking.model.vo.*;

public class PreBookingSevice {

	private PreBookingDao pdao = new PreBookingDao();
	
	public PreBookingSevice() {}
	
	public int insertPreBooking(PreBooking prebooking){
		Connection conn = getConnection();
		int result = pdao.insertPreBooking(conn, prebooking);
		return null;
	}

	public int deletePreBooking(PreBooking prebooking) {
		Connection conn = getConnection();
		int result = pdao.deletePreBooking(conn, prebooking);
		return null;
	}
	
	public void updatePreBooking(PreBooking prebooking) {
		Connection conn = getConnection();
		int result = pdao.updatePreBooking(conn, prebooking);
	}
	
	public ArrayList<PreBooking> selectList(String userid){
		Connection conn = getConnection();
		ArrayList<PreBooking> plist = pdao.selectList(conn, userid);
		return null;
	}
	
	
}
