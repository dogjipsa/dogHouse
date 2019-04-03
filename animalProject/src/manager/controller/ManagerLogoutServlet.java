package manager.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import manager.model.service.ManagerService;
import manager.model.vo.Manager;

/**
 * Servlet implementation class ManagerLogoutServlet
 */
@WebServlet("/mDHLogout")
public class ManagerLogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerLogoutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 관리자페이지 로그아웃
		HttpSession session = request.getSession(false);
		Manager m = (Manager)session.getAttribute("loginmanager");
		System.out.println("관리자 m : " + m.getManagerId());
		boolean result = new ManagerService().checkLogoutManager(m.getManagerId());
		
		if(session != null && result == true) {
			//로그인상태이다.
			session.removeAttribute("loginmanager");
			/*session.invalidate();*/
			response.sendRedirect("/doggybeta/views/manager/managerLogin.jsp"); //로그아웃시 첫화면 뜨게함.
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
