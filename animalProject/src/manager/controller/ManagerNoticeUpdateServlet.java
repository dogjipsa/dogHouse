package manager.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import freeboard.model.service.FreeBoardService;
import freeboard.model.vo.FreeBoard;
import manager.model.service.ManagerService;
import notice.model.vo.Notice;

/**
 * Servlet implementation class ManagerNoticeUpdateServlet
 */
@WebServlet("/mnupdate")
public class ManagerNoticeUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerNoticeUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 게시글 수정페이지 출력 처리용 컨트롤러
				int NoticeNo = Integer.parseInt(request.getParameter("nnum"));
				
				Notice notice = new ManagerService().selectNoitce(NoticeNo);
				
				response.setContentType("text/html; charset=utf-8");
				RequestDispatcher view = null;
				if(notice != null) {
					view = request.getRequestDispatcher("views/manager/managerNoticeUpdateView.jsp");
					request.setAttribute("notice", notice);
					view.forward(request, response);
				}else {
					view = request.getRequestDispatcher("views/manager/managerError.jsp");
					request.setAttribute("message", NoticeNo + "번 게시글 수정페이지로 이동 실패!");
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
