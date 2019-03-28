package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class PetSitterDetailServlet
 */
@WebServlet("/sitterdetail")
public class PetSitterDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PetSitterDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//펫시터의 저장된 정보를 받아와야 함.
		String petSitterId = "user01";//예를 들어 user01
		//request.getParameter("");//list에서 클릭시 parameter값으로 넘겨 받아야 함.
		Member petSitter = new MemberService().selectDetailPetSitter(petSitterId);
		response.setContentType("text/html; charset=utf-8");
		
		RequestDispatcher view = null;
		view = request.getRequestDispatcher("views/findSitter/petSitterDetailView.jsp");
		System.out.println(petSitter);
		request.setAttribute("petSitter", petSitter);
		view.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
