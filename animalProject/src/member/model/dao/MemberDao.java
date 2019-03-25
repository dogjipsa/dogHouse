package member.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import static common.JDBCTemplate.*;
import member.model.vo.Member;

public class MemberDao {
	public MemberDao () {}

	public Member loginCheck(Connection conn, String userid, String userpwd) {
		// 로그인 확인
		/*ArrayList<Member> loginUser = new ArrayList<> ();*/
		Member member = null;
		PreparedStatement pstat = null;
		ResultSet rSet = null;
		/*StringBuffer query = new StringBuffer();
		query.append("select * from member where user_id = ? and password = ?");*/
		String query = "select * from member where user_id = ? and password = ?";
		System.out.println(userid +", "+userpwd);
		try {
			pstat = conn.prepareStatement(query);
			pstat.setString(1, userid);
			pstat.setString(2, userpwd);
			rSet = pstat.executeQuery();
			
			if(rSet.next()) {
				member = new Member();
				member.setUserId(userid);
				member.setEmail(rSet.getString("email"));
				member.setUserName(rSet.getString("user_name"));
				member.setAddress(rSet.getString("address"));
				member.setPhone(rSet.getString("phone"));
				member.setJob(rSet.getString("job"));
				member.setPetSitter(rSet.getString("petsitter"));
				member.setPrice(rSet.getInt("price"));
				member.setUserDate(rSet.getDate("user_date"));
				member.setUserPwd(userpwd);
				member.setUserDelete(rSet.getString("user_delete"));
				member.setNaverCode(rSet.getString("NAVER_CODE"));
				System.out.println(member + " <- dao member");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}
		
		return member;
	}

	public int findPassword(Connection conn, Member member) {
		int result = 0;
		PreparedStatement pstat = null;
		ResultSet rSet = null;
		StringBuffer query = new StringBuffer();
		query.append("select count(*) from member where user_id = ? and email = ?");
		
		try {
			pstat = conn.prepareStatement(query.toString());
			pstat.setString(1, member.getUserId());
			pstat.setString(2, member.getEmail());
			
			rSet = pstat.executeQuery();
			if(rSet.next()) {
				result = rSet.getInt(1);
			}
			System.out.println("findPwd result : " + result);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}
		
		return result;
	}

	public int updateTempPassword(Connection conn, Member member) {
		int result = 0;
		PreparedStatement pstat = null;
		StringBuffer query = new StringBuffer();
		query.append("update member set password = ? where user_id = ?");
		try {
			pstat = conn.prepareStatement(query.toString());
			
			pstat.setString(1, member.getUserPwd());
			pstat.setString(2, member.getUserId());
			
			result = pstat.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstat);
		}
		return result;
	}

	public int insertMember(Connection conn, Member member) {
		int result = 0;
		PreparedStatement pstat = null;
		StringBuffer query = new StringBuffer();
		query.append("insert into member values ( ");
		query.append("?,?,?,?,?,?,default,?,sysdate,?,default,?,?,?)");
		
		try {
			
			pstat = conn.prepareStatement(query.toString());
			System.out.println(query.toString());
			pstat.setString(1, member.getUserId());
			pstat.setString(2, member.getEmail());
			pstat.setString(3, member.getUserName());
			pstat.setString(4, member.getAddress());
			pstat.setString(5, member.getPhone());
			pstat.setString(6, member.getJob());
			pstat.setInt(7, member.getPrice());
			pstat.setString(8, member.getUserPwd());
			pstat.setString(9, member.getUseroriginfile());
			pstat.setString(10, member.getUserrefile());
			pstat.setString(11, member.getNaverCode());
			
			result = pstat.executeUpdate();
			System.out.println("DAO : " + result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstat);
		}
		return result;
	}
	
	public int selectCheckId(Connection conn, String userId) {
		int result = 0;
		PreparedStatement pstat = null;
		ResultSet rSet = null;
		StringBuffer query = new StringBuffer();
		query.append("select count(user_id) from member where user_id = ?");
		
		try {
			pstat = conn.prepareStatement(query.toString());
			pstat.setString(1, userId);
			System.out.println(userId);
			
			rSet = pstat.executeQuery();
			
			if(rSet.next()) {
				result = rSet.getInt(1);
			}
			System.out.println(result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}
		
		return result;
	}
	public int updateHost(Connection conn, Member m) {
	      int result = 0;
	      PreparedStatement pstmt = null;
	      String query = "update member set petsitter = '1', phone=? , email = ?, address = ? , price = ?, user_originfile = ?, user_refile =?, user_name = ? where user_id = ?";
	      
	      try {
	         pstmt = conn.prepareStatement(query);
	         pstmt.setString(1, m.getPhone());
	         pstmt.setString(2, m.getEmail());
	         pstmt.setString(3, m.getAddress());
	         pstmt.setInt(4, m.getPrice());
	         pstmt.setString(5, m.getUseroriginfile());
	         pstmt.setString(6, m.getUserrefile());
	         pstmt.setString(7, m.getUserName());
	         pstmt.setString(8, m.getUserId());
	         
	         result = pstmt.executeUpdate();
	      } catch (Exception e) {
	         e.printStackTrace();
	      }finally {
	         close(pstmt);
	      }
	      
	      return result;
	   }
	public int selectCheckNaverCode(Connection conn, String naverCode) {
		int result = 0;
		PreparedStatement pstat = null;
		ResultSet rSet = null;
		StringBuffer query = new StringBuffer();
		query.append("select count(user_id) from member where naver_code = ?");
		
		try {
			pstat = conn.prepareStatement(query.toString());
			pstat.setString(1, naverCode);
			System.out.println(naverCode);
			
			rSet = pstat.executeQuery();
			
			if(rSet.next()) {
				result = rSet.getInt(1);
			}
			System.out.println(result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}
		
		return result;
	}
}
