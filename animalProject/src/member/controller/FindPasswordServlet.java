package member.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class FindPasswordServlet
 */
@WebServlet("/jipsafindpwd")
public class FindPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FindPasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 임시비밀번호 발송 처리용 컨트롤러
		request.setCharacterEncoding("utf-8");
		String host = "smtp.naver.com";
		/*final String user = "NAVER_ID";*/
		final String password = "Wheerang)615";
		int port = 465;
		
		Member member = new Member();
		String email = request.getParameter("email");
		String userid = request.getParameter("userid");
		member.setUserId(userid);
		member.setEmail(email);
		
		System.out.println("비밀번호찾기 : " + userid + " == " + email);
		int result = new MemberService().findPassword(member);
		response.setContentType("text/html; charset=utf-8");
		if(result > 0) {
			URLDecoder.decode("urlcontext", "UTF-8");
			int idx = email.indexOf("@");
			
		Properties prop = new Properties();
		System.out.println(idx);
		System.out.println(String.valueOf(idx));
		prop.put("mail.smtp.host", host);
		prop.put("mail.smtp.port", port);
		prop.put("mail.smtp.auth", "true");
		/*prop.put("mail.smpt.ssl.enable", "true");
		prop.put("mail.smtp.ssl.trust", host);*/
		
		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(email.substring(0,idx), password);
			}
		});
		session.setDebug(true);
		
		try {
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(member.getEmail()));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
			
			msg.setSubject("[doghouse]임시 비밀번호 발송 메일입니다.");
			
			msg.setText("test");
			
			Transport.send(msg);
			System.out.println("The message sent successfully...");
		} catch (Exception e) {
			e.printStackTrace();
		}
		} else {
			RequestDispatcher view = request.getRequestDispatcher("views/member/memberError.jsp");
			request.setAttribute("message", "정보가 일치하지 않습니다.");
			view.forward(request, response);
		}
		
		/*if(result > 0) {
			response.sendRedirect("/doggybeta/views/member/changepws.jsp");
		} else {
			RequestDispatcher view = request.getRequestDispatcher("views/member/memberError.jsp");
			request.setAttribute("message", member.getUserId()+"님의 정보수정에 실패하였습니다.");
			view.forward(request, response);
		}*/
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
