package member.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import static common.JDBCTemplate.*;
import member.model.vo.Member;

public class MemberDao {
	private StringBuffer query = new StringBuffer();
	public MemberDao () {}

	public Member loginCheck(Connection conn, String userid, String userpwd) {
		// 로그인 확인
		/*ArrayList<Member> loginUser = new ArrayList<> ();*/
		Member member = null;
		PreparedStatement pstat = null;
		ResultSet rSet = null;
		query.append("select * from member where user_id = ? and password = ?");
		/*String query = "select * from member where user_id = ? and password = ?";*/
		System.out.println(userid +", "+userpwd);
		try {
			pstat = conn.prepareStatement(query.toString());
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
				
			}
			System.out.println("member : " + member.toString());
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

	public int insertMember(Connection conn, Member member) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int updateMember(Connection conn, Member member) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int deleteMember(Connection conn, Member member) {
		// 메소드 이름은 delete 지만 update set deleteyn을 'y'로 변경
		return 0;
	}

	public ArrayList<Member> selectAllList(Connection conn) {
		// TODO Auto-generated method stub
		return null;
	}

	public Member selectMember(Connection conn, String userId) {
		// TODO Auto-generated method stub
		return null;
	}

	public int updateHost(Connection conn, Member m) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "update member set petsitter = '1', phone=? , email = ?, address = ? , price = ?, user_originfile = ?, user_refile =? where user_id = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, m.getPhone());
			pstmt.setString(2, m.getEmail());
			pstmt.setString(3, m.getAddress());
			pstmt.setInt(4, m.getPrice());
			pstmt.setString(5, m.getUseroriginfile());
			pstmt.setString(6, m.getUserrefile());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

}
