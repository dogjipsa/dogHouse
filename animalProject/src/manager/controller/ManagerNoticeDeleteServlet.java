package manager.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import freeboard.model.service.FreeBoardService;
import manager.model.service.ManagerService;

/**
 * Servlet implementation class ManagerNoticeDeleteServlet
 */
@WebServlet("/mndelete")
public class ManagerNoticeDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerNoticeDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//게시글 (원글, 댓글) 삭제 처리용 컨트롤러
				int NoticeNo = Integer.parseInt(request.getParameter("nnum"));
				ManagerService mservice = new ManagerService();
				
				int result = mservice.deleteNotice(NoticeNo);
				
				if(result > 0) {
					response.sendRedirect("/doggybeta/flist");
				}else {
					RequestDispatcher view = request.getRequestDispatcher("views/manager/managerError.jsp");
					request.setAttribute("message", NoticeNo + "번 게시글 삭제 실패!");
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
