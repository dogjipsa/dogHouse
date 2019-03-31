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
 * Servlet implementation class ReportTipBoardReplyInsertServlet
 */
@WebServlet("/rtrinsert")
public class ReportTipBoardReplyInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportTipBoardReplyInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String rtrwriter = request.getParameter("rtrwriter");
		String rtrcategory = request.getParameter("rtrcategory");
		String rtrcontent = request.getParameter("rfrcontent");
		int tboardNo = Integer.parseInt(request.getParameter("rtrboard"));
		int replyNo = Integer.parseInt(request.getParameter("rtrboardReply"));
		
		String tboaodNoS = String.valueOf(tboardNo);
		String replyNoS = String.valueOf(replyNo);
		String tboardReplyNo = "40" + tboaodNoS + replyNoS;
		int rtboardReplyNo = Integer.parseInt(tboardReplyNo); 
		
		Report rtreport = new Report();
		
		rtreport.setReportCategory(rtrcategory);
		rtreport.setUserId(rtrwriter);
		rtreport.setReportContent(rtrcontent);
		rtreport.setBoardNo(rtboardReplyNo);
		
		ReportService rservice = new ReportService();
		
		int result = rservice.insertReportFreeBoard(rtreport);
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(result > 0) {
			response.sendRedirect("/doggybeta/tdetail?tnum=" + tboardNo);			
		}else {
			view = request.getRequestDispatcher("views/tipboard/tipBoardError.jsp");
			request.setAttribute("message","자유게시판 "  + tboardNo + "번 게시글 " + replyNo + " 신고페이지로 이동 실패!");
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
