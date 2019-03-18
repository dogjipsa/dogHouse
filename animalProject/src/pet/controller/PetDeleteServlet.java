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
 * Servlet implementation class PetDeleteServlet
 */
@WebServlet("/petdel")
public class PetDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PetDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 펫정보 삭제용 컨트롤러
		request.setCharacterEncoding("utf-8");
		int pno = Integer.parseInt(request.getParameter("pno"));
		
		int result = new PetService().myPetDelete(pno);

		response.setContentType("text/html; charset=utf-8");
		
		if (result > 0) { // 성공
			response.sendRedirect("/doggybeta/index.jsp");
		} else { // 실패
			RequestDispatcher view = request.getRequestDispatcher("views/pet/petError.jsp"); 
			request.setAttribute("message", "마이 펫 삭제 실패");
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
