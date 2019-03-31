package manager.model.dao;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import faq.model.vo.Faq;
import freeboard.model.vo.FreeBoard;
import manager.model.vo.Manager;
import notice.model.vo.Notice;
import tipboard.model.vo.TipBoard;

public class ManagerDao {

	public ManagerDao() {
	}

	public Manager loginManager(Connection conn, String managerId, String managerPwd) {
		// 관리자 로그인 시 조회용
		Manager loginManager = null;
		PreparedStatement pstat = null;
		ResultSet rSet = null;

		String query = "select * from manager where manager_id = ? and manager_password = ?";

		try {
			pstat = conn.prepareStatement(query);
			pstat.setString(1, managerId);
			pstat.setString(2, managerPwd);
			rSet = pstat.executeQuery();

			if (rSet.next()) {
				loginManager = new Manager();
				loginManager.setManagerId(managerId);
				loginManager.setManagerName(rSet.getString("manager_name"));
				loginManager.setManagerPassword(managerPwd);
				System.out.println(loginManager + "<- loginManager Dao");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}
		return loginManager;
	}

	public ArrayList<FreeBoard> selectFreeBoardList(Connection conn, int currentPage, int pageList) {
		// 게시판 목록 조회용
		// 일단 자유게시판 하나만 실험
		ArrayList<FreeBoard> freeboardList = new ArrayList<>();
		PreparedStatement pstat = null;
		ResultSet rSet = null;

		int startCount = (currentPage - 1) * pageList + 1;
		int endCount = currentPage * pageList;

		StringBuffer query = new StringBuffer();
		query.append(
				"select b.rnum, b.freeboard_no, b.user_id, b.freeboard_title, b.freeboard_content, b.freeboard_date, b.freeboard_delete ")
				.append("from ( select rownum as rnum, a.freeboard_no, a.user_id, a.freeboard_title, a.freeboard_content, a.freeboard_date, a.freeboard_delete ")
				.append("from ( select freeboard_no, user_id, freeboard_title, freeboard_content, freeboard_date, freeboard_delete ")
				.append("from freeboard order by freeboard_date desc) a ").append("where rownum <= ?) b ")
				.append("where b.rnum >= ?");
		/*query.append("select * from tipboard where rownum between ? and ? ")
			 .append("union all ")
			 .append("select * from freeboard where rownum between ? and ? ");*/
		try {
			pstat = conn.prepareStatement(query.toString());
			pstat.setInt(1, startCount);
			pstat.setInt(2, endCount);
			pstat.setInt(3, startCount);
			pstat.setInt(4, endCount);
			rSet = pstat.executeQuery();
			// 한 페이지당 10개까지만 출력되게

			while (rSet.next()) {
				FreeBoard freeBoard = new FreeBoard();
				freeBoard.setFreeboardTitle(rSet.getString("freeboard_title"));
				freeBoard.setUserId(rSet.getString("user_id"));
				freeBoard.setFreeboardNo(rSet.getInt("freeboard_no"));
				freeBoard.setFreeboardDelete(rSet.getString("freeboard_delete"));
				freeBoard.setFreeboardContent(rSet.getString("freeboard_content"));
				freeBoard.setFreeboardDate(rSet.getDate("freeboard_date"));
				/*
				 * freeBoard.setFreeboardOriginalFile(rSet.getString("freeboard_originfile"));
				 * freeBoard.setFreeboardViews(rSet.getInt("freeboard_views"));
				 * freeBoard.setFreeboardRecommend(rSet.getInt("freeboard_recommend"));
				 * freeBoard.setFreeboardDelete(rSet.getString("freeboard_delete"));
				 * freeBoard.setFreeboardRefile(rSet.getString("freeboard_refile"));
				 */
				/* System.out.println(managerList + "<- list dao"); */
				freeboardList.add(freeBoard);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}

		return freeboardList;
	}

	public int boardListCount(Connection conn) {
		int result = 0;
		Statement stat = null;
		ResultSet rSet = null;
		String query = ("select count(*) from freeboard");
		try {
			stat = conn.createStatement();
			rSet = stat.executeQuery(query);

			if (rSet.next()) {
				result = rSet.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(stat);
		}

		return result;
	}
	public int tipboardListCount(Connection conn) {
		int result = 0;
		Statement stat = null;
		ResultSet rSet = null;
		String query = ("select count(*) from tipboard");
		try {
			stat = conn.createStatement();
			rSet = stat.executeQuery(query);

			if (rSet.next()) {
				result = rSet.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(stat);
		}

		return result;
	}
	public int faqboardListCount(Connection conn) {
		int result = 0;
		Statement stat = null;
		ResultSet rSet = null;
		String query = ("select count(*) from faq");
		try {
			stat = conn.createStatement();
			rSet = stat.executeQuery(query);

			if (rSet.next()) {
				result = rSet.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(stat);
		}

		return result;
	}

	public ArrayList<TipBoard> selectTipBoardList(Connection conn, int currentPage, int pageList) {
		// 게시판 목록 조회용
		// 일단 자유게시판 하나만 실험
		ArrayList<TipBoard> tipboardList = new ArrayList<>();
		PreparedStatement pstat = null;
		ResultSet rSet = null;

		int startCount = (currentPage - 1) * pageList + 1;
		int endCount = currentPage * pageList;

		StringBuffer query = new StringBuffer();
		query.append("select b.rnum, b.tipboard_no, b.user_id, b.tipboard_title, b.tipboard_content, b.tipboard_date ")
				.append("from ( select rownum as rnum, a.tipboard_no, a.user_id, a.tipboard_title, a.tipboard_content, a.tipboard_date ")
				.append("from ( select tipboard_no, user_id, tipboard_title, tipboard_content, tipboard_date ")
				.append("from tipboard order by tipboard_date) a ").append("where rownum <= ?) b ")
				.append("where b.rnum >= ?");
		try {
			pstat = conn.prepareStatement(query.toString());
			pstat.setInt(1, endCount);
			pstat.setInt(2, startCount);
			rSet = pstat.executeQuery();

			while (rSet.next()) {
				TipBoard tipBoard = new TipBoard();
				tipBoard.setTipBoardTitle(rSet.getString("tipboard_title"));
				tipBoard.setUserId(rSet.getString("user_id"));
				tipBoard.setTipBoardNo(rSet.getInt("tipboard_no"));
				tipBoard.setTipBoardContent(rSet.getString("tipboard_content"));
				tipBoard.setTipBoardDate(rSet.getDate("tipboard_date"));
				/*
				 * freeBoard.setFreeboardOriginalFile(rSet.getString("freeboard_originfile"));
				 * freeBoard.setFreeboardViews(rSet.getInt("freeboard_views"));
				 * freeBoard.setFreeboardRecommend(rSet.getInt("freeboard_recommend"));
				 * freeBoard.setFreeboardDelete(rSet.getString("freeboard_delete"));
				 * freeBoard.setFreeboardRefile(rSet.getString("freeboard_refile"));
				 */
				tipboardList.add(tipBoard);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}

		return tipboardList;
	}

	public ArrayList<Faq> selectFAQList(Connection conn, int currentPage, int pageList) {
		ArrayList<Faq> faqList = new ArrayList<>();
		PreparedStatement pstat = null;
		ResultSet rSet = null;

		int startCount = (currentPage - 1) * pageList + 1;
		int endCount = currentPage * pageList;

		StringBuffer query = new StringBuffer();
		query.append("select b.rnum, b.faq_no, b.manager_id, b.faq_title, b.faq_content, b.faq_date ")
				.append("from ( select rownum as rnum, a.faq_no, a.manager_id, a.faq_title, a.faq_content, a.faq_date ")
				.append("from ( select faq_no, manager_id, faq_title, faq_content, faq_date ")
				.append("from faq order by faq_date) a ").append("where rownum <= ?) b ")
				.append("where b.rnum >= ?");
		try {
			pstat = conn.prepareStatement(query.toString());
			pstat.setInt(1, endCount);
			pstat.setInt(2, startCount);
			rSet = pstat.executeQuery();

			while (rSet.next()) {
				Faq faq = new Faq();
				faq.setFaqTitle(rSet.getString("faq_title"));
				faq.setManagerId(rSet.getString("manager_id"));
				faq.setFaqNo(rSet.getInt("faq_no"));
				faq.setFaqContent(rSet.getString("faq_content"));
				faq.setFaqDate(rSet.getDate("faq_date"));
				
				faqList.add(faq);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}

		return faqList;
	}
}
