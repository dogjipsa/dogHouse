package review.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import booking.model.service.BookingService;
import review.model.service.ReviewService;
import review.model.vo.Review;

/**
 * Servlet implementation class ReviewInsertServlet
 */
@WebServlet("/rinsert")
public class ReviewInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Review review = new Review();
		review.setReviewContent(request.getParameter("reviewcontent").replace("\r\n","<br>"));
		review.setPoint(request.getParameter("star-input"));
		review.setUserId(request.getParameter("userid"));
		review.setBookingNo(Integer.parseInt(request.getParameter("bookingno")));
		int result = new ReviewService().insertReview(review);
		if(result <=0) {
			RequestDispatcher view = request.getRequestDispatcher("views/review/reviewError.jsp");
			request.setAttribute("message", "리뷰 등록 실패");
			view.forward(request, response);
		}
		result = new BookingService().updateBookingStatusFour(review.getBookingNo());
		if(result>0) {
			response.sendRedirect("views/review/close.jsp");
		}else {
			RequestDispatcher view = request.getRequestDispatcher("views/review/reviewError.jsp");
			request.setAttribute("message", "리뷰 수정 실패");
			view.forward(request, response);
		}
		//후기작성이 완료 되면 "등록되었습니다" alert 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
