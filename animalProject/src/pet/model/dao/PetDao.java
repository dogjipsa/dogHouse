package pet.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import static common.JDBCTemplate.*;

import pet.model.vo.Pet;

public class PetDao {

	public int insertPet(Connection conn, Pet pet) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "INSERT INTO PET VALUES(SEQ_PETNO.NEXTVAL, ?,?,?,?,?,?,?,?,?,?)";
		/*PET_NO	NUMBER
		PET_NAME	VARCHAR2(100 BYTE)
		PET_BREADS	VARCHAR2(100 BYTE)
		PET_DATE	VARCHAR2(100 BYTE)
		PET_SIZE	VARCHAR2(100 BYTE)
		PET_GENDER	VARCHAR2(100 BYTE)
		PET_NEUTRALIZE	VARCHAR2(100 BYTE)
		PET_CHARATER	VARCHAR2(100 BYTE)
		USER_ID	VARCHAR2(100 BYTE)
		PET_ORIGINFILE	VARCHAR2(50 BYTE)
		PET_REFILE	VARCHAR2(50 BYTE)*/
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

}
