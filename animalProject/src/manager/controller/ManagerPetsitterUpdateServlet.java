package manager.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.model.service.ManagerService;
import member.model.vo.Member;

/**
 * Servlet implementation class ManagerPetsitterUpdateServlet
 */
@WebServlet("/mpupdate")
public class ManagerPetsitterUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerPetsitterUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String userId = request.getParameter("userid");
		/*int page = Integer.parseInt(request.getParameter("page"));*/
		System.out.println("userid : " + userId);
		ManagerService mservice = new ManagerService();
		int result = mservice.updatePetsitter(userId);
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(result > 0) {
			response.sendRedirect("/doggybeta/mpsearch");
			
		}else {
			view = request.getRequestDispatcher("views/manager/managerError.jsp");
			request.setAttribute("message", "펫시터 승인 실패!");
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
