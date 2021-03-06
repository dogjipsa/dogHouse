package pet.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import static common.JDBCTemplate.*;

import pet.model.vo.Pet;
import pet.model.vo.SubInfo;

public class PetDao {

	public int insertPet(Connection conn, Pet pet) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "INSERT INTO PET VALUES(SEQ_PETNO.NEXTVAL, ?,?,?,?,?,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, pet.getPetName());
			pstmt.setString(2, pet.getBreeds());
			pstmt.setDate(3, pet.getPetDate());
			pstmt.setString(4, pet.getPetSize());
			pstmt.setString(5, pet.getPetGender());
			pstmt.setString(6, pet.getPetNeutralize());
			pstmt.setString(7, pet.getPetCharater());
			pstmt.setString(8, pet.getUserId());
			pstmt.setString(9, pet.getOriginFileName());
			pstmt.setString(10, pet.getRenameFileName());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int getTotalPetListCount(Connection conn, String userid) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "SELECT COUNT(*) FROM PET WHERE USER_ID = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userid);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				count = rset.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return count;
	}

	public ArrayList<Pet> selectPetList(Connection conn, String userid, int start, int end) {
		ArrayList<Pet> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "SELECT X.RNUM, X.PET_NO, X.PET_NAME, X.PET_BREADS, X.PET_DATE, X.PET_SIZE, X.PET_GENDER, X.PET_NEUTRALIZE, X.PET_CHARATER, X.USER_ID, X.PET_ORIGINFILE, X.PET_REFILE FROM (SELECT ROWNUM AS RNUM, P.PET_NO, P.PET_NAME, P.PET_BREADS, P.PET_DATE, P.PET_SIZE, P.PET_GENDER, P.PET_NEUTRALIZE, P.PET_CHARATER, P.USER_ID, P.PET_ORIGINFILE, P.PET_REFILE FROM (SELECT PET_NO, PET_NAME, PET_BREADS, PET_DATE, PET_SIZE, PET_GENDER, PET_NEUTRALIZE, PET_CHARATER, USER_ID, PET_ORIGINFILE, PET_REFILE FROM PET WHERE USER_ID = ? ORDER BY PET_NO) P WHERE ROWNUM <= ?) X WHERE X.RNUM >= ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userid);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Pet pet = new Pet();
				pet.setPetNo(rset.getInt(2));
				pet.setPetName(rset.getString(3));
				pet.setBreeds(rset.getString(4));
				pet.setPetDate(rset.getDate(5));
				pet.setPetSize(rset.getString(6));
				pet.setPetGender(rset.getString(7));
				pet.setPetNeutralize(rset.getString(8));
				pet.setPetCharater(rset.getString(9));
				pet.setUserId(rset.getString(10));
				pet.setOriginFileName(rset.getString(11));
				pet.setRenameFileName(rset.getString(12));
				
				list.add(pet);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}



	public Pet selectPet(Connection conn, String userId) {
		Pet pet = new Pet();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select * from pet where user_id = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			
			rset = pstmt.executeQuery();
			if(rset.next()) {
				pet.setPetNo(rset.getInt("PET_NO"));
				pet.setPetName(rset.getString("PET_NAME"));
				pet.setBreeds(rset.getString("PET_BREADS"));
				pet.setPetDate(rset.getDate("PET_DATE"));
				pet.setPetSize(rset.getString("PET_SIZE"));
				pet.setPetGender(rset.getString("PET_GENDER"));
				pet.setPetNeutralize(rset.getString("PET_NEUTRALIZE"));
				pet.setPetCharater(rset.getString("PET_CHARATER"));
				pet.setUserId(userId);
				pet.setOriginFileName(rset.getString("PET_ORIGINFILE"));
				pet.setRenameFileName(rset.getString("PET_REFILE"));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return pet;
	}
	
	

	public int updatePet(Connection conn, Pet pet) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "UPDATE PET SET PET_NAME =?, PET_BREADS =?, PET_DATE =?, PET_SIZE = ?, PET_GENDER =? , PET_NEUTRALIZE = ?, PET_CHARATER = ?, USER_ID =?, PET_ORIGINFILE =?, PET_REFILE = ? WHERE PET_NO = ? ";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, pet.getPetName());
			pstmt.setString(2, pet.getBreeds());
			pstmt.setDate(3, pet.getPetDate());
			pstmt.setString(4, pet.getPetSize());
			pstmt.setString(5, pet.getPetGender());
			pstmt.setString(6, pet.getPetNeutralize());
			pstmt.setString(7, pet.getPetCharater());
			pstmt.setString(8, pet.getUserId());
			pstmt.setString(9, pet.getOriginFileName());
			pstmt.setString(10, pet.getRenameFileName());
			pstmt.setInt(11, pet.getPetNo());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int deletePet(Connection conn, int pno) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "DELETE PET WHERE PET_NO = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, pno);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public SubInfo selectOnePet(Connection conn, String userid, int pno) {
		SubInfo sub = new SubInfo();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "SELECT P.PET_NAME, P.PET_BREADS, P.PET_DATE, M.PHONE, P.PET_REFILE FROM PET P JOIN MEMBER M ON(P.USER_ID = M.USER_ID) WHERE P.USER_ID = ? AND P.PET_NO = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userid);
			pstmt.setInt(2, pno);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				sub.setPetName(rset.getString(1));
				sub.setBreeds(rset.getString(2));
				sub.setPetDate(rset.getDate(3));
				sub.setPhone(rset.getString(4));
				sub.setRenameFileName(rset.getString(5));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return sub;
	}

	public ArrayList<Pet> selectPetAllList(Connection conn, String userid) {
		ArrayList<Pet> list = new ArrayList<>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select * from pet where user_id = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userid);
			
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Pet pet = new Pet();
				pet.setPetNo(rset.getInt("PET_NO"));
				pet.setPetName(rset.getString("PET_NAME"));
				pet.setBreeds(rset.getString("PET_BREADS"));
				pet.setPetDate(rset.getDate("PET_DATE"));
				pet.setPetSize(rset.getString("PET_SIZE"));
				pet.setPetGender(rset.getString("PET_GENDER"));
				pet.setPetNeutralize(rset.getString("PET_NEUTRALIZE"));
				pet.setPetCharater(rset.getString("PET_CHARATER"));
				pet.setUserId(userid);
				pet.setOriginFileName(rset.getString("PET_ORIGINFILE"));
				pet.setRenameFileName(rset.getString("PET_REFILE"));
				list.add(pet);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}


}
