package manager.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.model.service.ManagerService;

/**
 * Servlet implementation class ManagerMemberDeleteServlet
 */
@WebServlet("/mmdelete")
public class ManagerMemberDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerMemberDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//멤버 강퇴 처리용 컨트롤러
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String []delId = request.getParameterValues("delId[]");
		System.out.println(delId);
		int result = 0;
				
		for(int i = 0; i < delId.length; i ++) {
			result = new ManagerService().managerDeleteMember(delId[i]);
				}
			PrintWriter out = response.getWriter();
				if(result > 0) {
					out.println("y");
				} else {
					out.print("n");
				}
			}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
