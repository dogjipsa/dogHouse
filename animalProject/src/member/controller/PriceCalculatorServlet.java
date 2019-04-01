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
		String[] date = request.getParameter("datetimes").split(" - ");
		String checkin = date[0];
		String checkout = date[1];
		int dates = new BookingService().selectDates(checkin,checkout);
		int priceSum = (dates+1)*price;
		JSONObject job = new JSONObject();
		job.put("pricesum", priceSum);
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
