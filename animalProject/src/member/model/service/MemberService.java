package member.model.service;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import member.model.dao.MemberDao;
import member.model.vo.Member;

import member.model.vo.SitterImage;


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

	public int insertSitterImages(ArrayList<SitterImage> list) {
		Connection conn = getConnection();
	      int result = mdao.insertSitterImages(conn, list);
	      if(result > 0)
	         commit(conn);
	      else
	         rollback(conn);
	      close(conn);
	      return result;

	}

	public Member reconfrimPassword(String userId) {
		Connection conn = getConnection();
		Member loginUser = mdao.reconfirmPassword(conn, userId);
		close(conn);
		return loginUser;
	}

	public int deleteMember(String userId, String deleteId) {
		Connection conn = getConnection();
		int result = mdao.deleteMember(conn, userId, deleteId);
		System.out.println("service result : " + result);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}


	public Member selectDetailPetSitter(String petSitterId) {
		Connection conn = getConnection();
		Member petSitter = mdao.selectDetailPetSitter(conn, petSitterId);
		close(conn);
		
		return petSitter;
}

	public int updateMember(Member member) {
		Connection conn = getConnection();
		int result = mdao.updateMember(conn, member);
		System.out.println("서비스 : " + result);
		if(result > 0) 
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}


	public ArrayList<SitterImage> selectSitterFacilityImg(String petSitterId) {
		Connection conn = getConnection();
		ArrayList<SitterImage> list = mdao.selectSitterFacilityImg(conn, petSitterId);
		close(conn);
		return list;
  }

	/*public SearchingInfo findPetsitterList(String jido) {
		Connection conn = getConnection();
		SearchingInfo SI = mdao.findPetSitterList(conn, jido);
		System.out.println("서비스단 펫시터 리스트 : " + SI);
		close(conn);
		return SI;
	}*/

	public ArrayList<Member> findPetSitterList(HashMap<String, Object> map) {
		Connection conn = getConnection();
		ArrayList<Member> list = mdao.findPetSitterList(conn, map);
		System.out.println("service petsitter list : " + list);
		close(conn);
		return list;
		

	}
	
	public ArrayList<SitterImage> selectSitterFacilityImg(HashMap<String, Object> img) {
		Connection conn = getConnection();
		ArrayList<SitterImage> list = mdao.selectSitterFacilityImg(conn, img);
		close(conn);
		return list;
  }

	public int countPetSitter(HashMap<String, Object> map) {
		Connection conn = getConnection();
		int result = mdao.countPetSitter(conn, map);
		System.out.println("서비스 : " + result);
		if(result > 0) 
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}
}
