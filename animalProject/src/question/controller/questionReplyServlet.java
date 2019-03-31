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
 * Servlet implementation class questionReplyServlet
 */
@WebServlet("/qreply")
public class questionReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public questionReplyServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
request.setCharacterEncoding("utf-8");
		
		int currentPage = Integer.parseInt(request.getParameter("page"));
		int questionNo = Integer.parseInt(request.getParameter("qno"));
		
		String questionTitle = request.getParameter("qtitle");
		String questionWriter = request.getParameter("qwriter");
		String questionContent = request.getParameter("qcontent");
		
		QuestionService qservice = new QuestionService();		
	
		//원글 조회
		Question originQuestion = qservice.selectQuestion(questionNo);
		
		//댓글 객체 생성
		Question replyQuestion = new Question();
		
		replyQuestion.setQuestionContent(questionContent);
		replyQuestion.setQuestionTitle(questionTitle);
		replyQuestion.setUserId(questionWriter);
		replyQuestion.setQuestionReplyLev(originQuestion.getQuestionReplyLev() +1);
		//참조하는 원글 번호
		replyQuestion.setQuestionRef(originQuestion.getQuestionReplyRef());
				
		if(replyQuestion.getQuestionReplyLev() ==2)	// 댓글의 댓글일 떄
			//참조하는 댓글번호 기록
			replyQuestion.setQuestionReplyRef(originQuestion.getQuestionNo());
		
		//댓글의 순번 무조건 1로 함
		replyQuestion.setQuestionReplySeq(1);
		
		//같은 레벨의 기존 댓글의 seq를 1증가 처리함 
		qservice.updateReplySeq(replyQuestion);
		
		//댓글 등록
		int result = qservice.insertReply(replyQuestion);
		if(result > 0) {
			response.sendRedirect("/doggybeta/qlist?page=" + currentPage);
		}else {
			RequestDispatcher view = request.getRequestDispatcher("views/question/questionError.jsp");
			request.setAttribute("message", questionNo + "번 글에 대한 댓글 등록 실패");
			view.forward(request, response);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
