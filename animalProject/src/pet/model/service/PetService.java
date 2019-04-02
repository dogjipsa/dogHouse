package pet.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import pet.model.dao.PetDao;
import pet.model.vo.Pet;
import pet.model.vo.SubInfo;

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


	public Pet selectPet(String userId) {
		Connection conn = getConnection();
		Pet pet = pdao.selectPet(conn, userId);
		close(conn);
		return pet;
  }
	public int updatePet(Pet pet) {
		Connection conn = getConnection();
		int result = pdao.updatePet(conn, pet);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public int deletePet(int pno) {
		Connection conn = getConnection();
		int result = pdao.deletePet(conn, pno);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;

	}


	public Pet findPetInfo(String petSitterId) {
		Connection conn = getConnection();
		Pet pet = pdao.findPetInfo(conn, petSitterId);
		System.out.println("강아지 정보 확인 중(서비스) : " + pet);
		close(conn);
		return pet;
  }
		

	public SubInfo selectOnePet(String userid, int pno) {
		Connection conn = getConnection();
		SubInfo sub = pdao.selectOnePet(conn, userid, pno);
		close(conn);
		return sub;
	}

}
