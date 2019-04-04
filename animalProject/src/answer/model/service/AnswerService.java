package answer.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;

import answer.model.dao.AnswerDao;
import answer.model.vo.Answer;
import question.model.vo.Question;

public class AnswerService {
	
	private AnswerDao ansdao = new AnswerDao();
	
	public AnswerService() {}

	public int insertAnswer(int qboardNo, String anscontent) {
		Connection conn = getConnection();
		int result = ansdao.insertAnswer(conn, qboardNo, anscontent);
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public Answer selectAnswer(int questionNo) {
		Connection conn = getConnection();
		Answer answer = ansdao.selectAnswer(conn, questionNo);
		close(conn);
		return answer;
	}

	
}
