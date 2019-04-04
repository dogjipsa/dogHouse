package countvisitor.model.dao;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import countvisitor.model.vo.CountVisitor;

public class CountVisitorDao {
	public CountVisitorDao() {}
	
	public boolean isToday(Connection conn, Date day) {
		boolean result = false;
		PreparedStatement pstat = null;
		ResultSet rSet = null;
		
		String query = "select * from countvisitor where visit_date = ? ";
		try {
			pstat = conn.prepareStatement(query);
			pstat.setDate(1, day);
			rSet = pstat.executeQuery();
			if(rSet.next()) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}
		return result;
	}
	
	public int updateCount(Connection conn, Date day) {
		int result = 0;
		PreparedStatement pstat = null;
		
		String query = "update countvisitor set count_visitor = count_visitor + 1  where visit_date = ?";
		try {
			pstat = conn.prepareStatement(query);
			pstat.setDate(1, day);
			
			result = pstat.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstat);
		}
		return result;
	}
	public int insertCount(Connection conn, CountVisitor cntVisitor) {
		int result = 0;
		PreparedStatement pstat =null;
		String query = "insert into countvisitor values (?, ?)";
		try {
			pstat = conn.prepareStatement(query);
			pstat.setDate(1, cntVisitor.getVisitDate());
			pstat.setInt(2, cntVisitor.getCountVisitor());
			result = pstat.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstat);
		}
		return result;
	}
	public CountVisitor selectCntVisitor(Connection conn, Date day) {
		CountVisitor cv =null;
		PreparedStatement pstat =null;
		ResultSet rSet =null;
		String query = "select count_visitor from countvisitor where visit_date = ?";
		try {
			pstat = conn.prepareStatement(query);
			pstat.setDate(1, day);
			rSet = pstat.executeQuery();
			
			if(rSet.next()) {
				cv = new CountVisitor();
				cv.setCountVisitor(rSet.getInt("count_visitor"));
				cv.setVisitDate(day);
			}
			System.out.println(cv + " <- dao cv");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}
		return cv;
	}
	public CountVisitor sumOfvisitor(Connection conn) {
		CountVisitor cv = new CountVisitor();
		Statement stat = null;
		ResultSet rSet = null;
		String query = "select sum(count_visitor) from countvisitor";
		try {
			stat = conn.createStatement();
			rSet = stat.executeQuery(query);
			if(rSet.next()) {
				cv.setCountVisitor(rSet.getInt(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(stat);
		}
		return cv;
	}
}
