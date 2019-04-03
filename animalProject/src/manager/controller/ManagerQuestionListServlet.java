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
import question.model.vo.Question;

/**
 * Servlet implementation class ManagerQuestionListServlet
 */
@WebServlet("/manquestion")
public class ManagerQuestionListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerQuestionListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ManagerService ms = new ManagerService();
		request.setCharacterEncoding("UTF-8");
		
		int currentPage = 1;
		
		if(request.getParameter("page") != null) {
			 currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		int limit = 10;		
		
		int listCount = ms.QuestionListCount();
		System.out.println("리스트카운트트트트 : " + listCount);
		ArrayList<Question> qlist = ms.selectQuestionList(currentPage, limit);
		System.out.println(qlist);		
		int maxPage = (int)((double)listCount	/	limit + 0.9);		
		int startPage = (((int)((double)currentPage / limit + 0.9)) -1) * limit + 1;		
		int endPage = startPage + limit -1;
		
		if(maxPage	<	endPage) {
			endPage = maxPage;
		}
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(qlist.size() > 0) {
			view = request.getRequestDispatcher("views/manager/managerQuestionList.jsp");
			
			request.setAttribute("list", qlist);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("listCount", listCount);
			
			view.forward(request, response);
		}else {
			view = request.getRequestDispatcher("views/manager/managerError.jsp");
			request.setAttribute("message", currentPage + "1:1 문의 조회 실패!");
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
