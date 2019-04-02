package manager.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.model.service.ManagerService;
import tipboard.model.vo.TipBoard;

/**
 * Servlet implementation class ManagerBoardListServlet
 */
@WebServlet("/mantb")
public class ManagerTipBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerTipBoardListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//관리자 페이지. 게시판 목록 조회용
		ManagerService ms = new ManagerService();
		request.setCharacterEncoding("UTF-8");
		int currentPage = 1; //페이지 기본
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		// 한 페이지에 출력될 게시물 수 -> pageList
		// 한 화면에 출력될 페이지 수 -> countPage
		// 나머지가 있을 경우에만 +1
				
		int pageList = 10; //원하는 출력 개수
		
		String option = request.getParameter("option");
		String word = request.getParameter("keyword");
		System.out.println(option + ",팁 " + word);
		int listCount = ms.tipboardListCount(option, word); //총 게시글 수

		ArrayList<TipBoard> tList = ms.selectTipBoardList(currentPage, pageList, option, word);
		int totalPage = (int)((double)listCount/pageList + 0.9);
		int startPage = (((int)((double)currentPage / pageList + 0.9)) -1 ) * pageList + 1;
		int endPage = startPage + pageList - 1;
		if(totalPage < endPage)
			endPage = totalPage;
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(tList.size() >= 0) {
			view = request.getRequestDispatcher("views/manager/managerTipBoardList.jsp");
			request.setAttribute("tlist", tList);
			
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("listCount", listCount);
			
			request.setAttribute("search", option);
			request.setAttribute("keyword", word);
			
			view.forward(request, response);
		} 
		else {
			view = request.getRequestDispatcher("views/manager/managerError.jsp");
			request.setAttribute("message", currentPage + "쪽 목록 조회 실패");
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
