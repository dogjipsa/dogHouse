package pet.model.service;

import pet.model.dao.PetDao;
import pet.model.vo.Pet;
import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import payment.model.vo.Payment;
public class PetService {
	
	private PetDao pdao = new PetDao(); 

	public int myPetInsert(Pet p) {
		Connection conn = getConnection();
		int result = pdao.myPetInsert(conn, p);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public int myPetUpdate(Pet p) {
		Connection conn = getConnection();
		int result = pdao.myPetUpdate(conn, p);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public int myPetDelete(int pno) {
		Connection conn = getConnection();
		int result = pdao.myPetDelete(conn, pno);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public ArrayList<Pet> myPetListSelect(String userid) {
		Connection conn = getConnection();
		ArrayList<Pet> list = pdao.myPetListSelect(conn, userid);
		close(conn);
		return list;	
	}
}
