package tipboard.model.service;

import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;

import tipboard.model.dao.TipBoardDao;
import tipboard.model.vo.TipBoard;
import tipboardreply.model.vo.TipBoardReply;

import static common.JDBCTemplate.*;
public class TipBoardService {
	private TipBoardDao tdao = new TipBoardDao();
	public TipBoardService() {}
	public int getListCount(String option, String word) {
		Connection conn = getConnection();
		int listCount = tdao.getListCount(conn, option, word);
		close(conn);
		return listCount;
	}

	public ArrayList<TipBoard> selectList(int currentPage, int limit, String option, String word) {
		Connection conn = getConnection();
		ArrayList<TipBoard> list = tdao.selectList(conn, currentPage, limit, option, word);
		close(conn);
		return list;
	}
	public int deleteTipBoard(int tipBoardNum) {
		Connection conn = getConnection();
		int result = tdao.deleteTipBoard(conn, tipBoardNum);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}
	public void addReadCount(int tipBoardNum) {
		Connection conn = getConnection();
		int result = tdao.addReadCount(conn, tipBoardNum);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		
	}
	public TipBoard selectBoard(int tipBoardNum) {
		Connection conn = getConnection();
		TipBoard tboard = tdao.selectBoard(conn, tipBoardNum);
		close(conn);
		return tboard;
	}
	public int insertBoard(TipBoard tboard) {
		Connection conn = getConnection();
		int result = tdao.insertBoard(conn, tboard);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}
	public int updateTipBoard(TipBoard tboard) {
		Connection conn = getConnection();
		int result = tdao.updateTipBoard(conn, tboard);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}
	
	public TipBoard selectTipBoard(int tipBoardNum) {
		Connection conn = getConnection();
		TipBoard tboard = tdao.selectBoard(conn, tipBoardNum);
		close(conn);
		return tboard;
	}
	

}
