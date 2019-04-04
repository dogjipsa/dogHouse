package payment.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import static common.JDBCTemplate.*;
public class PaymentDao {

	public int updatePostPayment(Connection conn, int bno) {
		PreparedStatement pstmt = null;
		String query = "UPDATE BOOKING SET BOOKING_PROGRESS = 3 WHERE BOOKING_NO = ? AND BOOKING_PROGRESS = 2";
		int result = 0;
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int insertPayment(Connection conn, int bno, String method) {
		PreparedStatement pstmt = null;
		String query = "INSERT INTO PAYMENT VALUES(?,SYSDATE,?,'Y')";
		int result = 0;
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bno);
			pstmt.setString(2, method);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

}
