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
 * Servlet implementation class ReportTipBoardInsertServlet
 */
@WebServlet("/rtinsert")
public class ReportTipBoardInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportTipBoardInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String rtwriter = request.getParameter("rtwriter");
		String rtcategory = request.getParameter("rtcategory");
		String rtcontent = request.getParameter("rtcontent");
		int No = Integer.parseInt(request.getParameter("rtboard"));
		
		String rtboard = String.valueOf(No);
		String rtboardS = "10" + rtboard;
		int rtboardNo = Integer.parseInt(rtboardS); 
		
		Report rtreport = new Report();
		
		rtreport.setReportCategory(rtcategory);
		rtreport.setUserId(rtwriter);
		rtreport.setReportContent(rtcontent);
		rtreport.setBoardNo(rtboardNo);
		
		ReportService rservice = new ReportService();
		
		int result = rservice.insertReportTipBoard(rtreport);
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(result > 0) {
			response.sendRedirect("/doggybeta/tdetail?tnum=" + rtboard);			
		}else {
			view = request.getRequestDispatcher("views/freeboard/freeBoardError.jsp");
			request.setAttribute("message","자유게시판 "  + rtboard + "번 게시글 신고페이지로 이동 실패!");
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
