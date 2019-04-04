package answer.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import answer.model.service.AnswerService;
import answer.model.vo.Answer;
import question.model.service.QuestionService;
import question.model.vo.Question;

/**
 * Servlet implementation class answerWriteServlet
 */
@WebServlet("/ansinsert")
public class answerInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public answerInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher view = null;
		if(!ServletFileUpload.isMultipartContent(request)){
			view = request.getRequestDispatcher("view/question/answerError.jsp");
			request.setAttribute("message", "form의 enctype 속성 사용 안되었음");
			view.forward(request, response);
		}
				
		Answer answer = new Answer();
				
		int result = new AnswerService().insertAnswer(answer);
		
		if(result > 0) {
			response.sendRedirect("/doggybeta/qlist?page=1");
		}else {
			view = request.getRequestDispatcher("views/question/questionError.jsp");
			request.setAttribute("message", "문의글 등록 실패!");
			view.forward(request, response);			
		}
		
	}
		/*int questionNo = Integer.parseInt(request.getParameter("qnum"));
		System.out.println("ans servlet qnum : " + questionNo);
		
		Answer answer = new Answer();
		answer = new AnswerService().selectAnswer(questionNo);
		System.out.println("servlet ans :"+answer);
		System.out.println(answer.getAnswerNo());
		RequestDispatcher view = null;
		 && questionNo == answer.getAnswerNo()
		if(answer != null) {
			view = request.getRequestDispatcher("views/question/questionListView.jsp");
			request.setAttribute("answer", answer);
			view.forward(request, response);
		}else{
			view = request.getRequestDispatcher("views/question/questionError.jsp");
			request.setAttribute("message", questionNo + "1:1 문의 수정페이지 이동 실패!");
			view.forward(request, response);
		}
		
	}*/

/**
* @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
*/
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
