package manager.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import freeboard.model.service.FreeBoardService;
import freeboard.model.vo.FreeBoard;

/**
 * Servlet implementation class ManagerBoardDetailServlet
 */
@WebServlet("/manbdetail")
public class ManagerBoardDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerBoardDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 관리자 페이지 게시판 상세보기 처리용 컨트롤러
		int boardNum = Integer.parseInt(request.getParameter("fnum"));
		int currentPage = Integer.parseInt(request.getParameter("page"));
		
		FreeBoardService fService = new FreeBoardService();
		//해당 글 번호 게시글 조회
		FreeBoard board = fService.selectFreeBoard(boardNum);
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(board != null) {
			view = request.getRequestDispatcher("views/manager/managerBoardDetailView.jsp");
			request.setAttribute("fboard", board);
			request.setAttribute("currentPage", currentPage);
			view.forward(request, response);
		} else {
			view = request.getRequestDispatcher("views/manager/managerError.jsp");
			request.setAttribute("massage", boardNum + "게시글 조회에 실패하였습니다.");
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
