package payment.model.service;

import static common.JDBCTemplate.*;

import java.sql.Connection;

import payment.model.dao.PaymentDao;

public class PaymentService {
	
	private PaymentDao pdao = new PaymentDao(); 
	
	public int updatePostPayment(int bno) {
		Connection conn = getConnection();
		int result = pdao.updatePostPayment(conn, bno);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public int insertPayment(int bno, String method) {
		Connection conn = getConnection();
		int result = pdao.insertPayment(conn, bno, method);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

}
