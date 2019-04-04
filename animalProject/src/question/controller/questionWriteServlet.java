package question.controller;

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

import question.model.service.QuestionService;
import question.model.vo.Question;

/**
 * Servlet implementation class questionWriteServlet
 */
@WebServlet("/qinsert")
public class questionWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public questionWriteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
				RequestDispatcher view = null;
				if(!ServletFileUpload.isMultipartContent(request)){
					view = request.getRequestDispatcher("view/question/questionError.jsp");
					request.setAttribute("message", "form의 enctype 속성 사용 안되었음");
					view.forward(request, response);
				}
				int maxSize = 1024 * 1024 * 10;
				
				String root = request.getSession().getServletContext().getRealPath("/");
				
				String savePath = root + "files/question";
				
				
				MultipartRequest mrequest = new MultipartRequest
						(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
				
			
				Question question = new Question();
				
				question.setQuestionTitle(mrequest.getParameter("qtitle"));
				question.setUserId(mrequest.getParameter("quserid"));
				question.setQuestionContent(mrequest.getParameter("qcontent"));
				
				String originalFileName = mrequest.getFilesystemName("qupfile");
				
				
				if(originalFileName != null) {
					
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
					String renameFileName = 
							sdf.format(new java.sql.Date(System.currentTimeMillis())) + "." 
									+ originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
					
					File originFile = new File(savePath + "\\" + originalFileName);
					File renameFile = new File(savePath + "\\" + renameFileName);
					
					if(!originFile.renameTo(renameFile)) {
						
						int read = -1;
						byte[] buf = new byte[1024];
						
						FileInputStream fin = new FileInputStream(originFile);
						FileOutputStream fout = new FileOutputStream(renameFile);
						
						while((read = fin.read(buf, 0, buf.length)) != -1){
							fout.write(buf, 0, read);
						}
						
						fin.close();
						fout.close();
						originFile.delete();
					}	
					
					question.setQuestionOriginalFileName(originalFileName);
					question.setQuestionRenameFileName(renameFileName);
				}	
				
				
				int result = new QuestionService().insertQuestion(question);
				
				if(result > 0) {
					response.sendRedirect("/doggybeta/qlist?page=1");
				}else {
					view = request.getRequestDispatcher("views/question/questionError.jsp");
					request.setAttribute("message", "문의글 등록 실패!");
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
