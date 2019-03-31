package question.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import question.model.dao.QuestionDao;
import question.model.vo.Question;

public class QuestionDao {
	public QuestionDao() {}
	
	public int getListCount(Connection conn) {
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from question";
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
			if (rset.next()) {
				listCount = rset.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(stmt);
		}
		return listCount;
	}
	
	public ArrayList<Question> selectList(Connection conn) {
		ArrayList<Question> list = new ArrayList<Question>();
		Statement stmt = null;
		ResultSet rset = null;		
	      
	    String query = "SELECT * from question order by question_no desc";
	      
	      try {
	         stmt = conn.createStatement();	         
	         rset = stmt.executeQuery(query);
	         
	         while(rset.next()) {
	            Question question = new Question();
	            
	            question.setQuestionNo(rset.getInt("question_no"));
	            question.setQuestionTitle(rset.getString("question_title"));
	            question.setQuestionContent(rset.getString("question_content"));
	            question.setQuestionDate(rset.getDate("question_date"));
	            question.setQuestionReplyYn(rset.getString("reply_yn"));
	            question.setUserId(rset.getString("user_id"));
	            question.setQuestionOriginalFileName(rset.getString("question_original_fileName"));
	            question.setQuestionRenameFileName(rset.getString("question_rename_fileName"));
	            question.setQuestionRef(rset.getInt("question_ref"));
	            question.setQuestionReplyRef(rset.getInt("question_reply_ref"));
	            question.setQuestionReplyLev(rset.getInt("question_reply_lev"));
	            question.setQuestionReplySeq(rset.getInt("question_reply_seq"));
	            	       	            
	            list.add(question);
	         }
     	         
	      } catch (Exception e) {
	         e.printStackTrace();
	      }finally {
	    	 close(rset);
	    	 close(stmt);		    	 
	      }
	      
	      return list;
		
	}

	public Question selectQuestion(Connection conn, int questionNo) {
		Question question = new Question();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from question where question_no =?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, questionNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				question.setQuestionNo(rset.getInt("question_no"));
	            question.setQuestionTitle(rset.getString("question_title"));
	            question.setQuestionContent(rset.getString("question_content"));
	            question.setQuestionDate(rset.getDate("question_date"));
	            question.setQuestionReplyYn(rset.getString("reply_yn"));
	            question.setUserId(rset.getString("user_id"));
	            question.setQuestionOriginalFileName(rset.getString("question_original_fileName"));
	            question.setQuestionRenameFileName(rset.getString("question_rename_fileName"));
	            question.setQuestionRef(rset.getInt("question_ref"));
	            question.setQuestionReplyRef(rset.getInt("question_reply_ref"));
	            question.setQuestionReplyLev(rset.getInt("question_reply_lev"));
	            question.setQuestionReplySeq(rset.getInt("question_reply_seq"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}
		return question;
	}
	
	public int insertQuestion(Connection conn, Question question) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "insert into question values (seq_QUESTIONno.nextval, ?, ?, sysdate, 'n', 'user01', ?, ?, seq_QUESTIONno.nextval, 0, 0, 0)";
		
		try {
			pstmt = conn.prepareStatement(query);
			/*pstmt.setInt(1, question.getQuestionNo());*/
			pstmt.setString(1, question.getQuestionTitle());			
			pstmt.setString(2, question.getQuestionContent());
			/*pstmt.setString(3, question.getQuestionReplyYn());*/
			/*pstmt.setString(4, question.getUserId());*/
			pstmt.setString(3, question.getQuestionOriginalFileName());
			pstmt.setString(4, question.getQuestionRenameFileName());			
			/*pstmt.setInt(8, question.getQuestionRef());*/
			/*pstmt.setInt(5, question.getQuestionReplyRef());*/
			/*pstmt.setInt(6, question.getQuestionReplyLev());*/
			/*pstmt.setInt(7, question.getQuestionReplySeq());*/
			
			result = pstmt.executeUpdate();			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}	
	
	public int updateReplySeq(Connection conn, Question replyQuestion) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update question set question_reply_seq = question_reply_seq + 1 where question_ref = ? and question_reply_lev = ? and question_reply_ref = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, replyQuestion.getQuestionRef());
			pstmt.setInt(2, replyQuestion.getQuestionReplyLev());
			pstmt.setInt(3, replyQuestion.getQuestionReplyRef());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}	

	public int insertReply(Connection conn, Question replyQuestion) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = null;
		
		if(replyQuestion.getQuestionReplyLev() == 1) {
			query = "insert into question values ((select max(question_no) + 1 from question), ?, ?, ?, null, null, ?, (select max(question_no) + 1 from question), 1, ?, default, default)";
		}
		
		if(replyQuestion.getQuestionReplyLev() == 2) {
			query = "insert into question values ((select max(question_no) + 1 from question), ?, ?, ?, null, null, ?, ?, 2, ?, default, default)";
		}
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, replyQuestion.getUserId());
			pstmt.setString(2, replyQuestion.getQuestionTitle());
			pstmt.setString(3, replyQuestion.getQuestionContent());
			pstmt.setInt(4, replyQuestion.getQuestionRef());
			if(replyQuestion.getQuestionReplyLev() == 1) {
				pstmt.setInt(5, replyQuestion.getQuestionReplySeq());
			}
				
			if(replyQuestion.getQuestionReplyLev() == 2) {
				pstmt.setInt(5, replyQuestion.getQuestionReplyRef());
				pstmt.setInt(6, replyQuestion.getQuestionReplySeq());
			}		
			
			result = pstmt.executeUpdate();			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}		
	
	public int updateReply(Connection conn, Question question) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update qustion set question_title = ?, question_content = ? where question_no =?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, question.getQuestionTitle());
			pstmt.setString(2, question.getQuestionContent());
			pstmt.setInt(3, question.getQuestionNo());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result; 
	}
	
	public int updateQuestion(Connection conn, Question question) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update question set question_title = ?, question_content = ? where question_no = ?";				
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, question.getQuestionTitle());
			pstmt.setString(2, question.getQuestionContent());
			pstmt.setInt(3, question.getQuestionNo());
			/*pstmt.setString(3, question.getUserId());*/
			
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	
	public int deleteQuestion(Connection conn, int questionNo) {
		int result = 0;
		
		PreparedStatement pstmt = null;
		String query = "delete from question where question_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, questionNo);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	
}
	
	
	
	

