package freeboardreply.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;

import freeboard.model.vo.FreeBoard;
import freeboardreply.model.dao.FreeBoardReplyDao;
import freeboardreply.model.vo.FreeBoardReply;
import freeboardreply.model.vo.FreeBoardReply;

public class FreeBoardReplyService {

	private FreeBoardReplyDao fdao = new FreeBoardReplyDao();
	
	public int updateReply(FreeBoardReply replyBoard) {
		Connection conn = getConnection();
		int result = fdao.updateReply(conn, replyBoard);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}
	
	
	public void updateReplySeq(FreeBoardReply replyBoard) {
		Connection conn = getConnection();
		int result = fdao.updateReplySeq(conn, replyBoard);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return;
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
	
	public int deleteReply(FreeBoardReply replyBoard) {
		Connection conn = getConnection();
		int result = fdao.deleteReply(conn, replyBoard);
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


	public FreeBoardReply selectReply(int freeReplyNo) {
		Connection conn = getConnection();
		FreeBoardReply freeReply = fdao.selectReply(conn, freeReplyNo);
		close(conn);
		
		return freeReply;
	}

	
}
