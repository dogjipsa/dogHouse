package review.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import review.model.service.ReviewService;
import review.model.vo.Review;

/**
 * Servlet implementation class ReviewAllListViewServlet
 */
@WebServlet("/ralllist")
public class ReviewAllListViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewAllListViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String petSitterId = request.getParameter("puserid");
		int currentPage = 1;
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
			
		}
		ReviewService rservice = new ReviewService();
		int limit = 10;
		int listCount = rservice.getListCount(petSitterId);
		int maxPage = (int)((double)listCount / limit + 0.9);
		
		int startPage = (((int)((double)currentPage / limit + 0.9)) - 1)* limit + 1;
		int endPage = startPage + limit - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		ArrayList<Review> list = rservice.selectList(currentPage, limit, petSitterId);
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(list.size() >= 0) {//size가 0이어도 조회되어야한다고 생각함 else 삭제해야 할듯
			view = request.getRequestDispatcher("views/review/reviewListView.jsp");
			
			request.setAttribute("list", list);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("listCount", listCount);
			request.setAttribute("puserid", petSitterId);
			
			//추가된거
											
			view.forward(request, response);
		}else {
			view = request.getRequestDispatcher(
					"views/review/reviewError.jsp");
			request.setAttribute("message", currentPage + "에 대한 목록 조회 실패!");
			view.forward(request, response);
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
