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
		

		JSONObject j = new JSONObject();
		if(sitterId != null) {
			
			ArrayList<Integer> iList = new ArrayList<> ();
			Integer[] count = new Integer[sitterId.length];
		if(sitterId.length > 0){
			for(int x=0; x<sitterId.length;x++){
				
				System.out.println("아이디 확인 : " + sitterId[x]);
				/*petSitterId = sitterId[x];*/
				System.out.println("아이디확인 : " + petSitterId);
				
				
				double[] rating = new double[sitterId.length];
		

				count[x] = new ReviewService().getStarCount(sitterId[x]); //펫시터별 후기 개수
				iList.toArray(count);
				rating[x] = new ReviewService().selectStarAvg(sitterId[x]); //펫시터별 후기 평점
				
				System.out.println("count : ["+x+"]" + count[x]);
				System.out.println("Rating : ["+x+"]" + rating[x]);
				
				//job.put("count", count);
				/*job.put("rating"+x, rating[x]);*/
				System.out.println("확인1 : " + job.toJSONString()); //배열에 덮어씌여짐
				
				/*jsonArr.add(job);*/
				/*jsonArr.add(job);
				
				System.out.println("확인2 : " + jsonArr.toJSONString());*/
			}// for문 끝
			for(Integer i : iList) {
				job.put("count", i);
			}
			/*JSONObject jo = new JSONObject();
			Map<String, Integer> attributes = new HashMap<String, Integer>();
			Set<Entry<String, Integer>> entrySet = job.entrySet();
			for(Map.Entry<String,Integer> entry : entrySet){
				attributes.put(entry.getKey(), entry.getValue());
				System.out.println("엔트리셋맵 : " + entry.getKey());
				System.out.println("엔트리셋맵1: "+ entry.getValue());

				jo.put(entry.getKey(), entry.getValue());
			}*/
			
			

			/*sendJson.put("list", jsonArr);*/
			System.out.println("최종 job : " + job.toJSONString()); 
			out.println(job.toJSONString());	
			}		
		}
		
		

		//job.put("count", String.valueOf(count[]));
		//job.put("avg", String.valueOf(rating));
		
		
		//요청한 클라이언트쪽으로 json 객체 전송함
		response.setContentType("application/json; charset=utf-8");
		
		/*out.println(job.toJSONString());*/
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
