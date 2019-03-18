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
import payment.model.service.PaymentService;

/**
 * Servlet implementation class PaymentDetailServlet
 */
@WebServlet("/payd")
public class PaymentDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaymentDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 결제내역 리스트 화면에서 상세보기 화면 출력하는 컨트롤러
		int bookingNo = Integer.parseInt(request.getParameter("bno"));
		
		// 예약 테이블 조회
		Booking b = new PaymentService().selectBooking(bookingNo);
		RequestDispatcher view = null;
		if(b != null) {
			view = request.getRequestDispatcher("views/payment/paymentDetailView.jsp");
			request.setAttribute("booking", b);
			view.forward(request, response);
		} else {
			view = request.getRequestDispatcher("views/payment/paymentError.jsp");
			request.setAttribute("message", "상세 조회 실패하였습니다.");
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
