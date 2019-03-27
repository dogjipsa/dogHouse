package tipboardreply.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tipboard.model.service.TipBoardService;
import tipboard.model.vo.TipBoard;
import tipboardreply.model.service.TipBoardReplyService;
import tipboardreply.model.vo.TipBoardReply;

/**
 * Servlet implementation class TipBoardReplyInsertServlet
 */
@WebServlet("/trinsert")
public class TipBoardReplyInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TipBoardReplyInsertServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		TipBoardReply trboard = new TipBoardReply();
		/* int tipBoardNum = Integer.parseInt(request.getParameter("tnum")); */

		int tipBoardNo = Integer.parseInt(request.getParameter("tipBoard_no"));
		String tipReplyId = request.getParameter("tipReply_id");
		String tipReplyContent = request.getParameter("tipReply_content");

		/* comment.setComment_num(dao.getSeq()); */ // 댓글 번호는 시퀀스값으로
		trboard.setTipNo(tipBoardNo);
		trboard.setUserId(tipReplyId);
		trboard.setTipReplyContent(tipReplyContent);
		/*
		 * comment.setComment_board(comment_board); comment.setComment_id(comment_id);
		 * comment.setComment_content(comment_content);
		 * 
		 * boolean result = dao.insertComment(comment);
		 */
		/*int currentPage = 1;
		if ((request.getParameter("page")) != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}*/

		TipBoardReplyService trservice = new TipBoardReplyService();
		/*// 댓글 페이징 처리 위한 변수들
		int trcurrentPage = 1;
		if (request.getParameter("trpage") != null) {
			trcurrentPage = Integer.parseInt(request.getParameter("trpage"));
		}
		int limit = 10;
		int listCount = trservice.getListCount();
		// 총 페이지수 계산 : 목록이 마지막 1개일 때 1페이지로 처리
		int maxPage = (int) ((double) listCount / limit + 0.9);
		// 현재 페이지그룹(10개 페이지를 한 그룹으로 처리)에
		// 보여줄 시작 페이지 수
		// 현재 페이지가 13이면 그룹은 11~20이 보여지게 함
		int startPage = (((int) ((double) trcurrentPage / limit + 0.9)) - 1) * limit + 1;
		int endPage = startPage + limit - 1;
		if (maxPage < endPage) {
			endPage = maxPage;
		}*/

		/*System.out.println("서블릿에서 currentPage 확인 : " + currentPage);
		System.out.println("팁게시판 댓글의 글번호 : " + tipBoardNo);
		System.out.println("서블릿에서 팁 보드넘버 확인 : " + tipBoardNo);*/
		/*ArrayList<TipBoardReply> list = trservice.selectList(tipBoardNo, trcurrentPage, limit);*/
		/*int listCount = trservice.getListCount(tipBoardNo);
		int maxPage = (int) ((double) listCount / 10.9);*/
		response.setContentType("text/html; charset=utf-8");

		/*RequestDispatcher view = null;*/
		int result = trservice.insertTipBoardReply(trboard);
		if(result > 0) {
		/*view = request.getRequestDispatcher("views/tipboard/tipBoardDetailView.jsp");*/
		/*response.sendRedirect("/doggybeta/tdetail?tnum="+tipBoardNo+"&trpage"+maxPage);*/
		/*request.setAttribute("currentPage", currentPage);*/

		/*request.setAttribute("replyList", list);// 댓글
*/		/*request.setAttribute("trcurrentPage", trcurrentPage);
		request.setAttribute("maxPage", maxPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("listCount", listCount);*/
		/*view.forward(request, response);*/
		}

		/*
		 * if(result){ response.setContentType("text/html;charset=euc-kr"); PrintWriter
		 * out = response.getWriter(); out.println("1"); out.close(); }
		 * 
		 * return null;
		 */
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
