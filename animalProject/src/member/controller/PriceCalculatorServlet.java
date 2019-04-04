package member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import booking.model.service.BookingService;
import member.model.service.MemberService;

/**
 * Servlet implementation class PriceCalculatorServlet
 */
@WebServlet("/priceCal")
public class PriceCalculatorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PriceCalculatorServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//String date = request.getParameter("datetimes");
		//System.out.println("ajax 확인 : "+date);
		int price = Integer.parseInt(request.getParameter("price"));
		/*String service = request.getParameter("service");
		if(service.equals("0")||service.equals("2")) {
			price = (int) ((price*0.8)/1000) *1000;
		}
		System.out.println("서비스 체크 : " + service);
		System.out.println("가격체크 : " + price);*/
		System.out.println("서비스체크 : " + request.getParameter("selectservice"));
		String selectedService = request.getParameter("selectservice");
		String check = "";
		if(selectedService.equals("펫시터 집에 맡기기")) {
			check = "1";
		}else {
			check = "2";
		}
		String[] date = request.getParameter("datetimes").split(" - ");
		String checkin = date[0];
		String checkout = date[1];
		int dates = new BookingService().selectDates(checkin,checkout);
		String service = "";
		String dateStr = " (당일)";
		if(dates == 0 && check.equals("1")) {
			price = (int) ((price*0.8)/1000) *1000;
			service = "펫시터에게 맡기기";
		}else if(check.equals("1")){
			service = "펫시터에게 맡기기";
			dateStr = " ("+dates+"박"+(dates+1)+" 일)";
		}else if(dates == 0 && check.equals("2")) {
			service = "펫시터 우리집으로 부르기";
		}else if(check.equals("2")) {
			service = "펫시터 우리집으로 부르기";
			dateStr = " ("+dates+"박"+(dates+1)+" 일)";
		}
		int priceSum = (dates+1)*price;
		JSONObject job = new JSONObject();
		job.put("pricesum", priceSum);
		job.put("service", service);
		job.put("dateStr", dateStr);
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
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
