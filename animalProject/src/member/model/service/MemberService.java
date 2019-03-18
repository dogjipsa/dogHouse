package member.model.service;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import member.model.dao.MemberDao;
import member.model.vo.Member;

public class MemberService {
	private MemberDao mdao = new MemberDao();
	
	public MemberService() {}

	public Member loginMember(String userid, String userpwd) {
		Connection conn = getConnection();
		System.out.println(userid +"=service="+userpwd);
		Member loginUser = mdao.loginCheck(conn, userid, userpwd);
		close(conn);
		
		return loginUser;
	}

	public int findPassword(Member member) {
		Connection conn = getConnection();
		int result = mdao.findPassword(conn, member);
		
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		
		return result;
	}

	public int insertMember(Member member) {
		Connection conn = getConnection();
		int result = mdao.insertMember(conn, member);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public int updateMember(Member member) {
		Connection conn = getConnection();
		int result = mdao.updateMember(conn, member);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public int deleteMember(Member member) {
		Connection conn = getConnection();
		int result = mdao.deleteMember(conn, member);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public ArrayList<Member> selectAllList() {
		Connection conn = getConnection();
		ArrayList<Member> list = mdao.selectAllList(conn);
		close(conn);
		return list;
	}

	public Member selectMember(String userId) {
		Connection conn = getConnection();
		Member member = mdao.selectMember(conn, userId);
		close(conn);
		return member;
	}

	

}
