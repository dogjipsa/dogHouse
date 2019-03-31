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
 * Servlet implementation class questionReplyUpdateServlet
 */
@WebServlet("/qreplyup")
public class questionReplyUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public questionReplyUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		Question question = new Question();
		question.setQuestionNo(Integer.parseInt(request.getParameter("qno")));
		question.setQuestionTitle(request.getParameter("qtitle"));
		question.setQuestionContent(request.getParameter("qcontent"));
		
		int result = new QuestionService().updateReply(question);
		
		if(result > 0) {
			response.sendRedirect("/doggybeta/qlist?page=" + Integer.parseInt(request.getParameter("page")));
		}else {
			RequestDispatcher view = request.getRequestDispatcher("views/question/questionError.jsp");
			request.setAttribute("message", question.getQuestionNo());
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
