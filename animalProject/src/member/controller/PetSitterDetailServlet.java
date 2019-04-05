package member.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import booking.model.service.BookingService;
import booking.model.vo.Booking;
import booking.model.vo.BookingCheckDate;
import member.model.service.MemberService;
import member.model.vo.Member;
import member.model.vo.SitterImage;
import review.model.service.ReviewService;

/**
 * Servlet implementation class PetSitterDetailServlet
 */
@WebServlet("/sitterdetail")
public class PetSitterDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PetSitterDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//petSitterListView.jsp에서 펫시터의 저장된 정보를 받아옴
		String petSitterId = request.getParameter("petSitterId");
		//펫시터의 이름, 나이, 프로필사진, 가격정보, 펫시터 소개 를 조회해서 Member객체에 저장
		Member petSitter = new MemberService().selectDetailPetSitter(petSitterId);
		//펫시터의 시설사진을 조회해서 ArrayList에 저장
		ArrayList<SitterImage> sitterFacilityImg = new MemberService().selectSitterFacilityImg(petSitterId);
		response.setContentType("text/html; charset=utf-8");
		//펫시터의 평균 별점을 조회 해서 double형 데이터 starAvg에 저장
		double starAvg = new ReviewService().selectStarAvg(petSitterId);
		//결제까지 완료된 예약 날짜를 daterangepicker에서 선택하지 못하도록 checkin날짜와 checkout날짜를 조회해옴
		ArrayList<BookingCheckDate> checkDateList = new BookingService().selectCheckDate(petSitterId);
		/*System.out.println("데이트 확인 : " + checkDateList);
		int checkDateCount = new BookingService().selectCheckDateCount(petSitterId);
		int[] eachCount = new int[checkDateCount];
		
		System.out.println("갯수 확인 : " + checkDateCount);
		String[] checkIn = new String[checkDateCount];
		String[] checkOut = new String[checkDateCount];
		int[] bookingNo = new int[checkDateCount];
		for(int i=0; i<checkDateCount; i++) {
			checkIn[i] = checkDateList.get(i).getCheckInDate();
			checkOut[i] =checkDateList.get(i).getCheckOutDate();
			bookingNo[i] = checkDateList.get(i).getBookingNo();
			eachCount[i] = new BookingService().selectEachCount(bookingNo[i],checkIn[i],checkOut[i],petSitterId);	
			
			System.out.println(checkIn[i] + checkOut[i]+bookingNo[i]);
			System.out.println(eachCount[i]);
			
		}*/
		
		
		
		
		RequestDispatcher view = null;
		view = request.getRequestDispatcher("views/findSitter/petSitterDetailView.jsp");
		request.setAttribute("petSitter", petSitter);
		request.setAttribute("sitterFacilityImg", sitterFacilityImg);
		request.setAttribute("starAvg", starAvg);
		request.setAttribute("checkDate", checkDateList);
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
