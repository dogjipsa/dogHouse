package review.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import review.model.service.ReviewService;
import review.model.vo.Review;

/**
 * Servlet implementation class ReviewListViewServlet
 */
@WebServlet("/rlist")
public class ReviewListViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewListViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//현재 페이지를 넘겨 받아야 할듯?
		//현재 detailview에서 petsitterid를 넘겨받아야 함.
		String petSitterId = request.getParameter("petSitterId");
		ReviewService rservice = new ReviewService();
		System.out.println("리뷰조회를 위한 펫 아이디 : " + petSitterId);
		
		System.out.println("테스트 페이지 : " + request.getParameter("currentPage"));
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			//currentPage = Integer.parseInt(request.getParameter("currentPage"));
			
		}
		
		int limit = 10;
		int listCount = rservice.getListCount(petSitterId);
		System.out.println("리뷰조회를 위한 listCount : " + listCount);
		int maxPage = (int)((double)listCount / limit + 0.9);
		
		int startPage = (((int)((double)currentPage / limit + 0.9)) - 1)* limit + 1;
		int endPage = startPage + limit - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		response.setContentType("text/html; charset=utf-8");
		ArrayList<Review> list = rservice.selectList(currentPage, limit);
		System.out.println("리뷰에서 list 확인 : "+list);
		
		JSONObject sendjson = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		
		for(Review review :  list) {
			
			JSONObject reviewJson = new JSONObject();
			reviewJson.put("reviewno", review.getReviewNo());
			reviewJson.put("userid", review.getUserId());
			reviewJson.put("bookingno", review.getBookingNo());
			reviewJson.put("point", review.getPoint());
			reviewJson.put("reviewcontent", URLEncoder.encode(review.getReviewContent(), "UTF-8"));
			reviewJson.put("revieworiginal", review.getReviewOriginFile());
			reviewJson.put("reviewre", review.getReviewReFile());
			reviewJson.put("reviewdate", String.valueOf(review.getReviewDate()));
			
			jsonArr.add(reviewJson);
		}
		
		sendjson.put("list", jsonArr);
		sendjson.put("listCount", listCount);
		sendjson.put("startPage", startPage);
		sendjson.put("endPage", endPage);
		sendjson.put("maxPage", maxPage);
		sendjson.put("currentPage", currentPage);
		

		System.out.println("리뷰 리스트 서블릿에서 제이슨 테스트 : " + sendjson.toJSONString());
		
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(sendjson.toJSONString());
		out.flush();
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
