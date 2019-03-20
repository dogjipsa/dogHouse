package tipboard.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tipboard.model.service.TipBoardService;
import tipboard.model.vo.TipBoard;

/**
 * Servlet implementation class TipBoardDetailServlet
 */
@WebServlet("/tdetail")
public class TipBoardDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TipBoardDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int tipBoardNum = Integer.parseInt(request.getParameter("tnum"));
		int currentPage = Integer.parseInt(request.getParameter("page"));
		TipBoardService tservice = new TipBoardService();
		
		//조회수 1증가 처리함
		tservice.addReadCount(tipBoardNum);
		
		//해당 글번호의 게시글 조회해 옴
		TipBoard tboard = tservice.selectBoard(tipBoardNum);
		
		response.setContentType("text/html; charset=utf-8");
		
		RequestDispatcher view = null;
		if(tboard != null) {
			view = request.getRequestDispatcher("views/tipboard/tipBoardDetailView.jsp");
			request.setAttribute("tboard", tboard);
			request.setAttribute("currentPage", currentPage);
			view.forward(request, response);
		}else {
			view = request.getRequestDispatcher("views/tipboard/tipBoardError.jsp");
			request.setAttribute("message", tipBoardNum + "번 게시글 조회 실패");
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
