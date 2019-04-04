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
	
	public int insertAnswer(Connection conn, int qboardNo, String anscontent) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "insert into answer values (?, ?, SYSDATE)";
		updateReply(conn, qboardNo);
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, qboardNo);
			pstmt.setString(2, anscontent);

			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}	
	
	private void updateReply(Connection conn, int qboardNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update question set reply_yn = '답변완료' where question_no = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, qboardNo);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
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
		return answer;
	}
	
}
