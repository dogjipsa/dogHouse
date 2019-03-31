package question.controller;

import java.io.IOException;

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
@WebServlet("/qdetail")
public class questionDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public questionDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int questionNo = Integer.parseInt(request.getParameter("no"));
		/*int currentPage = Integer.parseInt(request.getParameter("page"));*/
		
		QuestionService qservice = new QuestionService();
		
		/*qservice.addReadCount(questionNo);*/
		
		Question question = qservice.selectQuestion(questionNo);
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(question != null) {
			view = request.getRequestDispatcher("views/question/questionDetailView.jsp");
			request.setAttribute("question", question);
			/*request.setAttribute("currentPage", currentPage);*/
			view.forward(request, response);
		}else {
			view = request.getRequestDispatcher("views/question/questionError.jsp");
			request.setAttribute("message", questionNo + " 번 1:1 문의글 상세조회 실패!");
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
