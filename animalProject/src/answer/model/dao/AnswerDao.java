package answer.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import answer.model.vo.Answer;
import question.model.vo.Question;

public class AnswerDao {

	public AnswerDao() {}
	
	public int insertAnswer(Connection conn, Answer answer) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "insert into answer values (seq_ANSWER.nextval, ?, sysdate)";
		//insert into answer values ((select question_no from question where question_no = ?), ?, sysdate)
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, answer.getAnswerNo());
			pstmt.setString(2, answer.getAnswerContent());
			pstmt.setDate(3, answer.getAnswerDate());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	public Answer selectAnswer(Connection conn, int questionNo) {
		Answer answer = new Answer();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from answer where QUESTION_NO = ?";
		System.out.println("dao 에서 questionno학인  : " + questionNo);
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, questionNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				answer.setAnswerNo(rset.getInt("QUESTION_NO"));
				answer.setAnswerContent(rset.getString("REPLY_CONTENT"));
				answer.setAnswerDate(rset.getDate("REPLY_DATE"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}
		System.out.println("dao에서 answer 확인 : " + answer);
		return answer;
	}
	
}
