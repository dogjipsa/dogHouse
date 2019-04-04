package report.model.dao;

import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import static common.JDBCTemplate.*;


import report.model.vo.Report;

public class ReportDao {

	public ReportDao() {}
	
	public int insertReportFreeBoard(Connection conn, Report rfreport) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		
		String query = "insert into report values(seq_reportno.nextval, ?, ?, ?, ?)";
		
		updateFreeBoardReport(conn, rfreport);
		try {
			pstmt = conn.prepareStatement(query);
			

			pstmt.setString(1, rfreport.getReportContent());
			pstmt.setString(2, rfreport.getReportCategory());
			pstmt.setInt(3, rfreport.getBoardNo());
			pstmt.setString(4, rfreport.getUserId());
			
		
			result = pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	
	private void updateFreeBoardReport(Connection conn, Report rfreport) {
		PreparedStatement pstmt = null;
		
		String query = "update member set report_add = (select max(report_add) + 1 from member where user_id = ?) where user_id = ?";
		
	
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, rfreport.getUserId());
			pstmt.setString(2, rfreport.getUserId());
			
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	

	public int insertReportTipBoard(Connection conn, Report rtreport) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		
		String query = "insert into report values(seq_reportno.nextval, ?, ?, ?, ?)";
		
		updateTipBoardReport(conn, rtreport);
		
		try {
			pstmt = conn.prepareStatement(query);
	
			pstmt.setString(1, rtreport.getReportContent());
			pstmt.setString(2, rtreport.getReportCategory());
			pstmt.setInt(3, rtreport.getBoardNo());
			pstmt.setString(4, rtreport.getUserId());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	private void updateTipBoardReport(Connection conn, Report rtreport) {		
		PreparedStatement pstmt = null;
		
		String query = "update member set report_add = (select max(report_add) + 1 from member where user_id = ?) where user_id = ?";
		
	
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, rtreport.getUserId());
			pstmt.setString(2, rtreport.getUserId());
			
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
