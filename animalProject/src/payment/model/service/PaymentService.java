package payment.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import booking.model.vo.Booking;

import static common.JDBCTemplate.*;
import payment.model.dao.PaymentDao;
import payment.model.vo.Payment;


public class PaymentService {
	
	private PaymentDao pdao = new PaymentDao(); 
	
	public int insertPayment(int bookingNo, String pMethod) {
		Connection conn = getConnection();
		int result = pdao.insertPayment(conn, bookingNo, pMethod);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public ArrayList<Payment> selectList(String userid) {
		Connection conn = getConnection();
		ArrayList<Payment> list = pdao.selectList(conn, userid);
		close(conn);
		return list;
	}

	public Booking selectBooking(int bookingNo) {
		Connection conn = getConnection();
		Booking b = pdao.selectBooking(conn, bookingNo);
		close(conn);
		return b;
	}

}
