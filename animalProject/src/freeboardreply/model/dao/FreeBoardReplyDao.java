package freeboardreply.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import freeboard.model.vo.FreeBoard;
import freeboardreply.model.vo.FreeBoardReply;

public class FreeBoardReplyDao {


	public int insertReply(Connection conn, FreeBoardReply replyBoard) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "INSERT INTO FREEBOARD_REPLY VALUES(seq_freereplyno.nextval, ?, SYSDATE, ?, ?, 'n')";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, replyBoard.getFreereplycontent());
			pstmt.setString(2, replyBoard.getUserid());
			pstmt.setInt(3, replyBoard.getFreeboardno());
	
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	

	public int deleteReply(Connection conn, int freeReplyNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "UPDATE FREEBOARD_REPLY SET FREEBOARD_DELETE = 'Y' WHERE FREEREPLY_NO = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, freeReplyNo);
	
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	
	
	public FreeBoard selectFreeBoard(Connection conn, int freeBoardNo) {
		FreeBoard freeboard = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from freeboard "
				+ "where freeboard_no = ? and freeboard_delete in('n', 'N', null)";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, freeBoardNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				
				freeboard = new FreeBoard();
				
				freeboard.setFreeboardNo(rset.getInt("FREEBOARD_NO"));
				freeboard.setFreeboardTitle(rset.getString("FREEBOARD_TITLE"));
				freeboard.setFreeboardContent(rset.getString("FREEBOARD_CONTENT"));
				freeboard.setFreeboardDate(rset.getDate("FREEBOARD_DATE"));
				freeboard.setFreeboardOriginalFile(rset.getString("FREEBOARD_ORIGINFILE"));
				freeboard.setFreeboardViews(rset.getInt("FREEBOARD_VIEWS"));
				freeboard.setFreeboardRecommend(rset.getInt("FREEBOARD_RECOMMEND"));
				freeboard.setUserId(rset.getString("USER_ID"));
				freeboard.setFreeboardDelete(rset.getString("FREEBOARD_DELETE"));
				freeboard.setFreeboardRefile(rset.getString("FREEBOARD_REFILE"));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return freeboard;
	}

	
	public ArrayList<FreeBoardReply> selectReplyList(Connection conn, HashMap<String, Object> map) {
		ArrayList<FreeBoardReply> flist = new ArrayList<>();
		
		int freeBoardNo = (Integer)map.get("freeBoardNo");
		int startRow = (Integer)map.get("startRow");		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "SELECT * " + 
					   "FROM(SELECT ROWNUM RNUM, FREEREPLY_NO, FREEREPLY_CONTENT, " + 
					   "FREEREPLY_DATE, USER_ID, FREEBOARD_DELETE, FREEBOARD_NO " + 
					   "FROM (SELECT * " + 
					   "FROM FREEBOARD_REPLY WHERE " + 
					   "FREEBOARD_NO = (SELECT FREEBOARD_NO FROM FREEBOARD WHERE FREEBOARD_NO = ?) " + 
					   "AND FREEBOARD_DELETE IN('N', 'n', null) ORDER BY FREEREPLY_NO ASC)) " + 
					   "WHERE RNUM >= ? AND RNUM <= ?";	
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, freeBoardNo);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, startRow+9);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				FreeBoardReply freeReply = new FreeBoardReply();
				
				freeReply.setFreereply(rset.getInt("FREEREPLY_NO"));
				freeReply.setFreereplycontent(rset.getString("FREEREPLY_CONTENT"));
				freeReply.setFreereplydate(rset.getDate("FREEREPLY_DATE"));
				freeReply.setUserid(rset.getString("USER_ID"));
				freeReply.setFreeboardno(rset.getInt("FREEBOARD_NO"));
				freeReply.setFreeboarddelete(rset.getString("FREEBOARD_DELETE"));				
				
				flist.add(freeReply);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return flist;
	}

	public int getListCount(Connection conn, HashMap<String, Object> map) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int freeBoardNo = (Integer)map.get("freeBoardNo");
		int listCount = 1;
	
		String query = "select count(*) from freeboard_reply where freeboard_no = ? and FREEBOARD_DELETE='n'";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, freeBoardNo);
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

	public int updateReply(Connection conn, String freeReplyContent, int freeReplyNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "UPDATE FREEBOARD_REPLY "
				+ "SET FREEREPLY_CONTENT = ? "
				+ "WHERE FREEREPLY_NO = ?";
		
		try {
			pstmt = conn.prepareStatement(query);			
			pstmt.setString(1, freeReplyContent);
			pstmt.setInt(2, freeReplyNo);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
		
	}

	public FreeBoardReply selectReplyList(Connection conn, int freeReplyNo) {
		FreeBoardReply freeReply = new FreeBoardReply();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from freeboard_reply where freereply_no = ?";
		
		try {
		
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, freeReplyNo);
			
			rset = pstmt.executeQuery();
			
		while(rset.next()) {
				
			freeReply.setFreereply(rset.getInt("FREEREPLY_NO"));
			freeReply.setFreereplycontent(rset.getString("FREEREPLY_CONTENT"));
			freeReply.setFreereplydate(rset.getDate("FREEREPLY_DATE"));
			freeReply.setUserid(rset.getString("USER_ID"));
			freeReply.setFreeboardno(rset.getInt("FREEBOARD_NO"));
			freeReply.setFreeboarddelete(rset.getString("FREEBOARD_DELETE"));	
			
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return freeReply;
	}


}
