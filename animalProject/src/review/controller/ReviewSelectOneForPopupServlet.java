package review.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import review.model.service.ReviewService;
import review.model.vo.Review;

/**
 * Servlet implementation class ReviewSelectOneForPopupServlet
 */
@WebServlet("/creview")
public class ReviewSelectOneForPopupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewSelectOneForPopupServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		Review r = new ReviewService().selectOneReview(bno); 
		if(r != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
			JSONObject json = new JSONObject();
			json.put("rno", r.getReviewNo());
			json.put("userid", r.getUserId());
			json.put("bno", r.getBookingNo());
			json.put("point", r.getPoint());
			json.put("content", URLEncoder.encode(r.getReviewContent(), "utf-8"));
			if(r.getReviewOriginFile() != null) {
			json.put("origin", r.getReviewOriginFile());
			json.put("refile", r.getReviewReFile());
			}
			json.put("rdate", sdf.format(r.getReviewDate()));
			
			response.setContentType("application/json; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.append(json.toJSONString());
			out.flush();
			out.close();
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
