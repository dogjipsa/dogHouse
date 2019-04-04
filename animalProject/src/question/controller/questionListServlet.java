package question.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import question.model.service.QuestionService;
import question.model.vo.Question;

/**
 * Servlet implementation class questionDetailServlet
 */
@WebServlet("/qlist")
public class questionListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public questionListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		int currentPage = 1;
		
		if(request.getParameter("page") != null) {
			 currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		int limit = 10;
		
		QuestionService qservice = new QuestionService();
		
		int listCount = qservice.getListCount();
		
		ArrayList<Question> list = qservice.selectList(currentPage, limit);
				
		int maxPage = (int)((double)listCount	/	limit + 0.9);
		
		int startPage = (((int)((double)currentPage / limit + 0.9)) -1) * limit + 1;
		
		int endPage = startPage + limit -1;
		
		if(maxPage	<	endPage) {
			endPage = maxPage;
		}
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(list.size() > 0) {
			view = request.getRequestDispatcher("views/question/questionListView.jsp");
			
			request.setAttribute("list", list);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("listCount", listCount);
			
			view.forward(request, response);
		}else {
			view = request.getRequestDispatcher("views/question/questionError.jsp");
			request.setAttribute("message", currentPage + "유저 1:1문의 조회 실패!");
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
