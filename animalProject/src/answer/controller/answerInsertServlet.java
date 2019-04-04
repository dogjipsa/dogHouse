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
		request.setCharacterEncoding("utf-8");
		
		String anscontent = request.getParameter("anscontent");
		int qboardNo = Integer.parseInt(request.getParameter("qboardNo"));
		
		int result = new AnswerService().insertAnswer(qboardNo, anscontent);
		
		RequestDispatcher view = null;
		if(result > 0) {
			response.sendRedirect("/doggybeta/manquestion");
		}else {
			view = request.getRequestDispatcher("views/manager/managerError.jsp");
			request.setAttribute("message", "문의글 등록 실패!");
			view.forward(request, response);			
		}
		
	}
		
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
