package faq.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import faq.model.service.FaqService;
import faq.model.vo.Faq;

/**
 * Servlet implementation class FaqUpdateServlet
 */
@WebServlet("/fupdate")
public class FaqUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FaqUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 게시글 수정페이지 출력 처리용 컨트롤러
		int faqNum = Integer.parseInt(request.getParameter("fnum"));
		int currentPage = Integer.parseInt(request.getParameter("page"));
				
		Faq faq = new FaqService().selectFaq(faqNum);
				
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(faq != null) {
			view = request.getRequestDispatcher("views/faq/faqUpdateView.jsp");
			request.setAttribute("faq", faq);
			request.setAttribute("page", currentPage);
			view.forward(request, response);
		}else {

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
