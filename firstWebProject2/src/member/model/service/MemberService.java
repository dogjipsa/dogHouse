package member.model.service;

import member.model.dao.MemberDao;
import member.model.vo.Member;
import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

public class MemberService {
	private MemberDao mdao = new MemberDao();
	
	public MemberService() {}

	public Member selectLogin(String userid, String userpwd) {
		Connection conn = getConnection();
		Member loginUser = mdao.selectLogin(conn, userid, userpwd);
		close(conn);
		return loginUser;
	}

	public int selectCheckid(String userid) {
			Connection conn = getConnection();
			int result = mdao.selectCheckid(conn, userid);
			close(conn);
			return result;
	}


	public int insertMember(Member member) {
		Connection conn = getConnection();
		int result = mdao.insertMember(conn, member);
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public Member selectMember(String userid) {
		Connection conn = getConnection();
		Member member = mdao.selectMember(conn, userid);
		close(conn);
		return member;
	}

	public int updateMember(Member member) {
		Connection conn = getConnection();
		int result = mdao.updateMember(conn, member);
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public int deleteMember(String userid) {
		Connection conn = getConnection();
		int result = mdao.deleteMember(conn, userid);
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public ArrayList<Member> selectList() {
		Connection conn = getConnection();
		ArrayList<Member> list = mdao.selectList(conn);
		close(conn);
		return list;
	}

}
