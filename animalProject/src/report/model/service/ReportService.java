package report.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;

import report.model.dao.ReportDao;
import report.model.vo.Report;


public class ReportService {
	ReportDao repdao = new ReportDao();
	
	public ReportService() {}

	public int insertReportFreeBoard(Report rfreport) {
		Connection conn = getConnection();
		int result = repdao.insertReportFreeBoard(conn, rfreport);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public int insertReportTipBoard(Report rtreport) {
		Connection conn = getConnection();
		int result = repdao.insertReportTipBoard(conn, rtreport);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public ArrayList<Report> selectReportList(HashMap<String, Object> listOpt) {
		Connection conn = getConnection();
		ArrayList<Report> rlist = repdao.selectReportList(conn, listOpt);
		close(conn);
		return rlist;
	}

	public int getListCount(HashMap<String, Object> listOpt) {
		Connection conn = getConnection();
		int listCount = repdao.getListCount(conn, listOpt);
		close(conn);
		return listCount;
	}
	
	
}
