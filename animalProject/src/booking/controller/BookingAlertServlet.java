package booking.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import booking.model.service.BookingService;
import booking.model.vo.Booking;

/**
 * Servlet implementation class BookingAlertServlet
 */
@WebServlet("/balert")
public class BookingAlertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookingAlertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//메뉴에서 petsitterid 값 받음
		String puserid = request.getParameter("puserid");
		System.out.println("로그인 유저 확인 : " + puserid);
		JSONObject sendJson = new JSONObject();
		
		int bookingCount = new BookingService().bookingCount(puserid);
		
		ArrayList<Booking> list = new BookingService().bookingAlert(puserid);
		
		
		System.out.println("booking data 건수 확인 : " + bookingCount);
		
		sendJson.put("count", String.valueOf(bookingCount));
		
		PrintWriter out = response.getWriter();
		//JSONArray jsonArr = new JSONArray();
		

		
/*		for(Booking bk : list) {
			JSONObject job = new JSONObject();
			
			job.put("userid", bk.getUserId());
			job.put("bookingprogress", bk.getBookingProgress());
			job.put("puserid", bk.getPuserId());
			job.put("bookingno", bk.getBookingNo());
			
			jsonArr.add(job);
		}
		
		sendJson.put("list", jsonArr);
*/
		
		if(bookingCount < 1) {
			System.out.println("값 없음");
		}else {
			System.out.println("job : " + sendJson.toJSONString());
		}
		
		response.setContentType("application/json; charset=utf-8");
		
		System.out.println("job : " + sendJson.toJSONString());
		
		out.println(sendJson.toJSONString());
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
