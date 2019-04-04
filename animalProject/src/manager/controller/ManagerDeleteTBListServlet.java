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
 * Servlet implementation class ManagerDeleteTBListServlet
 */
@WebServlet("/mantbdel")
public class ManagerDeleteTBListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ManagerDeleteTBListServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		//팁게시판 관리자 게시물 삭제 처리용 컨트롤러
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String[] delNo = request.getParameterValues("delNo[]");
		System.out.println(delNo);
		int result = 0;

		for (int i = 0; i < delNo.length; i++) {
			result = new ManagerService().managerDeleteTipBoard(delNo[i]);
		}
		PrintWriter out = response.getWriter();
		if (result > 0) {
			out.println("y");
		} else {
			out.print("n");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
