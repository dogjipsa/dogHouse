package question.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;

import question.model.dao.QuestionDao;
import question.model.vo.Question;

public class QuestionService {

	private QuestionDao qdao = new QuestionDao();
	
	public QuestionService() {}
	
	public int getListCount() {
		Connection conn = getConnection();
		int listCount = qdao.getListCount(conn);
		close(conn);
		return listCount;
	}
	
	public ArrayList<Question> selectList() {
		Connection conn = getConnection();
		ArrayList<Question> list = qdao.selectList(conn);
		close(conn);
		return list;
	}
	

	public void addReadCount(int questionNo) {
		Connection conn = getConnection();
		int result = qdao.addReadCount(conn, questionNo);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
	}
	

	public Question selectQuestion(int questionNo) {
		Connection conn = getConnection();
		Question question = qdao.selectQuestion(conn, questionNo);
		close(conn);
		return question;
	}
	
	public int insertQuestion(Question question) {
		Connection conn = getConnection();
		int result = qdao.insertQuestion(conn, question);
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		return result;
	}

	public void updateReplySeq(Question replyQuestion) {
		Connection conn = getConnection();
		int result = qdao.updateReplySeq(conn, replyQuestion);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return;
	}

	public int insertReply(Question replyQuestion) {
		Connection conn = getConnection();
		int result = qdao.insertReply(conn, replyQuestion);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public int updateReply(Question question) {
		Connection conn = getConnection();
		int result = qdao.updateReplySeq(conn, question);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}
	
	public int updateQuestion(Question question) {
		Connection conn = getConnection();		
		int result = qdao.updateQuestion(conn, question);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);		
		return result;
	}
	
	public int deleteQuestion(int questionNo) {
		Connection conn = getConnection();
		int result = qdao.deleteQuestion(conn, questionNo);
		
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);		
		return result;
	}
	
}
