package freeboardreply.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import freeboard.model.vo.FreeBoard;
import freeboardreply.model.service.FreeBoardReplyService;
import freeboardreply.model.vo.FreeBoardReply;

/**
 * Servlet implementation class BoardReplyUpdateServlet
 */
@WebServlet("/freplyup")
public class freeBoardReplyUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public freeBoardReplyUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int freeReplyNo = Integer.parseInt(request.getParameter("frnum"));
		String freeReplyContent = request.getParameter("frcontent");
		int detailNo = Integer.parseInt(request.getParameter("fnum"));
		
		FreeBoardReplyService frservice = new FreeBoardReplyService();
		
		int result = frservice.updateReply(freeReplyContent, freeReplyNo);
	
							
		RequestDispatcher view = null;
		if(result > 0) {
			response.sendRedirect("/doggybeta/fdetail?fnum=" + detailNo);

		}else {
			view = request.getRequestDispatcher("views/freeBoard/freeBoardError.jsp");
			request.setAttribute("message", "댓글 수정 실패!");
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
