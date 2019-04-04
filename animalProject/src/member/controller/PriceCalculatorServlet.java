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
		String selectedService = request.getParameter("selectservice");//선택한 서비스 parameter값 받아옴
		String check = "";
		if(selectedService.equals("펫시터 집에 맡기기")) {//펫시터 집에 맡기기면 check는 1로 선언
			check = "1";
		}else {//펫시터를 우리집으로 부르기는 check를 2로 선언
			check = "2";
		}
		String[] date = request.getParameter("datetimes").split(" - ");//checkin, checkout시간 구분을 위해 split
		String checkin = date[0];
		String checkout = date[1];
		int dates = new BookingService().selectDates(checkin,checkout);
		//PetSitterDetailView.jsp 에 보여질 변수 선언, service와 dateStr을 합쳐서 view단에 보여짐
		String service = "";
		String dateStr = " (당일)";
		String serviceKind = "";//예약할 때 db에 입력할 service_kind 변수 선언 
		if(dates == 0 && check.equals("1")) {//펫시터에게 맡기기(당일)
			price = (int) ((price*0.8)/1000) *1000;
			service = "펫시터에게 맡기기";
			serviceKind = "2";
			dates=1;
		}else if(check.equals("1")){//펫시터에게 맡기기(x박 x일)
			service = "펫시터에게 맡기기";
			dateStr = " ("+dates+"박"+(dates+1)+" 일)";
			serviceKind = "3";
		}else if(dates == 0 && check.equals("2")) {//펫시터 우리집으로 부르기(당일)
			price = (int) ((price*0.8)/1000) *1000;
			service = "펫시터 우리집으로 부르기";
			serviceKind = "0";
			dates=1;
		}else if(check.equals("2")) {//펫시터 우리집으로 부르기(x박 x일)
			service = "펫시터 우리집으로 부르기";
			dateStr = " ("+dates+"박"+(dates+1)+" 일)";
			serviceKind = "1";
		}
		int priceSum = (dates)*price;//총 가격 계산
		
		JSONObject job = new JSONObject();
		job.put("pricesum", priceSum);
		job.put("service", service);
		job.put("dateStr", dateStr);
		job.put("servicekind", serviceKind);
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
