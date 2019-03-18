package pet.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import payment.model.vo.Payment;
import pet.model.vo.Pet;

public class PetDao {

	public int myPetInsert(Connection conn, Pet p) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query="insert into pet values(?,?,?,?,?,?,?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, p.getPetNo());
			pstmt.setString(2, p.getPetName());
			pstmt.setString(3, p.getPetBreads());
			pstmt.setString(4, p.getPetDate());
			pstmt.setString(5, p.getPetSize());
			pstmt.setString(6, p.getPetGender());
			pstmt.setString(7, p.getPetNeutralize());
			pstmt.setString(8, p.getPetCharater());
			pstmt.setString(9, p.getUserId());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int myPetUpdate(Connection conn, Pet p) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query="UPDATE PET SET PET_NAME = ?, PET_BREADS = ?, PET_DATE = ?, PET_SIZE = ?, PET_GENDER = ? PET_NEUTRALIZE = ? PET_CHARATER = ? WHERE PET_NO = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, p.getPetName());
			pstmt.setString(2, p.getPetBreads());
			pstmt.setString(3, p.getPetDate());
			pstmt.setString(4, p.getPetSize());
			pstmt.setString(5, p.getPetGender());
			pstmt.setString(6, p.getPetNeutralize());
			pstmt.setString(7, p.getPetCharater());
			pstmt.setInt(8, p.getPetNo());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int myPetDelete(Connection conn, int pno) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query="DELETE FROM PET WHERE PET_NO = ?";
		
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

	public ArrayList<Pet> myPetListSelect(Connection conn, String userid) {
		ArrayList<Pet> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "SELECT * FROM PET WHERE USER_ID = ?";
	/*	PET_NO	NUMBER
		PET_NAME	VARCHAR2(100 BYTE)
		PET_BREADS	VARCHAR2(100 BYTE)
		PET_DATE	VARCHAR2(100 BYTE)
		PET_SIZE	VARCHAR2(100 BYTE)
		PET_GENDER	VARCHAR2(100 BYTE)
		PET_NEUTRALIZE	VARCHAR2(100 BYTE)
		PET_CHARATER	VARCHAR2(100 BYTE)
		USER_ID	VARCHAR2(100 BYTE)*/
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userid);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Pet p = new Pet();
				p.setPetNo(rset.getInt(1));
				p.setPetName(rset.getString(2));
				p.setPetBreads(rset.getString(3));
				p.setPetDate(rset.getString(4));
				p.setPetSize(rset.getString(5));
				p.setPetGender(rset.getString(6));
				p.setPetNeutralize(rset.getString(7));
				p.setPetCharater(rset.getString(8));
				p.setUserId(userid);
				list.add(p);
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
