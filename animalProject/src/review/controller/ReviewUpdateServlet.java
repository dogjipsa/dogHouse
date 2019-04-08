package review.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import review.model.service.ReviewService;

/**
 * Servlet implementation class ReviewUpdateServlet
 */
@WebServlet("/reviewup")
public class ReviewUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String root = request.getSession().getServletContext().getRealPath("/");
		String savePath = root+"files/pet";
		MultipartRequest mrequest = new MultipartRequest(request, savePath, 1024, "UTF-8", new DefaultFileRenamePolicy());
		
		int rno = Integer.parseInt(mrequest.getParameter("rnum"));
		String content = mrequest.getParameter("content").replaceAll("\r\n", "<br>");
		String point = mrequest.getParameter("star-input");
		
		int result = new ReviewService().updateReview(content, point,rno);
		if(result > 0) {
			PrintWriter out = response.getWriter();
			out.append("ok");
			out.flush();
			out.close();
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
