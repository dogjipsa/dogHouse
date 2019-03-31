package tipboardreply.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tipboard.model.service.TipBoardService;
import tipboardreply.model.service.TipBoardReplyService;

/**
 * Servlet implementation class TipBoardReplyDeleteServlet
 */
@WebServlet("/trdelete")
public class TipBoardReplyDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TipBoardReplyDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int tipReplyBoardNum = Integer.parseInt(request.getParameter("trnum"));
		int tipBoardNum = Integer.parseInt(request.getParameter("tnum"));
		
		int result = new TipBoardReplyService().deleteTipBoardReply(tipBoardNum);
	
	
		RequestDispatcher view = null;
		if(result > 0) {
			response.sendRedirect("/doggybeta/fdetail?fnum=" + tipBoardNum);

		}else {
			view = request.getRequestDispatcher("views/tipBoard/tipBoardError.jsp");
			request.setAttribute("message", "댓글 삭제 실패!");
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
