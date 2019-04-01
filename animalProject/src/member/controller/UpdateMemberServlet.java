package member.controller;

import java.io.IOException;
import java.io.PrintWriter;

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
 * Servlet implementation class UpdateMemberServlet
 */
@WebServlet("/changeinfo")
public class UpdateMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateMemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 회원 정보 db 업데이트 처리용 컨트롤러 (19.03.26 아직 필요하지 않음)
		request.setCharacterEncoding("utf-8");
		System.out.println("확인중!");
		
		Member member = new Member();
		member.setUserId(request.getParameter("userid"));
		member.setUserPwd(request.getParameter("userpwd"));
		member.setPhone(request.getParameter("phone"));
		member.setEmail(request.getParameter("email"));
		String fullAddr = request.getParameter("addr") + ", " + request.getParameter("extra") + " "
		            + request.getParameter("daddr") + " (" + request.getParameter("postcode") + ")";
		member.setAddress(fullAddr);
		
		System.out.println("전체 주소 : " + fullAddr);
		
		member.setJob(request.getParameter("job"));
		
		System.out.println("회원 수정 서블릿 : " + member.toString());
		int result = new MemberService().updateMember(member);
		
		response.setContentType("text/html; charset=utf-8");
		
		System.out.println("서블릿 result : " + result);
		RequestDispatcher view = null;
		
		PrintWriter out = response.getWriter();
		
		if(result > 0) {
			/*view = request.getRequestDispatcher("views/member/changeInformation.jsp");
			request.setAttribute("member", member);			
			view.forward(request, response);	*/					
			response.sendRedirect("/doggybeta/jipsalogout");
		}else {
			
			out.println("<script>alert('정보 수정에 실패하였습니다. 메인 화면으로 이동합니다.'); location.href='/doggybeta';</script>");
			out.flush();
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
