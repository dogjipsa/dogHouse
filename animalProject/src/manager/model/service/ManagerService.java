package manager.model.service;

import manager.model.dao.ManagerDao;
import manager.model.vo.Manager;
import notice.model.vo.Notice;
import tipboard.model.vo.TipBoard;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import faq.model.vo.Faq;
import freeboard.model.vo.FreeBoard;

public class ManagerService {
	private ManagerDao manDao = new ManagerDao();
	
	public ManagerService() {}

	public Manager loginManager(String managerId, String managerPwd) {
		//관리자 로그인 처리
		Connection conn = getConnection();
		Manager loginManager = manDao.loginManager(conn, managerId, managerPwd);
		System.out.println(loginManager);
		close(conn);
		
		return loginManager;
	}

	public int boardListCount() {
		Connection conn = getConnection();
		int result = manDao.boardListCount(conn);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		return result;
	}
	public int faqboardListCount() {
		Connection conn = getConnection();
		int result = manDao.faqboardListCount(conn);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		return result;
	}
	public int tipboardListCount() {
		Connection conn = getConnection();
		int result = manDao.tipboardListCount(conn);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		return result;
	}

	public ArrayList<FreeBoard> selectFreeBoardList(int currentPage, int pageList) {
		Connection conn = getConnection();
		ArrayList<FreeBoard> fList = manDao.selectFreeBoardList(conn, currentPage, pageList);
		close(conn);
		
		return fList;
	}

	public ArrayList<TipBoard> selectTipBoardList(int currentPage, int pageList) {
		Connection conn = getConnection();
		ArrayList<TipBoard> tList = manDao.selectTipBoardList(conn, currentPage, pageList);
		close(conn);
		
		return tList;
	}

	public ArrayList<Faq> selectFAQList(int currentPage, int pageList) {
		Connection conn = getConnection();
		ArrayList<Faq> faqList = manDao.selectFAQList(conn, currentPage, pageList);
		close(conn);
		
		return faqList;
	}

	public int managerDeleteFreeBoard(String delNo) {
		Connection conn = getConnection();
		int result = manDao.managerDeleteFreeBoard(conn, delNo);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		return result;
	}
}
