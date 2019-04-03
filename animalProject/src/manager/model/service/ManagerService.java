package manager.model.service;

import manager.model.dao.ManagerDao;
import manager.model.vo.Manager;
import member.model.vo.Member;
import question.model.vo.Question;
import tipboard.model.vo.TipBoard;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

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

	public int boardListCount(String option, String word) {
		Connection conn = getConnection();
		int result = manDao.boardListCount(conn, option, word);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		return result;
	}
	
	public int tipboardListCount(String option, String word) {
		Connection conn = getConnection();
		int result = manDao.tipboardListCount(conn, option, word);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		return result;
	}

	public ArrayList<FreeBoard> selectFreeBoardList(int currentPage, int pageList, String option, String word) {
		Connection conn = getConnection();
		System.out.println("서비스 word : " + word);
		ArrayList<FreeBoard> fList = manDao.selectFreeBoardList(conn, currentPage, pageList, option, word);
		close(conn);
		System.out.println("서비스 flist " + fList);
		return fList;
	}

	public ArrayList<TipBoard> selectTipBoardList(int currentPage, int pageList, String option, String word) {
		Connection conn = getConnection();
		ArrayList<TipBoard> tList = manDao.selectTipBoardList(conn, currentPage, pageList, option, word);
		close(conn);
		
		return tList;
	}




	public ArrayList<Member> selectMemberList(HashMap<String, Object> listOpt) {
		Connection conn = getConnection();
		ArrayList<Member> memberList = manDao.selectMemberList(conn, listOpt);
		close(conn);
		
		return memberList;
	}
	
	public ArrayList<Member> selectPetsitterList(HashMap<String, Object> listOpt) {
		Connection conn = getConnection();
		ArrayList<Member> petsitterList = manDao.selectPetsitterList(conn, listOpt);
		close(conn);
		
		return petsitterList;
	}

	public int getMemberListCount(HashMap<String, Object> listOpt) {
		Connection conn = getConnection();
		int listCount = manDao.memberListCount(conn, listOpt);
		return listCount;
	}
	
	public int getPetsitterListCount(HashMap<String, Object> listOpt) {
		Connection conn = getConnection();
		int listCount = manDao.petsitterListCount(conn, listOpt);
		return listCount;
	}

	public int updatePetsitter(String userId) {
		Connection conn = getConnection();
		int result = manDao.updatePetsitter(conn, userId);
		System.out.println("service result : " + result);
		if(result > 0) 
			commit(conn);
		else 
			rollback(conn);
		close(conn);
		
		return result;
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
	public int managerDeleteTipBoard(String delNo) {
		Connection conn = getConnection();
		int result = manDao.managerDeleteTipBoard(conn, delNo);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		return result;
	}
	
	

	public ArrayList<FreeBoard> selectReadCountTop5() {
		Connection conn = getConnection();
		ArrayList<FreeBoard> flist = manDao.selectReadCountTop5(conn);
		close(conn);
		
		return flist;
	}


	public ArrayList<Question> selectQuestionList(int currentPage, int limit) {
		Connection conn = getConnection();
		ArrayList<Question> list = manDao.selectQuestionList(conn,currentPage,limit);
		System.out.println("서비스"+currentPage + "=" + limit + "=" + list );
		close(conn);
		return list;
	}

	public int QuestionListCount() {
		Connection conn = getConnection();
		int result = manDao.questionListCount(conn);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
    close(conn);
    return result;
  }

	public ArrayList<TipBoard> selectReadCountTBTop5() {
		Connection conn = getConnection();
		ArrayList<TipBoard> tlist = manDao.selectReadCountTBTop5(conn);
		close(conn);
		
		return tlist;
	}
	

	public int managerDeleteMember(String delId) {
		Connection conn = getConnection();
		int result = manDao.managerDeleteMember(conn, delId);
		if(result > 0)
		commit(conn);
			else
		rollback(conn);
		return result;
	}


	public boolean checkLogoutManager(String managerId) {
		Connection conn = getConnection();
		boolean result = manDao.checkLogoutManager(conn, managerId);
		close(conn);
		
		return result;
  }

	public ArrayList<Notice> searchNoticeList(HashMap<String, Object> listOpt) {
		Connection conn = getConnection();
		ArrayList<Notice> mlist = manDao.searchNoticeList(conn, listOpt);
		close(conn);
		return mlist;
	}

	public int getNoticeListCount(HashMap<String, Object> listOpt) {
		Connection conn = getConnection();
		int listCount = manDao.getNoticeListCount(conn, listOpt);
		close(conn);
		return listCount;
	}

	public void addReadCount(int noticeNo) {
		Connection conn = getConnection();
		int result = manDao.addReadCount(conn, noticeNo);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		
	}

	public Notice selectNoitce(int noticeNo) {
		Connection conn = getConnection();
		Notice notice = manDao.selectNotice(conn, noticeNo);
		close(conn);
		return notice;

	}
	
}
