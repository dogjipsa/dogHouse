package report.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import freeboard.model.service.FreeBoardService;
import freeboard.model.vo.FreeBoard;
import report.model.service.ReportService;
import report.model.vo.Report;

/**
 * Servlet implementation class ReportFreeBoardInsertServlet
 */
@WebServlet("/rfselect")
public class ReportFreeBoardSelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportFreeBoardSelectServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int reportFreeBoardNo = Integer.parseInt(request.getParameter("reportFreeBoardNo"));
	
		FreeBoardService fservice = new FreeBoardService();
		FreeBoard freeboard = fservice.selectFreeBoard(reportFreeBoardNo);
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(freeboard != null) {
			view = request.getRequestDispatcher("views/report/reportFreeBoardInsertView.jsp");
			request.setAttribute("freeboard", freeboard);
			view.forward(request, response);
		}else {
			view = request.getRequestDispatcher("views/freeboard/freeBoardError.jsp");
			request.setAttribute("message","자유게시판 "  + reportFreeBoardNo + "번 게시글 신고페이지로 이동 실패!");
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
