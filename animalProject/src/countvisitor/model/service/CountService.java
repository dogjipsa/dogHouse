package countvisitor.model.service;

import countvisitor.model.dao.CountVisitorDao;
import countvisitor.model.vo.CountVisitor;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;

public class CountService {
	private CountVisitorDao cntDao = new CountVisitorDao();
	
	public CountVisitor selectCntVisitor(Date day) {
		Connection conn = getConnection();
		CountVisitor cntList = cntDao.selectCntVisitor(conn, day);
		close(conn);
		return cntList;
	}
	public boolean isToday(Date day) {
		Connection conn = getConnection();
		boolean result = cntDao.isToday(conn, day);
		close(conn);
		
		return result;
	}
	public int updateCount(Date day) {
		Connection conn = getConnection();
		int result = cntDao.updateCount(conn, day);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		
		return result;
		
	}
	public int insertCount(CountVisitor cntVisitor) {
		Connection conn = getConnection();
		int result = cntDao.insertCount(conn, cntVisitor);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		
		return result;
		
	}

}
