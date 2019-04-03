package review.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		String []sitterId = request.getParameterValues("petsitterid");
		String petSitterId = null;
		if(sitterId.length > 0){
			for(int x=0; x<sitterId.length;x++){
				
				System.out.println("아이디 확인 : " + sitterId[x]);
				petSitterId = sitterId[x];
				
			
			}
		}
		System.out.println("아이디들 나열 : " + petSitterId);
		JSONObject job = new JSONObject();
		PrintWriter out = response.getWriter();
		
		int count= new ReviewService().getListCount(petSitterId);
		
		System.out.println("건 수 확인용 : " + count);
		
		double rating = new ReviewService().selectStarAvg(petSitterId);
		
		System.out.println("총 평점 확인용 : " + rating);
		
		//job.put("count", String.valueOf(count));
		//job.put("avg", String.valueOf(rating));
		
		System.out.println("job : " + job.toJSONString()); 
		//요청한 클라이언트쪽으로 json 객체 전송함
		response.setContentType("application/json; charset=utf-8");
		
		out.println(job.toJSONString());
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
