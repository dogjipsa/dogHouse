package tipboardreply.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import tipboard.model.vo.TipBoard;
import tipboardreply.model.vo.TipBoardReply;

public class TipBoardReplyDao {

	public int delteTipBoardReply(Connection conn, int tipReplyBoardNum, int tipBoardNum) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int insertBoard(Connection conn, TipBoardReply trboard) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "insert into tipboard_reply values(seq_tipreplyno.nextval, ?, sysdate, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, trboard.getTipReplyContent());
			pstmt.setInt(2, trboard.getTipNo());
			pstmt.setString(3, trboard.getUserId());
			pstmt.setString(4, "TIPREPLY_DELETE");
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public TipBoardReply selectBoard(Connection conn, int tipBoardNum) {
		// TODO Auto-generated method stub
		return null;
	}

	public ArrayList<TipBoardReply> selectList(Connection conn) {
		ArrayList<TipBoard> list = new ArrayList<TipBoard>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		//해당 페이지에 출력할 목록의 시작행과 끝행 계산
		/*int startRow = (currentPage -1) * limit + 1;
		int endRow = startRow + limit - 1;*/
		
		/*String query = "SELECT *  FROM (SELECT ROWNUM RNUM,  TIPBOARD_NO,TIPBOARD_TITLE,TIPBOARD_CONTENT,TIPBOARD_DATE,TIPBOARD_ORIGINFILE,TIPBOARD_VIEWS,TIPBOARD_RECOMMEND,USER_ID,TIPBOARD_DELETE,TIPBOARD_REFILE " + 
				"				FROM (SELECT * FROM TIPBOARD where tipboard_delete in('n','N',null) order by tipboard_no desc)) " + 
				"				WHERE RNUM >= ? AND RNUM <= ? ";*/
		/*String query = "select * from tipboard";*/
		String query="select * from tipboard_reply where TIPREPLY_DELETE in('n','N',null) order by TIPREPLY_NO";
		
		try {
			
				/*String query = "SELECT *  FROM (SELECT ROWNUM RNUM,  TIPBOARD_NO,TIPBOARD_TITLE,TIPBOARD_CONTENT,TIPBOARD_DATE,TIPBOARD_ORIGINFILE,TIPBOARD_VIEWS,TIPBOARD_RECOMMEND,USER_ID,TIPBOARD_DELETE,TIPBOARD_REFILE " + 
						"				FROM (SELECT * FROM TIPBOARD where tipboard_delete in('n','N',null) order by tipboard_no desc)) " + 
						"				WHERE RNUM >= ? AND RNUM <= ? ";*/
				pstmt = conn.prepareStatement(query);
				/*pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);*/
				rset = pstmt.executeQuery();
				while(rset.next()) {
					TipBoardReply trboard = new TipBoardReply();
					
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

}
