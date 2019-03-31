package payment.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import booking.model.service.BookingService;
import booking.model.vo.Booking;
import member.model.service.MemberService;
import member.model.vo.Member;
import pet.model.service.PetService;
import pet.model.vo.Pet;

/**
 * Servlet implementation class BeforePaymentSelectServlet
 */
@WebServlet("/bpselect")
public class BeforePaymentSelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BeforePaymentSelectServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bookingNo = Integer.parseInt(request.getParameter("bookingNo"));
		String priceSum = request.getParameter("priceSum");
		System.out.println("before서블릿에서 가격 확인 : " + priceSum);
		System.out.println("before에서 bookingno 확인 : "+bookingNo);
		//예약정보
		Booking booking = new BookingService().selectBooking(bookingNo);//예약정보 조회 해옴
		System.out.println("예약 정보 : "+booking);
		String petSitterId = booking.getPuserId();
		System.out.println("예약 펫시터 : "+petSitterId);
		String userId = booking.getUserId();
		//예약한 유저의 펫정보
		System.out.println("예약한 유저의 아이디 : "+userId);
		Pet pet =  new PetService().selectPet(userId);
		System.out.println("예약한 유저의 펫정보 : "+pet);
		
		//회원정보
		Member member = new MemberService().selectDetailMember(userId);//userId에 해당하는 정보 조회
		System.out.println("예약한 유저의 정보 : "+member);
		
		//펫시터정보
		Member petSitter = new MemberService().selectDetailPetSitter(petSitterId);
		System.out.println("예약한 펫시터의 정보 : "+petSitter);
		
		
		
		
		RequestDispatcher view = null;
		view = request.getRequestDispatcher("views/findSitter/beforePayment.jsp");
		request.setAttribute("booking", booking);
		request.setAttribute("member", member);
		request.setAttribute("pet", pet);
		request.setAttribute("petSitter", petSitter);
		request.setAttribute("priceSum", priceSum);
		view.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
