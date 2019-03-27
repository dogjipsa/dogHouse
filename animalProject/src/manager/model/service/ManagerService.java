package manager.model.service;

import manager.model.dao.ManagerDao;
import manager.model.vo.Manager;

import static common.JDBCTemplate.*;

import java.sql.Connection;

public class ManagerService {
	private ManagerDao manDao = new ManagerDao();
	
	public ManagerService() {}

	public Manager loginManager(String managerId, String managerPwd) {
		//관리자 로그인 처리
		Connection conn = getConnection();
		Manager loginManager = manDao.loginManager(conn, managerId, managerPwd);
		close(conn);
		
		return loginManager;
	}
}
