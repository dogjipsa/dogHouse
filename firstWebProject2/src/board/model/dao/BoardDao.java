package board.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import board.model.dao.BoardDao;
import board.model.vo.Board;

import static common.JDBCTemplate.*;

public class BoardDao {

	public int getListCount(Connection conn) {
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from board";
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next()) {
				listCount = rset.getInt(1);
				
			}
			
		} catch (Exception e) {
		
		}finally {
			close(rset);
			close(stmt);
		}
				
		return listCount;
	}

	public ArrayList<Board> selectList(int currentPage, int limit, Connection conn) {
		ArrayList<Board> list = new ArrayList<Board>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		int startRow = (currentPage -1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		String query = "select * " + 
				"from (select rownum rnum, board_num, board_writer, board_title, board_content, board_original_filename," + 
				"board_rename_filename, board_ref, board_reply_ref, board_reply_lev, board_reply_seq, board_readcount," + 
				"board_date " + 
				"from (select * from board " + 
				"order by board_ref desc, board_reply_ref desc, board_reply_lev asc, board_reply_seq asc))" + 
				"where rnum >= ? and rnum <= ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Board board = new Board();
				
				board.setBoardNum(rset.getInt("board_num"));
				board.setBoardTitle("board_title");
				board.setBoardWriter("board_wrtier");
				board.setBoardContent(rset.getString("board_content"));
				board.setBoardDate(rset.getDate("board_date"));
				board.setBoardOriginalFilename(rset.getString("board_original_filename"));
				board.setBoardRenameFilename(rset.getString("board_rename_filename"));
				board.setBoardReplyLev(rset.getInt("board_reply_lev"));
				board.setBoardRef(rset.getInt("board_ref"));
				board.setBoardReplyRef(rset.getInt("board_reply_ref"));
				board.setBoardReplySeq(rset.getInt("board_reply_seq"));
				board.setBoardReadcount(rset.getInt("board_readcount"));
				
				list.add(board);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int addReadCount(Connection conn, int boardNum) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update board set board_readcount = board_readcount + 1 where board_num = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, boardNum);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	public Board selectBoard(Connection conn, int boardNum) {
		Board board = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from board where board_num = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, boardNum);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				board = new Board();
								
				board.setBoardNum(rset.getInt("board_num"));
				board.setBoardTitle(rset.getString(2));
				board.setBoardWriter(rset.getString(3));
				board.setBoardContent(rset.getString("board_content"));
				board.setBoardDate(rset.getDate("board_date"));
				board.setBoardOriginalFilename(rset.getString("board_original_filename"));
				board.setBoardRenameFilename(rset.getString("board_rename_filename"));
				board.setBoardReplyLev(rset.getInt("board_reply_lev"));
				board.setBoardRef(rset.getInt("board_ref"));
				board.setBoardReplyRef(rset.getInt("board_reply_ref"));
				board.setBoardReplySeq(rset.getInt("board_reply_seq"));
				board.setBoardReadcount(rset.getInt("board_readcount"));
				System.out.println(board);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return board;
	}

	
}
