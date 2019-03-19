package pet.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pet.model.service.PetService;
import pet.model.vo.Pet;

/**
 * Servlet implementation class PetInsertServlet
 */
@WebServlet("/petins")
public class PetInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PetInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 로그인 유저의 펫 추가 컨트롤러
		request.setCharacterEncoding("utf-8");
		Pet p = new Pet();
		p.setPetNo(Integer.parseInt(request.getParameter("pno")));
		p.setPetName(request.getParameter("pname"));
		p.setPetBreads(request.getParameter("bread"));
		p.setPetDate(request.getParameter("pdate"));
		p.setPetSize(request.getParameter("psize"));
		p.setPetGender(request.getParameter("pgender"));
		p.setPetNeutralize(request.getParameter("pneu"));
		p.setPetCharater(request.getParameter("pchar"));
		p.setUserId(request.getParameter("userid"));
		
		int result = new PetService().myPetInsert(p);

		response.setContentType("text/html; charset=utf-8");
		
		if (result > 0) { // 성공
			response.sendRedirect("/doggybeta/index.jsp");
		} else { // 실패
			RequestDispatcher view = request.getRequestDispatcher("views/pet/petError.jsp"); 
			request.setAttribute("message", "마이 펫 등록 실패");
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
