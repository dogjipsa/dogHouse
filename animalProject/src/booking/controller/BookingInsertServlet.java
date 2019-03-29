package booking.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import booking.model.service.BookingService;
import booking.model.vo.Booking;

/**
 * Servlet implementation class BookingInsertServlet
 */
@WebServlet("/bkinsert")
public class BookingInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookingInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(request.getParameter("datetimes"));
		
		Booking booking = new Booking();
		String[] date = request.getParameter("datetimes").split(" - ");
		String checkin = date[0];
		String checkout = date[1];
		String petSitterId = request.getParameter("petSitterId");
		String userId = request.getParameter("userId");
		String etc = request.getParameter("etc");
		String service = request.getParameter("service");
		System.out.println(petSitterId);
		System.out.println(userId);
		System.out.println(etc);
		System.out.println("insert 서블릿에서 서비스확인 : "+service);
		
		
		/*Timestamp checkinTime = Timestamp.valueOf(checkin);
		Timestamp checkoutTime = Timestamp.valueOf(checkout);
		System.out.println(checkinTime);
		*/
		int result = new BookingService().insertBooking(checkin,checkout,petSitterId,userId,etc,service);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
