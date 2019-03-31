package member.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import static common.JDBCTemplate.*;
import member.model.vo.Member;
import member.model.vo.SitterImage;


public class MemberDao {
	public MemberDao () {}

	public Member loginCheck(Connection conn, String userid, String userpwd) {
		// 일반 유저 로그인 확인
		Member member = null;
		PreparedStatement pstat = null;
		ResultSet rSet = null;

		StringBuffer query = new StringBuffer();
		query.append("select * from member where user_id = ? and password = ?");
		/*System.out.println(userid +", "+userpwd);*/ //값 잘 받는지 확인

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
				member.setNaverCode(rSet.getString("NAVER_CODE"));
				/*System.out.println(member + " <- dao member");*/ //객체 잘 불러오는지 확인용
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}
		
		return member;
	}
	public Member loginNaverCheck(Connection conn, String userid, String token) {
		// 네이버으로 가입한 회원 로그인 확인
		Member member = null;
		PreparedStatement pstat = null;
		ResultSet rSet = null;
		StringBuffer query = new StringBuffer();
		query.append("select * from member where email = ? and naver_code = ?");
		/*System.out.println(userid +", token : "+token);*/ //값 잘 받는지 확인
		try {
			pstat = conn.prepareStatement(query.toString());
			pstat.setString(1, userid);
			pstat.setString(2, token);
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
				member.setUserPwd(rSet.getString("password"));
				member.setUserDelete(rSet.getString("user_delete"));
				member.setNaverCode(token);
				
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
		//비밀번호 찾기
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
	public int selectCheckNaverCode(Connection conn, String email) {
		int result = 0;
		PreparedStatement pstat = null;
		ResultSet rSet = null;
		StringBuffer query = new StringBuffer();
		query.append("select count(user_id) from member where naver_code is not null and email = ?");
		
		try {
			pstat = conn.prepareStatement(query.toString());
			pstat.setString(1, email);
			System.out.println(email);
			
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

	public int updateNaverMember(Connection conn, Member member) {
		//네이버 로그인시 이미 등록되어있는 계정이라면
		int result = 0;
		PreparedStatement pstat = null;
		
		StringBuffer query = new StringBuffer();
		query.append("update member set ");
		query.append("naver_code = ?, user_name = ? ");
		query.append("where user_id = ?");
		try {
			pstat = conn.prepareStatement(query.toString());
			pstat.setString(1, member.getNaverCode());
			pstat.setString(2, member.getUserName());
			pstat.setString(3, member.getUserId());
			
			result = pstat.executeUpdate();
			System.out.println("naver update dao : " + result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstat);
		}
		return result;
	}

	public int insertSitterImages(Connection conn, ArrayList<SitterImage> list) {
		int result = 0;
		PreparedStatement pstmt = null;
		int num = getSitterImagesCount(conn);
		String query = "INSERT ALL ";
		for(int i = 0; i < list.size(); i++) {
			query += "INTO SITTERIMG VALUES ( ?, ?, ?, ? ) ";
		}
		query += " SELECT * FROM DUAL";
		try {
			pstmt = conn.prepareStatement(query);
			int count = 1;
			for(int j = 0; j < list.size(); j++) {
				pstmt.setInt(count++, num++);
				pstmt.setString(count++, list.get(j).getUserId());
				pstmt.setString(count++, list.get(j).getOriginFile());
				pstmt.setString(count++, list.get(j).getRenameFile());
			}
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	private int getSitterImagesCount(Connection conn) {
		int count = 0;
		Statement stmt = null;
		String query = "SELECT COUNT(*) FROM SITTERIMG";
		ResultSet rset = null;
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next()) {
				count = rset.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		return count;

	}

	public Member reconfirmPassword(Connection conn, String userId) {
		Member member = null;
		PreparedStatement pstmt = null;
		ResultSet rSet = null;
		
		String query ="SELECT PASSWORD FROM MEMBER WHERE USER_ID = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			rSet = pstmt.executeQuery();
			
			while(rSet.next()) {				
				member = new Member();
				member.setUserId(userId);

				member.setUserPwd(rSet.getString("password"));


			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstmt);
		}
		return member;
	}

	public int deleteMember(Connection conn, String userId, String deleteId) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "UPDATE MEMBER SET USER_DELETE = 'Y', USER_ID = ? WHERE USER_ID = ?";
		System.out.println("dao 전 result : " + result);
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, deleteId); 
			pstmt.setString(2, userId);
			
			result = pstmt.executeUpdate();
			System.out.println("Dao result : " + result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	

	public int updateMember(Connection conn, Member member) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "UPDATE MEMBER SET EMAIL = ?, PHONE = ?, JOB = ?, PASSWORD = ? WHERE USER_ID = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, member.getEmail());
			pstmt.setString(2, member.getPhone());
			pstmt.setString(3, member.getJob());
			pstmt.setString(4, member.getUserPwd());
			pstmt.setString(5, member.getUserId());
			
			result = pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			close(pstmt);
		}
		
		return result;
	}

	public Member selectDetailPetSitter(Connection conn, String petSitterId) {
		Member petSitter = new Member();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select user_id, user_name, address, phone, price, user_date, user_originfile, user_refile  from member where user_id = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, petSitterId);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				petSitter.setUserId(rset.getString(1));
				petSitter.setUserName(rset.getString(2));
				petSitter.setAddress(rset.getString(3));
				petSitter.setPhone(rset.getString(4));
				petSitter.setPrice(rset.getInt(5));
				petSitter.setUserDate(rset.getDate(6));
				petSitter.setUseroriginfile(rset.getString(7));
				petSitter.setUserrefile(rset.getString(8));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return petSitter;
	}


	public ArrayList<SitterImage> selectSitterFacilityImg(Connection conn, String petSitterId) {
		ArrayList<SitterImage> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select * from sitterimg where user_id = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, petSitterId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				SitterImage sitterImage = new SitterImage();
				sitterImage.setImageNo(rset.getInt("IMG_NO"));
				sitterImage.setUserId(petSitterId);
				sitterImage.setOriginFile(rset.getString("IMG_ORIGINFILE"));
				sitterImage.setRenameFile(rset.getString("IMG_REFILE"));
				list.add(sitterImage);
      }
    }catch (Exception e) {
		e.printStackTrace();
	} finally {
		close(rset);
		close(pstmt);
	}
	return list;
  }
	public ArrayList<Member> findPetSitterList(Connection conn, HashMap<String, Object> map) {
		
		
		ArrayList<Member> list = new ArrayList<Member>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String userId = (String)map.get("userid");
		String jido = (String)map.get("jido");
		String detail = (String)map.get("detail");


		if(detail == null || detail.equals("전체")) {
			jido = (String)map.get("jido");
		}else if(detail != "전체"){
			jido = jido + " " + detail;
		}

		
		String query = "SELECT DISTINCT P.USER_ID, P.USER_NAME, P.PRICE, P.USER_ORIGINFILE, "
				+ "P.USER_REFILE, P.ADDRESS FROM MEMBER P LEFT OUTER JOIN PET Z ON (P.USER_ID = Z.USER_ID) "
				+ "WHERE P.USER_ID NOT IN ? AND P.PETSITTER = '2' AND P.ADDRESS LIKE ?";

		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, userId);
			pstmt.setString(2, "%" + jido + "%");
			rset = pstmt.executeQuery();
			
			
			while(rset.next()) {
				Member findSitter = new Member();
				
				findSitter.setUserId(rset.getString(1));
				findSitter.setUserName(rset.getString(2));
				findSitter.setPrice(rset.getInt(3));
				findSitter.setUseroriginfile(rset.getString(4));
				findSitter.setUserrefile(rset.getString(5));
				findSitter.setAddress(rset.getString(6).substring(0, 9));
						
				list.add(findSitter);
			}
			System.out.println("dao : " + list);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public ArrayList<SitterImage> selectSitterFacilityImg(Connection conn, HashMap<String, Object> img) {
		ArrayList<SitterImage> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String petSitterId = (String)img.get("petSitterId");
		
		String query = "select * from sitterimg where user_id = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, petSitterId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				SitterImage sitterImage = new SitterImage();
				sitterImage.setImageNo(rset.getInt("IMG_NO"));
				sitterImage.setUserId(petSitterId);
				sitterImage.setOriginFile(rset.getString("IMG_ORIGINFILE"));
				sitterImage.setRenameFile(rset.getString("IMG_REFILE"));
				list.add(sitterImage);
      }
    }catch (Exception e) {
		e.printStackTrace();
	} finally {
		close(rset);
		close(pstmt);
	}
	return list;
	}

	public int countPetSitter(Connection conn, HashMap<String, Object> map) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String userId = (String)map.get("userid");
		String jido = (String)map.get("jido");
		String detail = (String)map.get("detail");


		if(detail == null || detail.equals("전체")) {
			jido = (String)map.get("jido");
		}else if(detail != "전체"){
			jido = jido + " " + detail;
		}
		
		String query = "SELECT COUNT(USER_ID) FROM MEMBER WHERE USER_ID NOT IN ? AND PETSITTER = '2' AND ADDRESS LIKE ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, userId);
			pstmt.setString(2, "%" + jido + "%");
	
		
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt(1);
			}
			System.out.println("dao : " + result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return result;
	}

}
