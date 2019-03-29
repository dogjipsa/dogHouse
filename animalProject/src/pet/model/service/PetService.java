package pet.model.service;

import java.sql.Connection;

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

}
