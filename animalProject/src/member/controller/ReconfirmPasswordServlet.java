package member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class ReconfirmPasswordServlet
 */
@WebServlet("/reconfirm")
public class ReconfirmPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReconfirmPasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//String password = request.getParameter("password");
		String userPwd = request.getParameter("userpwd");
		String userId = request.getParameter("userid");
		System.out.println(userPwd + "," + userId);

		//userid 받아서 service, dao가서 query에서 select pwd where user_id = ?
		
		Member loginUser = new MemberService().reconfrimPassword(userId);
		System.out.println("loginuser servlet : " + loginUser.toString());
		JSONObject job = new JSONObject();
		
		job.put("pwd", loginUser.getUserPwd());

		
		System.out.println("job : " + job.toJSONString()); 
		//요청한 클라이언트쪽으로 json 객체 전송함
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(job.toJSONString());
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
