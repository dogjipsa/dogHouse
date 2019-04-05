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
import pet.model.vo.Pet;

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
		//혹시라도 애완견의 이름을 같게 할 사람들을 위해 펫을 구별할 뷰에서 이름, 성별, 견종 펫정보 넘겨받음
		String[] petStr = request.getParameter("mypet").split(" ");
		//총가격 xxx원 구분
		String[] priceArr = request.getParameter("priceSum").split(" ");
		
		Pet pet = new Pet();
		pet.setPetName(petStr[0]);
		pet.setBreeds(petStr[1]);
		pet.setPetGender(petStr[2]);
		
		Booking booking = new Booking();
		BookingService bkservice = new BookingService(); 
		//체크인 날짜와 체크아웃 날짜 구분
		String[] date = request.getParameter("datetimes").split(" - ");
		String checkin = date[0];
		String checkout = date[1];
		String petSitterId = request.getParameter("petSitterId");
		String userId = request.getParameter("userId");
		String etc = request.getParameter("etc");
		String service = request.getParameter("servicekind");
		int priceSum = Integer.parseInt(priceArr[0]);
		
		//***신청하는 사람이 checkin checkout 가 사이에 날짜에 booking이 있다면 예약 신청 못하게 해야 함.
		
		booking.setBookingEtc(etc);
		booking.setServiceKind(service);
		booking.setPuserId(petSitterId);
		booking.setUserId(userId);
		booking.setPrice(priceSum);
		
		/*Timestamp checkinTime = Timestamp.valueOf(checkin);
		Timestamp checkoutTime = Timestamp.valueOf(checkout);
		System.out.println(checkinTime);
		*/
		
		//1. booking(예약)을 함(insert) booking_progress는 1(펫시터의 승인대기 상태)로 insert
		int result = bkservice.insertBooking(checkin,checkout,pet,booking);
		
		//2. 결제 직전 페이지에 booking내용을 조회하기 위해 booking테이블에서 booking_no를 select(이 booking_no를 bpselect로 넘겨줌)
		int bookingNo = bkservice.selectBookingNo(checkin,checkout,petSitterId,userId);
		
		
		
		if(result>0) {
			//response.sendRedirect("/doggybeta/bpselect?bookingNo="+bookingNo+"&priceSum="+priceSum);//BeforePaymentSelectServlet으로 예약번호 전달
			response.sendRedirect("views/customerservice/checkMyLog.jsp");
		}else {
			RequestDispatcher view = request.getRequestDispatcher("views/findSitter/findSitterError.jsp");
			request.setAttribute("message", "예약을 실패하였습니다. 같은 문제가 반복되면 관리자에게 문의 바랍니다.");
			view.forward(request, response);
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
