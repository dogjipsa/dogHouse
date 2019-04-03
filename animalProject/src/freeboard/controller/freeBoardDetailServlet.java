package freeboard.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import freeboard.model.service.FreeBoardService;
import freeboard.model.vo.FreeBoard;
import freeboardreply.model.service.FreeBoardReplyService;
import freeboardreply.model.vo.FreeBoardReply;

/**
 * Servlet implementation class BoardDetailServlet
 */
@WebServlet("/fdetail")
public class freeBoardDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public freeBoardDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 게시글 상세보기 처리용 컨트롤러
		int result = 1;
		int currentPage = 1;
		
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));}
		
		int freeBoardNo = Integer.parseInt(request.getParameter("fnum"));
		String freeBoardWriter = request.getParameter("fwriter");
		String freeBoardContent = request.getParameter("fcontent");	
	
		FreeBoardService fservice = new FreeBoardService();
		FreeBoardReplyService frservice = new FreeBoardReplyService();
		
		// 댓글 객체 생성 및 등록
		if(freeBoardContent != null) {
		FreeBoard originBoard = frservice.selectFreeBoard(freeBoardNo);
		FreeBoardReply replyBoard = new FreeBoardReply();
		replyBoard.setFreereplycontent(freeBoardContent);
		replyBoard.setUserid(freeBoardWriter);
		replyBoard.setFreeboardno(originBoard.getFreeboardNo());

		result = frservice.insertReply(replyBoard);	
				}
		
		//조회수 1증가 처리함
		fservice.addReadCount(freeBoardNo);
		
		//해당 글번호의 게시글 조회해 옴
		FreeBoard freeboard = fservice.selectFreeBoard(freeBoardNo);
		
		//댓글 가져오기
		HashMap<String, Object> map = new HashMap<>();
		map.put("freeBoardNo", freeBoardNo);
		map.put("startRow", currentPage*10-9);// 1, 11, 21, 31....
				
		ArrayList<FreeBoardReply> replyList = frservice.selectReplyList(map);
				
		
		//한 페이지에 출력할 목록 갯수 지정
		int limit = 10;
		
		//현재 페이지에 출력할 목록 조회
		int listCount =  frservice.getListCount(map);
		
		//행의 갯수가 10개일 때 다음 페이지로 넘어감.
		
		//총 페이지수 계산 : 1페이지부터 현재페이지까지 페이지 갯수
		//예: 현재 행의갯수 23개면 페이지는 3페이지 = maxPage
		int maxPage = (int)((double)listCount / limit + 0.9); // 1, 2, 3....
		
		//현재 페이지의 시작페이지 번호 1, 11, 21, 31....
		//1페이지 때문에 + 0.9 했네..
		int startPage = (((int)((double)currentPage / limit + 0.9)) - 1) * limit + 1;
		
		//현재 페이지의 끝페이지 번호 10, 20, 30....
		int endPage = startPage + limit - 1;		
		
		
		if(maxPage < endPage) {
		endPage = maxPage;
		}
		
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(freeboard != null) {
			view = request.getRequestDispatcher("views/freeBoard/freeBoardDetailView.jsp");
			request.setAttribute("freeboard", freeboard);
			request.setAttribute("replyList", replyList);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("listCount", listCount);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			
			view.forward(request, response);
		}else {
			view = request.getRequestDispatcher("views/freeBoard/freeBoardError.jsp");
			request.setAttribute("message", freeBoardNo + "번 게시글 상세조회 실패! 로그인하십시오.");
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
