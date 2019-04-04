package answer.controller;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.RequestDispatcher;;

import answer.model.service.AnswerService;
import answer.model.vo.Answer;

/**
 * Servlet implementation class answerSelectServlet
 */
@WebServlet("/ansselect")
public class answerSelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public answerSelectServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int questionNo = Integer.parseInt(request.getParameter("qnum"));
		System.out.println("ans servlet qnum : " + questionNo);
		
		Answer answer = new Answer();
		answer = new AnswerService().selectAnswer(questionNo);
		System.out.println("servlet ans :"+answer);
		System.out.println(answer.getAnswerNo());
		RequestDispatcher view = null; && questionNo == answer.getAnswerNo()
		if(answer != null) {
			view = request.getRequestDispatcher("views/question/questionListView.jsp");
			request.setAttribute("answer", answer);
			view.forward(request, response);
		}else{
			view = request.getRequestDispatcher("views/question/questionError.jsp");
			request.setAttribute("message", questionNo + "1:1 문의 수정페이지 이동 실패!");
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
