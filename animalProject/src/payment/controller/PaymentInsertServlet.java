package payment.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import booking.model.service.BookingService;
import booking.model.vo.Booking;
import payment.model.service.PaymentService;
import payment.model.vo.Payment;

/**
 * Servlet implementation class PaymentInsertServlet
 */
@WebServlet("/pay")
public class PaymentInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaymentInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 결제 로그 삽입 컨트롤러
		int bookingNo = Integer.parseInt(request.getParameter("bno"));
		String pMethod = request.getParameter("pmethod");
		
		int result = new PaymentService().insertPayment(bookingNo, pMethod);

		response.setContentType("text/html; charset=utf-8");
		
		if (result > 0) { // 성공
			response.sendRedirect("/doggybeta/index.jsp");
		} else { // 실패
			RequestDispatcher view = request.getRequestDispatcher("views/payment/paymentError.jsp"); 
			request.setAttribute("message", "결제 실패");
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
