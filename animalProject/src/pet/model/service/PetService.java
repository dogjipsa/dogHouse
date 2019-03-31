package pet.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import pet.model.dao.PetDao;
import pet.model.vo.Pet;
import static common.JDBCTemplate.*;

public class PetService {
	
	private PetDao pdao = new PetDao(); 
	
	public int insertPet(Pet pet) {
		Connection conn = getConnection();
		int result = pdao.insertPet(conn, pet);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public int getTotalPetListCount(String userid) {
		Connection conn = getConnection();
		int count = pdao.getTotalPetListCount(conn, userid);
		close(conn);
		return count;
	}

	public ArrayList<Pet> selectPetList(String userid, int start, int end) {
		Connection conn = getConnection();
		ArrayList<Pet> list = pdao.selectPetList(conn, userid, start, end);
		close(conn);
		return list;
	}

}
