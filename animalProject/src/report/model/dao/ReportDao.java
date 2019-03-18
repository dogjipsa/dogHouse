package report.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;

import report.model.vo.Report;

public class ReportDao {

	public int reportInsert(Connection conn, Report r) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query="insert into report values(?,?,?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, r.getReportNo());
			pstmt.setString(2, r.getReportContent());
			pstmt.setString(3, r.getReportCategory());
			pstmt.setInt(4, r.getBoardNo());
			pstmt.setString(5, r.getUserId());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int reportUpdate(Connection conn, Report r) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query="update from report set report_content = ?, report_category = ? ,board_no = ? where report_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, r.getReportContent());
			pstmt.setString(2, r.getReportCategory());
			pstmt.setInt(3, r.getBoardNo());
			pstmt.setInt(4, r.getReportNo());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int reportDelete(Connection conn, int rno) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query="delete report where report_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, rno);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

}
