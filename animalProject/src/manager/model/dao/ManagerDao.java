package manager.model.dao;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import freeboard.model.vo.FreeBoard;
import manager.model.vo.Manager;

public class ManagerDao {

	public ManagerDao() {}

	public Manager loginManager(Connection conn, String managerId, String managerPwd) {
		//관리자 로그인 시 조회용
		Manager loginManager = null;
		PreparedStatement pstat = null;
		ResultSet rSet = null;
		
		String query = "select * from manager where manager_id = ? and manager_password = ?";
		
		try {
			pstat = conn.prepareStatement(query);
			pstat.setString(1, managerId);
			pstat.setString(2, managerPwd);
			rSet = pstat.executeQuery();
			
			if(rSet.next()) {
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

	public ArrayList<FreeBoard> selectAllBoardList(Connection conn, int pageNumber) {
		// 게시판 목록 조회용
		// 일단 자유게시판 하나만 실험
		ArrayList<FreeBoard> managerList = new ArrayList<> ();
		PreparedStatement pstat = null;
		ResultSet rSet = null;
		StringBuffer query = new StringBuffer();
		query.append("select * from freeboard where freeboard_views > ");
		query.append("(select MAX(freeboard_views) from freeboard) - ? and  freeboard_views <= ");
		query.append("(select MAX(freeboard_views) from freeboard) - ? order by freeboard_views");
		query.append("desc, seq_freeboardno asc");
		/*query.append("select * from freeboard where boardGroup > ");
		query.append("(select MAX(boardGroup) from freeboard) - ? and  boardGroup <= ");
		query.append("(select MAX(boardGroup) from freeboard) - ? order by boardGroup");
		query.append("desc, seq_freeboardno asc");*/
		try {
			pstat = conn.prepareStatement(query.toString());
			/*pstat.setInt(1, Integer.parseInt(pageNumber) * 10);
			pstat.setInt(2, Integer.parseInt(pageNumber) * -1);*/
			pstat.setInt(1, pageNumber * 10);
			pstat.setInt(2, (pageNumber * 10) -1);
			//한 페이지당 10개까지만 출력되게
			rSet = pstat.executeQuery();
			
			while(rSet.next()) {
				FreeBoard freeBoard = new FreeBoard();
				freeBoard.setFreeboardNo(rSet.getInt("freeboard_no"));
				freeBoard.setFreeboardTitle(rSet.getString("freeboard_title"));
				freeBoard.setFreeboardContent(rSet.getString("freeboard_content"));
				freeBoard.setFreeboardDate(rSet.getDate("freeboard_date"));
				freeBoard.setFreeboardOriginalFile(rSet.getString("freeboard_originfile"));
				freeBoard.setFreeboardViews(rSet.getInt("freeboard_views"));
				freeBoard.setFreeboardRecommend(rSet.getInt("freeboard_recommend"));
				freeBoard.setUserId(rSet.getString("user_id"));
				freeBoard.setFreeboardDelete(rSet.getString("freeboard_delete"));
				freeBoard.setFreeboardRefile(rSet.getString("freeboard_refile"));
			 /*System.out.println(managerList + "<- list dao");*/
				managerList.add(freeBoard);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}

		return managerList;
	}
	
	public boolean nextPage(String pageNumber) {
		Connection conn = getConnection();
		PreparedStatement pstat = null;
		ResultSet rSet = null;
		/*String query = "select * from freeboard where boardGroup >= ? ";*/
		String query = "select * from freeboard where freeboard_views >= ? ";
		
		try {
			pstat = conn.prepareStatement(query);
			pstat.setInt(1, Integer.parseInt(pageNumber) * 10);
			rSet = pstat.executeQuery();
			
			if(rSet.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}
		
		return false;
	}
	public int targetPage(int pageNumber) {
		Connection conn = getConnection();
		PreparedStatement pstat = null;
		ResultSet rSet = null;
		String query = "select count(*) from freeboard_views where freeboard_views >= ? ";
		
		try {
			pstat = conn.prepareStatement(query);
			/*pstat.setInt(1, (Integer.parseInt(pageNumber)-1) * 10);*/
			pstat.setInt(1, (pageNumber -1) * 10);
			rSet = pstat.executeQuery();
			
			if(rSet.next()) {
				return rSet.getInt(1) / 10;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}
		
		return 0;
	}
}
