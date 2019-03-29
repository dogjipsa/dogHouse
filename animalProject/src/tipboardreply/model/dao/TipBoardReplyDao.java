package tipboardreply.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import tipboard.model.vo.TipBoard;
import tipboardreply.model.vo.TipBoardReply;

public class TipBoardReplyDao {

	public int delteTipBoardReply(Connection conn, int tipBoardNum) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE TIPBOARD_REPLY SET TIPREPLY_DELETE = 'Y' WHERE TIPREPLY_NO = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, tipBoardNum);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
			
		return result;
	}

	public int insertBoard(Connection conn, TipBoardReply trboard) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "insert into tipboard_reply values(seq_tipreplyno.nextval, ?, sysdate, ?, ?, 'n')";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, trboard.getTipReplyContent());
			pstmt.setInt(2, trboard.getTipNo());
			pstmt.setString(3, trboard.getUserId());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}



	public ArrayList<TipBoardReply> selectList(Connection conn, int tipBoardNo, int trcurrentPage, int limit) {
		ArrayList<TipBoardReply> list = new ArrayList<TipBoardReply>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		
		//해당 페이지에 출력할 목록의 시작행과 끝행 계산
		int startRow = (trcurrentPage -1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		/*String query = "SELECT *  FROM (SELECT ROWNUM RNUM,  TIPBOARD_NO,TIPBOARD_TITLE,TIPBOARD_CONTENT,TIPBOARD_DATE,TIPBOARD_ORIGINFILE,TIPBOARD_VIEWS,TIPBOARD_RECOMMEND,USER_ID,TIPBOARD_DELETE,TIPBOARD_REFILE " + 
				"				FROM (SELECT * FROM TIPBOARD where tipboard_delete in('n','N',null) order by tipboard_no desc)) " + 
				"				WHERE RNUM >= ? AND RNUM <= ? ";*/
		/*String query = "select * from tipboard";*/
		/*String query="select * from tipboard_reply where TIPREPLY_DELETE in('n','N',null) and TIP_NO = ? order by TIPREPLY_NO";*/
		String query = "select * from (select rownum rnum, TIPREPLY_NO,TIPREPLY_CONTENT,TIPREPLY_DATE,TIP_NO,USER_ID,TIPREPLY_DELETE from (select * from tipboard_reply where TIPREPLY_DELETE in('n','N',null) and TIP_NO = ? order by TIPREPLY_NO)) where rnum >=? and rnum <=?";
		
		try {
			
				/*String query = "SELECT *  FROM (SELECT ROWNUM RNUM,  TIPBOARD_NO,TIPBOARD_TITLE,TIPBOARD_CONTENT,TIPBOARD_DATE,TIPBOARD_ORIGINFILE,TIPBOARD_VIEWS,TIPBOARD_RECOMMEND,USER_ID,TIPBOARD_DELETE,TIPBOARD_REFILE " + 
						"				FROM (SELECT * FROM TIPBOARD where tipboard_delete in('n','N',null) order by tipboard_no desc)) " + 
						"				WHERE RNUM >= ? AND RNUM <= ? ";*/
				pstmt = conn.prepareStatement(query);
				/*pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);*/
				pstmt.setInt(1, tipBoardNo);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
				rset = pstmt.executeQuery();
				while(rset.next()) {
					TipBoardReply trboard = new TipBoardReply();
					trboard.setTipReplyNo(rset.getInt("TIPREPLY_NO"));
					trboard.setTipReplyContent(rset.getString("TIPREPLY_CONTENT"));
					trboard.setTipReplyDate(rset.getDate("TIPREPLY_DATE"));
					trboard.setTipNo(tipBoardNo);
					trboard.setUserId(rset.getString("USER_ID"));
					trboard.setTipReplyDelete("TIPREPLY_DELETE");
					list.add(trboard);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int getListCount(Connection conn, int tipBoardNo) {
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from tipboard_reply where tip_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, tipBoardNo);
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

	public int updateReply(Connection conn, String tipReplyContent, int tipBoardReplyNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update tipboard_reply set tipreply_content = ? where tipreply_no = ?";
			
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, tipReplyContent);
			pstmt.setInt(2, tipBoardReplyNo);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public TipBoardReply selectTipBoardReply(Connection conn, int tipBoardNo) {
		TipBoardReply trboard = new TipBoardReply();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "SELECT * FROM TIPBOARD_REPLY WHERE TIPREPLY_NO = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, tipBoardNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				
				trboard = new TipBoardReply();
				trboard.setTipReplyNo(rset.getInt("TIPREPLY_NO"));
				trboard.setTipReplyContent(rset.getString("TIPREPLY_CONTENT"));
				trboard.setTipReplyDate(rset.getDate("TIPREPLY_DATE"));
				trboard.setTipNo(tipBoardNo);
				trboard.setUserId(rset.getString("USER_ID"));
				trboard.setTipReplyDelete("TIPREPLY_DELETE");
				}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
	
		return trboard;
	}

}
