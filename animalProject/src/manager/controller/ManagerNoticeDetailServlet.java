package manager.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import freeboard.model.service.FreeBoardService;
import freeboard.model.vo.FreeBoard;
import freeboardreply.model.service.FreeBoardReplyService;
import freeboardreply.model.vo.FreeBoardReply;
import manager.model.service.ManagerService;
import notice.model.vo.Notice;

/**
 * Servlet implementation class ManagerNoticeDetailServlet
 */
@WebServlet("/manndetail")
public class ManagerNoticeDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerNoticeDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				// 게시글 상세보기 처리용 컨트롤러			
				int NoticeNo = Integer.parseInt(request.getParameter("nnum"));
				/*String NoticeWriter = request.getParameter("nwriter");
				String NoticeContent = request.getParameter("ncontent");*/	
			
				ManagerService mservice = new ManagerService();
				
				//조회수 1증가 처리함
				//mservice.addReadCount(NoticeNo);
				
				//해당 글번호의 게시글 조회해 옴
				Notice notice = mservice.selectNoitce(NoticeNo);
								System.out.println(notice);
				response.setContentType("text/html; charset=utf-8");
				RequestDispatcher view = null;
				if(notice != null) {
					view = request.getRequestDispatcher("views/manager/managerNoticeDetailView.jsp");
					request.setAttribute("notice", notice);
					
					view.forward(request, response);
				}else {
					view = request.getRequestDispatcher("views/manager/managerError.jsp");
					request.setAttribute("message", NoticeNo + "번 게시글 상세조회 실패! 로그인하십시오.");
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
