package tipboardreply.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import tipboard.model.service.TipBoardService;
import tipboard.model.vo.TipBoard;
import tipboardreply.model.dao.TipBoardReplyDao;
import tipboardreply.model.vo.TipBoardReply;
import static common.JDBCTemplate.*;

public class TipBoardReplyService {
	
	private TipBoardReplyDao trdao = new TipBoardReplyDao();
	
	public TipBoardReplyService() {}
	
	public int deleteTipBoardReply(int tipBoardNum) {
		Connection conn = getConnection();
		int result = trdao.delteTipBoardReply(conn, tipBoardNum);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}
	
	public int insertTipBoardReply(TipBoardReply trboard) {
		Connection conn = getConnection();
		int result = trdao.insertBoard(conn, trboard);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}
	
	public TipBoardReply selectTipBoardReply(int tipBoardReplyNo) {
		Connection conn = getConnection();
		TipBoardReply tipReply = trdao.selectTipBoardReply(conn, tipBoardReplyNo);
		close(conn);
		return tipReply;
	}

	public ArrayList<TipBoardReply> selectList(int tipBoardNo, int trcurrentPage, int limit) {
		Connection conn = getConnection();
		ArrayList<TipBoardReply> list = trdao.selectList(conn, tipBoardNo, trcurrentPage, limit);
		close(conn);
		return list;
	}

	public int getListCount(int tipBoardNo) {
		Connection conn = getConnection();
		int listCount = trdao.getListCount(conn, tipBoardNo);
		close(conn);
		return listCount;
	}

	public int updateReply(String tipReplyContent, int tipBoardReplyNo) {
		Connection conn = getConnection();
		int result = trdao.updateReply(conn, tipReplyContent, tipBoardReplyNo);
		if(result>0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

}
