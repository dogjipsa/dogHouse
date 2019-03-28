package manager.model.service;

import manager.model.dao.ManagerDao;
import manager.model.vo.Manager;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

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

	public ArrayList<FreeBoard> selectAllBoardList(int pageNumber) {
		Connection conn = getConnection();
		ArrayList<FreeBoard> managerList = manDao.selectAllBoardList(conn, pageNumber);
		/*System.out.println(managerList + "<- service");*/
		
		close(conn);
		return managerList;
	}
}
