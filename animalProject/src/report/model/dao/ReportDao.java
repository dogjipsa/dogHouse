package report.model.dao;

import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import freeboard.model.vo.FreeBoard;

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

	public ArrayList<Report> selectReportList(Connection conn, HashMap<String, Object> listOpt) {
		ArrayList<Report> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int startRow = (Integer)listOpt.get("startRow");
		
			String query = "SELECT * " + 
					"FROM (SELECT ROWNUM RNUM, REPORT_NO, " + 
					"REPORT_CONTENT, " + 
					"REPORT_CATEGORY, " + 
					"BOARD_NO, " + 
					"USER_ID " +
					"FROM (SELECT * FROM REPORT " +
					"ORDER BY REPORT_NO DESC)) " +  
					"WHERE RNUM >= ? AND RNUM <= ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, startRow+9);
				
				rset = pstmt.executeQuery();
							
				while(rset.next()) {
					
					Report report = new Report();
					
					report.setReportNo(rset.getInt("REPORT_NO"));
					report.setReportContent(rset.getString("REPORT_CONTENT"));
					report.setReportCategory(rset.getString("REPORT_CATEGORY"));
					report.setBoardNo(rset.getInt("BOARD_NO"));
					report.setUserId(rset.getString("USER_ID"));
							
					list.add(report);
					}
		
			} catch (Exception e) {
				e.printStackTrace();
			}
			return list;
	}

	
	public int getListCount(Connection conn, HashMap<String, Object> listOpt) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int listCount = 1;
		
		String query = "select count(*) from report";
		
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				listCount = rset.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return listCount;
	}
		

}
