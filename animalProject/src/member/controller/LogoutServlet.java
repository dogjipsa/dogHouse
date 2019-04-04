package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/jipsalogout")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogoutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Logout
		HttpSession session = request.getSession(false);
		Member s = (Member)session.getAttribute("loginUser");
		boolean result = false;
		if(s.getNaverCode() == null) 
			result = new MemberService().checkLogoutUser(s.getUserId());
		else 
			result = new MemberService().checkLogoutNUser(s.getUserId());
			
		System.out.println("user 로그아웃 : " + result);
		System.out.println("s : " + s.getUserId());
		
		if(session != null && result == true) {
			//로그인상태이다.
			session.removeAttribute("loginUser");
			response.sendRedirect("/doggybeta/index.jsp"); //로그아웃시 첫화면 뜨게함.
		} else {
			RequestDispatcher view = request.getRequestDispatcher("views/member/memberError.jsp");
			request.setAttribute("message", "로그아웃에 실패하였습니다.");
			view.forward(request, response);;
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
