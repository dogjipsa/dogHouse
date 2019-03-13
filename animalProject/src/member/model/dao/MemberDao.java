package member.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import member.model.vo.Member;

public class MemberDao {

	public Member selectLogin(Connection conn, String userId, String userPwd) {
			Member loginUser = null;
			PreparedStatement pstmt = null;
			ResultSet rset = null;
			
			String query = "select * from member "
					+ "where userid = ? and userpwd = ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, userId);
				pstmt.setString(2, userPwd);
				
				rset = pstmt.executeQuery();
				
				if(rset.next()) {
					loginUser = new Member();
									
					loginUser.setUserId(userId);
					loginUser.setUserPwd(userPwd);
					loginUser.setUserName(rset.getString("userName"));
					loginUser.setEmail(rset.getString("email"));
					loginUser.setPhone(rset.getString("phone"));
					loginUser.setAddress(rset.getString("address"));
					loginUser.setJob(rset.getString("job"));
					loginUser.setPetSitter(rset.getString("petSitter"));
					loginUser.setPrice(rset.getInt("price"));
					loginUser.setUserDate(rset.getDate("userDate"));
					
					
									
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rset);
				close(pstmt);
			}
			
			return loginUser;
	}

}
