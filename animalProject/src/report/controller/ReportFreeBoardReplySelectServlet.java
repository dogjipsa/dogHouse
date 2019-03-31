package report.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import freeboardreply.model.service.FreeBoardReplyService;
import freeboardreply.model.vo.FreeBoardReply;

/**
 * Servlet implementation class ReportFreeBoardReplySelectServlet
 */
@WebServlet("/rfrselect")
public class ReportFreeBoardReplySelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportFreeBoardReplySelectServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
				request.setCharacterEncoding("utf-8");
					
				int freeReplyNo = Integer.parseInt(request.getParameter("frnum"));
				/*String freeReplyContent = request.getParameter("frcontent");*/
							
				FreeBoardReplyService frservice = new FreeBoardReplyService();
				FreeBoardReply freeReply = new FreeBoardReply();

				freeReply = frservice.selectReply(freeReplyNo);
						
				response.setContentType("text/html; charset=utf-8");
				RequestDispatcher view = null;
				if(freeReply != null) {
					view = request.getRequestDispatcher("views/report/reportFreeBoardReplyInsert.jsp");
					request.setAttribute("freeReply", freeReply);			

					view.forward(request, response);
				}else {
						view = request.getRequestDispatcher("views/freeBoard/freeBoardReplyError.jsp");
						request.setAttribute("message", freeReplyNo + "번 댓글 신고 실패!");
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
