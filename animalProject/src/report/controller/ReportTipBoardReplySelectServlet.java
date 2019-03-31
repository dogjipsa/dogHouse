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
import tipboardreply.model.service.TipBoardReplyService;
import tipboardreply.model.vo.TipBoardReply;

/**
 * Servlet implementation class ReportTipBoardReplySelectServlet
 */
@WebServlet("/rtrselect")
public class ReportTipBoardReplySelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportTipBoardReplySelectServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int tipReplyNo = Integer.parseInt(request.getParameter("trnum"));
		System.out.println("trnum : " + tipReplyNo);
		/*String freeReplyContent = request.getParameter("frcontent");*/
		
		
		TipBoardReplyService trservice = new TipBoardReplyService();
		TipBoardReply tipReply = new TipBoardReply();

		tipReply = trservice.selectTipBoardReply(tipReplyNo);
		System.out.println("tipReply : " + tipReply);
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(tipReply != null) {
			view = request.getRequestDispatcher("views/report/reportTipBoardReplyInsert.jsp");
			request.setAttribute("tipReply", tipReply);			

			view.forward(request, response);
		}else {
				view = request.getRequestDispatcher("views/tipBoard/tipBoardError.jsp");
				request.setAttribute("message", "팁게시판 " + tipReplyNo + "번 댓글 신고 실패!");
				view.forward(request, response);
					
				}
			}

/**
* @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
*/

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
