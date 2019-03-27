package freeboardreply.controller;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

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
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 댓글달기 처리용 컨트롤러

		request.setCharacterEncoding("utf-8");
		
		int currentPage = 1;
		int result = 1;
//		int currentPage = Integer.parseInt(request.getParameter("page"));
		
		int freeBoardNo = Integer.parseInt(request.getParameter("fnum"));	
		String freeBoardWriter = request.getParameter("fwriter");
		String freeBoardContent = request.getParameter("fcontent");	
		
		FreeBoardReplyService frservice = new FreeBoardReplyService();
		System.out.println("fnum : " + freeBoardNo);
		System.out.println("fwriter : " + freeBoardWriter);
		System.out.println("fcontent : " + freeBoardContent);
		
		// 댓글 객체 생성 및 등록
		if(freeBoardContent != null) {
		FreeBoard originBoard = frservice.selectFreeBoard(freeBoardNo);
		FreeBoardReply replyBoard = new FreeBoardReply();
		replyBoard.setFreereplycontent(freeBoardContent);
		replyBoard.setUserid(freeBoardWriter);
		replyBoard.setFreeboardno(originBoard.getFreeboardNo());

		result = frservice.insertReply(replyBoard);	
		}
		
		//댓글 가져오기
		System.out.println("fnum : " + freeBoardNo);
		HashMap<String, Object> map = new HashMap<>();
		map.put("freeBoardNo", freeBoardNo);
		map.put("startRow", currentPage*10-9);// 1, 11, 21, 31....
		
		System.out.println("map : " + map.get("freeBoardNo") + ", " + map.get("startRow"));
		
		ArrayList<FreeBoardReply> flist = frservice.selectReplyList(map);
		
		for(FreeBoardReply f : flist) {
		System.out.println("댓글List : " + f);
		}
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if (result > 0) {
			view = request.getRequestDispatcher("views/freeBoard/freeBoardDetailView.jsp");
			request.setAttribute("replyList", flist);
			view.forward(request, response);
			
		} else {
			view = request.getRequestDispatcher("views/freeBoard/freeBoardError.jsp");
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
