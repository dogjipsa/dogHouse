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
 * Servlet implementation class BoardReplyServlet
 */
@WebServlet("/freply")
public class freeBoardReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public freeBoardReplyServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 댓글달기 처리용 컨트롤러

		request.setCharacterEncoding("utf-8");

//		int currentPage = Integer.parseInt(request.getParameter("page"));
		int freeBoardNo = Integer.parseInt(request.getParameter("fnum"));
		int freeReplyNo = Integer.parseInt(request.getParameter("frnum"));
//		String freeBoardTitle = request.getParameter("ftitle");
		String freeBoardWriter = request.getParameter("fwriter");
		String freeBoardContent = request.getParameter("fcontent");

		FreeBoardReplyService frservice = new FreeBoardReplyService();

		// 원글 조회
		FreeBoard originBoard = frservice.selectFreeBoard(freeBoardNo);

		// 댓글 객체 생성
		FreeBoardReply replyBoard = new FreeBoardReply();
		replyBoard.setFreereplycontent(freeBoardContent);;
	//	replyBoard.setBoardTitle(boardTitle);
		replyBoard.setUserid(freeBoardWriter);
		replyBoard.setFreeboardno(originBoard.getFreeboardNo());
	//	replyBoard.setBoardReplyLev(originBoard.getBoardReplyLev() + 1);
	//	replyBoard.setBoardRef(originBoard.getBoardRef());
		
	//	if (replyBoard.getBoardReplyLev() == 2) // 댓글의 댓글일 때
	//		replyBoard.setBoardReplyRef(originBoard.getBoardNum());
		
	//	replyBoard.setBoardReplySeq(1);

		// 같은 레벨의 기존 댓글의 seq 값 1증가 처리함
	//	bservice.updateReplySeq(replyBoard);

		// 댓글 등록
		int result = frservice.insertReply(replyBoard);		
		
		
		//댓글 조회
		FreeBoardReply reply = frservice.selectReply(freeReplyNo);
		
		
		
		if (result > 0) {
			response.sendRedirect("/doggybeta/flist");
			request.setAttribute("reply", reply);
			
		} else {
			RequestDispatcher view = request.getRequestDispatcher("views/freeBoard/freeBoardError.jsp");
			request.setAttribute("message", freeBoardNo + "번글에 대한 댓글 등록 실패!");
			view.forward(request, response);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
