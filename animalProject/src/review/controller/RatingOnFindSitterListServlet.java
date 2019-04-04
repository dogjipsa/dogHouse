package review.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sun.org.glassfish.external.statistics.impl.StatsImpl;

import review.model.service.ReviewService;
import review.model.vo.Review;

/**
 * Servlet implementation class RatingOnFindSitterListServlet
 */
@WebServlet("/ronlist")
public class RatingOnFindSitterListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RatingOnFindSitterListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] sitterId = request.getParameterValues("petsitterid");

		String petSitterId = null;
		
		JSONObject job = new JSONObject();
		JSONObject sendJson = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		PrintWriter out = response.getWriter();

		if (sitterId.length != 0) {
			int[] count = new int[sitterId.length];
			double[] rating = new double[sitterId.length];

			for (int y = 0; y < sitterId.length; y++) {
				// System.out.println("아이디 확인 : " + sitterId[y]);
				count = new int[sitterId.length];
				rating = new double[sitterId.length];

				count[y] = new ReviewService().getStarCount(sitterId[y]); // 펫시터별 후기 개수
				rating[y] = new ReviewService().selectStarAvg(sitterId[y]); // 펫시터별 후기 평점


				job.put("count"+y, count[y]);
				job.put("rating"+y, rating[y]);
				System.out.println(sitterId[y] + "님의 count : " + count[y]);
				System.out.println(sitterId[y] + "님의 Rating : " + rating[y]);	

			}
			System.out.println("확인2 : " + job.toJSONString()); // 배열에 덮어씌여짐
			out.println(job.toJSONString());
		}
				
		//요청한 클라이언트쪽으로 json 객체 전송함
		response.setContentType("application/json; charset=utf-8");

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
