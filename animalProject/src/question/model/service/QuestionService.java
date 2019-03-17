package question.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;

import question.model.dao.*;
import question.model.vo.*;

public class QuestionService {

	private QuestionDao qdao = new QuestionDao();
	
	public QuestionService() {}
	
	public int insertQuestion(Question question){
		Connection conn = getConnection();
		int result = qdao.insertQuetion(conn, question);
		return null;
	}

	public int deleteQuestion(Question question) {
		Connection conn = getConnection();
		int result = qdao.deleteQuestion(conn, question);
		return null;
	}
	
	public void updateQuestion(Question question) {
		Connection conn = getConnection();
		int result = qdao.updateQuestion(conn, question);
	}
	
	public ArrayList<Question> selectList(String userid){
		Connection conn = getConnection();
		ArrayList<Question> qlist = qdao.selectList(conn, userid);
		return null;
	}
	
	
	
}
