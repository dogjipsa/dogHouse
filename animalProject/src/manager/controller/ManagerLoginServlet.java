package manager.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import manager.model.service.ManagerService;
import manager.model.vo.Manager;

/**
 * Servlet implementation class ManagerLoginServlet
 */
@WebServlet("/dhMLogin")
public class ManagerLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 관리자 로그인 처리용 컨트롤러
		String managerId = request.getParameter("managerid");
		String managerPwd = request.getParameter("managerpwd");
		
		Manager loginManager = new ManagerService().loginManager(managerId, managerPwd);
		System.out.println("관리자 로그인 전송값 : " + managerId + ", " + managerPwd);
		response.setContentType("text/html; charset=utf-8");
		
		if(loginManager != null) {
			HttpSession session = request.getSession();
			System.out.println("세션아이디 : " + session.getId());
			session.setAttribute("loginmanager", loginManager);
			
			response.sendRedirect("/doggybeta/views/manager/managerLogin.jsp");
		} else {
			RequestDispatcher view = request.getRequestDispatcher("views/manager/managerError.jsp");
			request.setAttribute("message", "로그인에 실패하였습니다. 다시 시도해주세요.");
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
