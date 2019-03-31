package pet.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import static common.JDBCTemplate.*;

import pet.model.vo.Pet;

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

	

}
