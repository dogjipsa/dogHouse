package report.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;

import report.model.dao.ReportDao;
import report.model.vo.Report;

public class ReportService {
	
	private ReportDao rdao = new ReportDao();

	public int reportInsert(Report r) {
		Connection conn = getConnection();
		int result = rdao.reportInsert(conn, r);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

}
