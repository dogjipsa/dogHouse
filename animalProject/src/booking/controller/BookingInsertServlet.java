package booking.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
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
		
		//Booking booking = new Booking();
		BookingService bkservice = new BookingService(); 
		String[] date = request.getParameter("datetimes").split(" - ");
		String checkin = date[0];
		String checkout = date[1];
		String petSitterId = request.getParameter("petSitterId");
		String userId = request.getParameter("userId");
		String etc = request.getParameter("etc");
		String service = request.getParameter("service");
		String priceSum = request.getParameter("priceSum");
		//***신청하는 사람이 checkin checkout 가 사이에 날짜에 booking이 있다면 예약 신청 못하게 해야 함.
		
		System.out.println(petSitterId);
		System.out.println(userId);
		System.out.println(etc);
		System.out.println("insert 서블릿에서 서비스확인 : "+service);
		System.out.println("가격 : " + priceSum);
		
		
		/*Timestamp checkinTime = Timestamp.valueOf(checkin);
		Timestamp checkoutTime = Timestamp.valueOf(checkout);
		System.out.println(checkinTime);
		*/
		
		//1. booking(예약)을 함(insert)
		bkservice.insertBooking(checkin,checkout,petSitterId,userId,etc,service);
		
		//2. 결제 직전 페이지에 booking내용을 조회하기 위해 booking테이블에서 booking_no를 select(이 booking_no를 bpselect로 넘겨줌)
		int bookingNo = bkservice.selectBookingNo(checkin,checkout,petSitterId,userId);
		System.out.println("예약번호조회 : " + bookingNo);
		
		//3. 예약진행상황(booking_progress)를 1(예약완료)로 업데이트
		int result = bkservice.updateBookingProgressOne(bookingNo);
		
		if(result>0) {
			response.sendRedirect("/doggybeta/bpselect?bookingNo="+bookingNo+"&priceSum="+priceSum);//BeforePaymentSelectServlet으로 예약번호 전달
		}else {
			System.out.println("booking insert 실패");
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
