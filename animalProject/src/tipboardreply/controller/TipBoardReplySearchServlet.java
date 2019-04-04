package tipboardreply.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tipboardreply.model.service.TipBoardReplyService;
import tipboardreply.model.vo.TipBoardReply;

/**
 * Servlet implementation class TipBoardReplySearchServlet
 */
@WebServlet("/trsearch")
public class TipBoardReplySearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TipBoardReplySearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int tipBoardReplyNo = Integer.parseInt(request.getParameter("trnum"));
		TipBoardReply tipReply = new TipBoardReplyService().selectTipBoardReply(tipBoardReplyNo);
		
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(tipReply != null) {
			view = request.getRequestDispatcher("views/tipboard/tipBoardReplyUpdateView.jsp");
			request.setAttribute("tipReply", tipReply);			
			view.forward(request, response);
		}else {
			view = request.getRequestDispatcher("views/tipboard/tipBoardError.jsp");
			request.setAttribute("message", tipBoardReplyNo + "번 댓글 수정 실패!");
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
