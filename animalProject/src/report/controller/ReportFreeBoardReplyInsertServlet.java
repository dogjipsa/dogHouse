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
 * Servlet implementation class ReportFreeBoardReplyInsert
 */
@WebServlet("/rfrinsert")
public class ReportFreeBoardReplyInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportFreeBoardReplyInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String rfrwriter = request.getParameter("rfrwriter");
		String rfrcategory = request.getParameter("rfrcategory");
		String rfrcontent = request.getParameter("rfrcontent");
		int fboardNo = Integer.parseInt(request.getParameter("rfrboard"));
		int replyNo = Integer.parseInt(request.getParameter("rfrboardReply"));
		
		String fboaodNoS = String.valueOf(fboardNo);
		String replyNoS = String.valueOf(replyNo);
		String fboardReplyNo = "20" + fboaodNoS + replyNoS;
		int rfboardReplyNo = Integer.parseInt(fboardReplyNo); 
		
		Report rfreport = new Report();
		
		rfreport.setReportCategory(rfrcategory);
		rfreport.setUserId(rfrwriter);
		rfreport.setReportContent(rfrcontent);
		rfreport.setBoardNo(rfboardReplyNo);
		
		ReportService rservice = new ReportService();
		
		int result = rservice.insertReportFreeBoard(rfreport);
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(result > 0) {
			response.sendRedirect("/doggybeta/fdetail?fnum=" + fboardNo);			
		}else {
			view = request.getRequestDispatcher("views/freeboard/freeBoardError.jsp");
			request.setAttribute("message","자유게시판 "  + fboardNo + "번 게시글 " + replyNo + " 신고페이지로 이동 실패!");
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
