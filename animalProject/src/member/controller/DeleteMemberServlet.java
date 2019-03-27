package member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import member.model.vo.UpdateDeleteId;
import member.model.service.MemberService;


/**
 * Servlet implementation class DeleteMemberServlet
 */
@WebServlet("/delmember")
public class DeleteMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteMemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userid");
		System.out.println(userId);

		//1.아이디에 del문자 추가하는 update!!
		String deleteId = null;
		deleteId = new UpdateDeleteId().toString();
		
		System.out.println("서블릿 삭제 아이디 : " + deleteId);
		
		int result = new MemberService().deleteMember(userId, deleteId);
		
		String returnValue = null;
		
		if(result > 0)
			returnValue = "ok";
		else returnValue = "dup";

		
		PrintWriter out = response.getWriter();
		out.append(returnValue);
		out.flush();
		out.close();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
