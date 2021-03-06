package review.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import member.model.vo.Member;
import review.model.dao.ReviewDao;
import review.model.vo.Review;
import tipboard.model.vo.TipBoard;

public class ReviewService {

	private ReviewDao rdao = new ReviewDao();
	
	public ReviewService() {}
	
	public int getListCount(String petSitterId) {
		Connection conn = getConnection();
		int listCount = rdao.getListCount(conn, petSitterId);
		close(conn);
		return listCount;
	}

	public ArrayList<Review> selectList(int currentPage, int limit, String petSitterId) {
		Connection conn = getConnection();
		ArrayList<Review> list = rdao.selectList(conn, currentPage, limit, petSitterId);
		close(conn);
		return list;
	}

	public int insertReview(Review review) {
		Connection conn = getConnection();
		int result = rdao.insertReview(conn, review);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public int deleteReview(int bno) {
		Connection conn = getConnection();
		int result = rdao.deleteReview(conn, bno);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}

	public double selectStarAvg(String petSitterId) {
		Connection conn = getConnection();
		double startAvg = rdao.selectStartAvg(conn, petSitterId);
		close(conn);
		return startAvg;
	}


	public Review selectOneReview(int bno) {
		Connection conn = getConnection();
		Review r = rdao.selectOneReview(conn, bno);
		close(conn);
		return r;
	}

	public int updateReview(String content, String point, int rno) {
		Connection conn = getConnection();
		int result = rdao.updateReview(conn, content, point, rno);
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		return result;
	}
	
}
