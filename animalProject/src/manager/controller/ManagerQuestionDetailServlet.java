package manager.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import answer.model.vo.Answer;
import answer.model.service.AnswerService;
import manager.model.service.ManagerService;
import question.model.vo.Question;
import tipboard.model.service.TipBoardService;
import tipboard.model.vo.TipBoard;
import question.model.service.QuestionService;

/**
 * Servlet implementation class ManagerQuestionDetailServlet
 */
@WebServlet("/manqdetail")
public class ManagerQuestionDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerQuestionDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int questionNo = Integer.parseInt(request.getParameter("qnum"));
		int currentPage = Integer.parseInt(request.getParameter("page"));
		/*int currentPage = 1;
		if(request.getParameter("page") != null) {
			
			currentPage = Integer.parseInt(request.getParameter("page"));
		}*/
				
		QuestionService qservice = new QuestionService();		
		Question question = qservice.selectQuestion(questionNo);
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(question != null) {
			view = request.getRequestDispatcher("views/manager/managerQuestionDetailView.jsp");
			request.setAttribute("question", question);
			request.setAttribute("currentPage", currentPage);
			/*request.setAttribute("answer", currentPage);*/
			view.forward(request, response);
		}else {
			view = request.getRequestDispatcher("views/manager/managerError.jsp");
			request.setAttribute("message", questionNo + " 번  1:1번 문의글 상세조회 실패!");
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
