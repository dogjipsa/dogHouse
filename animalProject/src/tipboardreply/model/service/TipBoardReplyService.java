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
	
	public int deleteTipBoardReply(int tipReplyBoardNum, int tipBoardNum) {
		Connection conn = getConnection();
		int result = trdao.delteTipBoardReply(conn, tipReplyBoardNum, tipBoardNum);
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
	public TipBoardReply selectTipBoardReply(int tipBoardNum) {
		Connection conn = getConnection();
		TipBoardReply tboardRe = trdao.selectBoard(conn, tipBoardNum);
		close(conn);
		return tboardRe;
	}

	public ArrayList<TipBoardReply> selectList() {
		Connection conn = getConnection();
		ArrayList<TipBoardReply> list = trdao.selectList(conn);
		close(conn);
		return list;
	}
}
