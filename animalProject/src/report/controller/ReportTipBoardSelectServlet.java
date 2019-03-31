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
import tipboard.model.service.TipBoardService;
import tipboard.model.vo.TipBoard;

/**
 * Servlet implementation class ReportTipBoardSelectServlet
 */
@WebServlet("/rtselect")
public class ReportTipBoardSelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportTipBoardSelectServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int reportTipBoardNo = Integer.parseInt(request.getParameter("reportTipBoardNo"));
		
		TipBoardService tservice = new TipBoardService();
		TipBoard tipboard = tservice.selectTipBoard(reportTipBoardNo);
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(tipboard != null) {
			view = request.getRequestDispatcher("views/report/reportTipBoardInsertView.jsp");
			request.setAttribute("tipboard", tipboard);
			view.forward(request, response);
		}else {
			view = request.getRequestDispatcher("views/freeboard/freeBoardError.jsp");
			request.setAttribute("message","자유게시판 "  + reportTipBoardNo + "번 게시글 신고페이지로 이동 실패!");
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
