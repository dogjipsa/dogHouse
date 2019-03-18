package report.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pet.model.service.PetService;
import pet.model.vo.Pet;
import report.model.service.ReportService;
import report.model.vo.Report;

/**
 * Servlet implementation class ReportInsertServlet
 */
@WebServlet("/ReportInsertServlet")
public class ReportInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		Report r = new Report();
		r.setReportNo(Integer.parseInt(request.getParameter("rno")));
		r.setReportContent(request.getParameter("rcontent"));
		r.setReportCategory(request.getParameter("rcategory"));
		r.setBoardNo(Integer.parseInt(request.getParameter("bno")));
		r.setUserId(request.getParameter("userid"));
		
		int result = new ReportService().reportInsert(r);

		response.setContentType("text/html; charset=utf-8");
		
		if (result > 0) { // 성공
			response.sendRedirect("/doggybeta/index.jsp");
		} else { // 실패
			RequestDispatcher view = request.getRequestDispatcher("views/report/reportError.jsp"); 
			request.setAttribute("message", "신고 신청 실패");
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
