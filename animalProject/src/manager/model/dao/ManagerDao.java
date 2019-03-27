package manager.model.dao;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
}
