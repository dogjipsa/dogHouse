package freeboardreply.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import freeboard.model.vo.FreeBoard;
import freeboardreply.model.vo.FreeBoardReply;

public class FreeBoardReplyDao {

	public int updateReply(Connection conn, FreeBoardReply replyBoard) {
		
		return 0;
	}

	public int updateReplySeq(Connection conn, FreeBoardReply replyBoard) {
		
		return 0;
	}

	public int insertReply(Connection conn, FreeBoardReply replyBoard) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "INSERT INTO FREEBOARD_REPLY VALUES(seq_freply.nextval, ?, SYSDATE, 'user01', ?, 'N')";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, replyBoard.getFreereplycontent());
			pstmt.setInt(2, replyBoard.getFreeboardno());
	
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	

	public int deleteReply(Connection conn, FreeBoardReply replyBoard) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	public FreeBoard selectFreeBoard(Connection conn, int freeBoardNo) {
		FreeBoard freeboard = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from freeboard "
				+ "where freeboard_no = ?";
		
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

	
	public FreeBoardReply selectReply(Connection conn, int freeReplyNo) {
		FreeBoardReply freeReply = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from freeboard_reply where freereply_no = ? and freeboard_delete in('N', 'n')";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, freeReplyNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				freeReply = new FreeBoardReply();
				
				freeReply.setFreeboardno(rset.getInt("FREEREPLY_NO"));
				freeReply.setFreereplycontent(rset.getString("FREEREPLY_CONTENT"));
				freeReply.setFreereplydate(rset.getDate("FREEREPLY_DATE"));
				freeReply.setUserid(rset.getString("USER_ID"));
				freeReply.setFreeboardno(rset.getInt("FREEBOARD_NO"));
				freeReply.setFreeboarddelete(rset.getString("FREE_BOARD_DELETE"));				
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return freeReply;
	}


}
