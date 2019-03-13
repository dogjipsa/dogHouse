package member.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import member.model.vo.Member;

public class MemberDao {

	public Member selectLogin(Connection conn, String userId, String userPwd) {
			Member loginUser = null;
			PreparedStatement pstmt = null;
			ResultSet rset = null;
			
			String query = "select * from member "
					+ "where user_id = ? and user_pwd = ?";
			
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

	
	public int selectCheckId(Connection conn, String userId) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select count(userid) from member "
				+ "where user_id = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt(1);
			}
			System.out.println("result : " + result);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return result;
	}

	
	public int insertMember(Connection conn, Member member) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "insert into member "
				+ "values (?, ?, ?, ?, ?, ?, ?, ?, ?, "
				+ "?, sysdate)";
		
		try {
			pstmt = conn.prepareStatement(query);
					
			pstmt.setString(1, member.getUserId());
			pstmt.setString(2, member.getUserPwd());
			pstmt.setString(3, member.getUserName());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getPhone());
			pstmt.setString(6, member.getAddress());
			pstmt.setString(7, member.getJob());
			pstmt.setString(8, member.getPetSitter());
			pstmt.setInt(9, member.getPrice());
			pstmt.setDate(10, member.getUserDate());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}


	public Member selectMember(Connection conn, String userId) {
		Member member = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from member "
					+ "where user_id = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
						
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				member = new Member();
				
				member.setUserId(userId);
				member.setUserPwd(rset.getString("userpwd"));
				member.setUserName(rset.getString("userName"));
				member.setEmail(rset.getString("email"));
				member.setPhone(rset.getString("phone"));
				member.setAddress(rset.getString("address"));
				member.setJob(rset.getString("job"));
				member.setPetSitter(rset.getString("petSitter"));
				member.setPrice(rset.getInt("price"));
				member.setUserDate(rset.getDate("userDate"));
								
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return member;
	}


	public int updateMember(Connection conn, Member member) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update member "
				+ "set user_pwd = ?, email = ?, phone = ?, address = ?, "
				+ "job = ?, petsitter = ?, price = ? where user_id = ?";
		
		try {
			pstmt = conn.prepareStatement(query);	

			pstmt.setString(1, member.getUserPwd());
			pstmt.setString(2, member.getEmail());
			pstmt.setString(3, member.getPhone());
			pstmt.setString(4, member.getAddress());
			pstmt.setString(5, member.getJob());
			pstmt.setString(6, member.getPetSitter());
			pstmt.setInt(7, member.getPrice());
			pstmt.setString(8, member.getUserId());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}


	public int deleteMember(Connection conn, String userId) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update user_delete set user_delete = 'Y' where user_id = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}


	public ArrayList<Member> selectList(Connection conn) {
		ArrayList<Member> list = new ArrayList<Member>();
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select * from member";
		
		try {
			stmt = conn.createStatement();		
			rset = stmt.executeQuery(query);
			
			while(rset.next()) {
				Member member = new Member();
				
				member.setUserId(rset.getString("userId"));
				member.setUserPwd(rset.getString("userpwd"));
				member.setUserName(rset.getString("userName"));
				member.setEmail(rset.getString("email"));
				member.setPhone(rset.getString("phone"));
				member.setAddress(rset.getString("address"));
				member.setJob(rset.getString("job"));
				member.setPetSitter(rset.getString("petSitter"));
				member.setPrice(rset.getInt("price"));
				member.setUserDate(rset.getDate("userDate"));		
				
				list.add(member);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(stmt);
		}
		
		return list;
	}
	
	
}
