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
		System.out.println("loginUser : " + loginUser);
		close(conn);
		
		return loginUser;
	}
	
	public Member loginNaverMember(String userid, String email) {
		Connection conn = getConnection();
		System.out.println(userid +"=service="+email);
		Member loginUser = mdao.loginNaverCheck(conn, userid, email);
		System.out.println("loginUser : " + loginUser);
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

	public int updateTempPassword(Member member) {
		Connection conn = getConnection();
		int result = mdao.updateTempPassword(conn, member);
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
	
	public int selectCheckId(String userId) {
		Connection conn = getConnection();
		int result = mdao.selectCheckId(conn, userId);
		close(conn);
		return result;
	}

	public int updatePassword(Member member) {
		Connection conn = getConnection();
		int result = mdao.updateTempPassword(conn, member);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}
	
	public int updateHost(Member m) {
	      Connection conn = getConnection();
	      int result = mdao.updateHost(conn, m);
	      if(result > 0)
	         commit(conn);
	      else
	         rollback(conn);
	      close(conn);
	      return result;
	 }
	public int selectCheckNaverCode(String naverCode) {
		Connection conn = getConnection();
		int result = mdao.selectCheckNaverCode(conn, naverCode);
		close(conn);
		return result;
	}

	public int updateNaverMember(Member member) {
		Connection conn = getConnection();
		int result = mdao.updateNaverMember(conn, member);
		System.out.println("naver update sv : " + result);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}
	

}
