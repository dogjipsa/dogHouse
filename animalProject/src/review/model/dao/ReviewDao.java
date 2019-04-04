package review.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import review.model.vo.Review;
import tipboard.model.vo.TipBoard;

public class ReviewDao {

	public int getListCount(Connection conn, String petSitterId) {
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "select count(*) from review where booking_no in (select booking_no from booking where puser_id= ?)";

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, petSitterId);
			rset = pstmt.executeQuery();

			if (rset.next()) {
				listCount = rset.getInt(1);
			}
			System.out.println(petSitterId + "님의 후기 개수 : ");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return listCount;
	}

	public ArrayList<Review> selectList(Connection conn, int currentPage, int limit, String petSitterId) {
		ArrayList<Review> list = new ArrayList<Review>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		//해당 페이지에 출력할 목록의 시작행과 끝행 계산
		int startRow = (currentPage -1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		String query = "SELECT *  FROM (SELECT ROWNUM RNUM,  REVIEW_NO,USER_ID,BOOKING_NO,POINT,REVIEW_CONTENT,REVIEW_ORIGINFILE,REVIEW_REFILE,review_date " + 
				"				FROM (SELECT * FROM REVIEW where booking_no in (select booking_no from booking where puser_id = ?) order by REVIEW_NO desc)) " + 
				"				WHERE RNUM >= ? AND RNUM <= ? ";
		
		try {
			
				
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, petSitterId);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
				rset = pstmt.executeQuery();
				while(rset.next()) {
					Review review = new Review();
					review.setReviewNo(rset.getInt("review_no"));
					review.setUserId(rset.getString("user_id"));
					review.setBookingNo(rset.getInt("booking_no"));
					review.setPoint(rset.getString("point"));
					review.setReviewContent(rset.getString("REVIEW_CONTENT"));
					review.setReviewOriginFile(rset.getString("REVIEW_ORIGINFILE"));
					review.setReviewReFile(rset.getString("REVIEW_REFILE"));
					review.setReviewDate(rset.getDate("review_date"));
					list.add(review);
				}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int insertReview(Connection conn, Review review) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "insert into review values(seq_reviewno.nextval, (select user_id from booking where booking_no = ?), ?, ?, ?, null, null, default)";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, review.getBookingNo());
			pstmt.setInt(2, review.getBookingNo());
			pstmt.setString(3, review.getPoint());
			pstmt.setString(4, review.getReviewContent());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int deleteReview(Connection conn, int bno) {
		int result = 0;
			
		PreparedStatement pstmt = null;
		String query = "DELETE REVIEW WHERE BOOKING_NO = ?";
		try {
			int result2 = updateProgress(conn, bno);
			if(result2 > 0) {
				System.out.println("update progressing..");
			}
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	private int updateProgress(Connection conn, int bno) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE BOOKING SET BOOKING_PROGRESS = '3' WHERE BOOKING_NO = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
			close(pstmt);
		}
		return result;
	}

	public double selectStartAvg(Connection conn, String petSitterId) {
		double starAvg = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select trunc(avg(point),1) from review where booking_no in(select booking_no from booking where puser_id = ?)";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, petSitterId);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				starAvg = rset.getDouble(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(rset);
		}
		return starAvg;
	}

	public int getStarCount(Connection conn, String petSitterId) {
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "select count(*) from review where booking_no in (select booking_no from booking where puser_id= ?)";

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, petSitterId);
			rset = pstmt.executeQuery();

			if (rset.next()) {
				listCount = rset.getInt(1);
			}
			System.out.println(petSitterId + "님의 후기 개수 : " + listCount);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return listCount;
		
		
	}

	public Review selectOneReview(Connection conn, int bno) {
		Review r = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "SELECT * FROM REVIEW WHERE BOOKING_NO = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bno);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				r = new Review();
				r.setReviewNo(rset.getInt(1));
				r.setUserId(rset.getString(2));
				r.setBookingNo(bno);
				r.setPoint(rset.getString(4));
				r.setReviewContent(rset.getString(5));
				r.setReviewOriginFile(rset.getString(6));
				r.setReviewReFile(rset.getString(7));
				r.setReviewDate(rset.getDate(8));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return r;
	}

	public int updateReview(Connection conn, String content, String point, int rno) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE REVIEW SET REVIEW_CONTENT = ? , POINT = ? WHERE REVIEW_NO = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, content);
			pstmt.setString(2, point);
			pstmt.setInt(3, rno);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

}
