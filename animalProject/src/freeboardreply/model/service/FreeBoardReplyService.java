package freeboardreply.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import freeboard.model.vo.FreeBoard;
import freeboardreply.model.dao.FreeBoardReplyDao;
import freeboardreply.model.vo.FreeBoardReply;
import freeboardreply.model.vo.FreeBoardReply;

public class FreeBoardReplyService {

	private FreeBoardReplyDao fdao = new FreeBoardReplyDao();
	
	public int getListCount(HashMap<String, Object> map) {
		Connection conn = getConnection();
		int listCount = fdao.getListCount(conn, map);
		close(conn);
		return listCount;
	}
	

	public int updateReply(String freeReplyContent, int freeReplyNo) {
		Connection conn = getConnection();
		int result = fdao.updateReply(conn, freeReplyContent, freeReplyNo);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}
	
	
	public int insertReply(FreeBoardReply replyBoard) {
		Connection conn = getConnection();
		int result = fdao.insertReply(conn, replyBoard);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}
	
	public int deleteReply(int freeReplyNo) {
		Connection conn = getConnection();
		int result = fdao.deleteReply(conn, freeReplyNo);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}


	public FreeBoard selectFreeBoard(int freeBoardNo) {
		Connection conn = getConnection();
		FreeBoard freeboard = fdao.selectFreeBoard(conn, freeBoardNo);
		close(conn);
		
		return freeboard;
	}


	public ArrayList<FreeBoardReply> selectReplyList(HashMap<String, Object> map) {
		Connection conn = getConnection();
		ArrayList<FreeBoardReply> flist = fdao.selectReplyList(conn, map);
		close(conn);
		
		return flist;
	}


	public FreeBoardReply selectReply(int freeReplyNo) {
		Connection conn = getConnection();
		FreeBoardReply freereply = fdao.selectReplyList(conn, freeReplyNo);
		close(conn);
		
		return freereply;
	}


	

	
}
