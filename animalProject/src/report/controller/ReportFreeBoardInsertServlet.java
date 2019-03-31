package report.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import report.model.service.ReportService;
import report.model.vo.Report;

/**
 * Servlet implementation class ReportFreeBoardInsertServlet
 */
@WebServlet("/rfinsert")
public class ReportFreeBoardInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportFreeBoardInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String rfwriter = request.getParameter("rfwriter");
		String rfcategory = request.getParameter("rfcategory");
		String rfcontent = request.getParameter("rfcontent");
		int No = Integer.parseInt(request.getParameter("rfboard"));
		
		String rfboard = String.valueOf(No);
		String rfboardS = "20" + rfboard;
		int rfboardNo = Integer.parseInt(rfboardS); 
		
		Report rfreport = new Report();
		
		rfreport.setReportCategory(rfcategory);
		rfreport.setUserId(rfwriter);
		rfreport.setReportContent(rfcontent);
		rfreport.setBoardNo(rfboardNo);
		
		ReportService rservice = new ReportService();
		
		int result = rservice.insertReportFreeBoard(rfreport);
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(result > 0) {
			response.sendRedirect("/doggybeta/fdetail?fnum=" + rfboard);			
		}else {
			view = request.getRequestDispatcher("views/freeboard/freeBoardError.jsp");
			request.setAttribute("message","자유게시판 "  + rfboard + "번 게시글 신고페이지로 이동 실패!");
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
