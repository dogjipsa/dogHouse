package member.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;
import member.model.vo.Member;
import member.model.vo.SitterImage;
import review.model.service.ReviewService;

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
		//petSitterListView.jsp에서 펫시터의 저장된 정보를 받아옴
		String petSitterId = request.getParameter("petSitterId");//예를 들어 user01
		//펫시터의 이름, 나이, 프로필사진, 가격정보, 펫시터 소개 를 조회해서 Member객체에 저장
		Member petSitter = new MemberService().selectDetailPetSitter(petSitterId);
		//펫시터의 시설사진을 조회해서 ArrayList에 저장
		ArrayList<SitterImage> sitterFacilityImg = new MemberService().selectSitterFacilityImg(petSitterId);
		response.setContentType("text/html; charset=utf-8");
		//펫시터의 평균 별점을 조회 해서 double형 데이터 starAvg에 저장
		double starAvg = new ReviewService().selectStarAvg(petSitterId);

		RequestDispatcher view = null;
		view = request.getRequestDispatcher("views/findSitter/petSitterDetailView.jsp");
		request.setAttribute("petSitter", petSitter);
		request.setAttribute("sitterFacilityImg", sitterFacilityImg);
		request.setAttribute("starAvg", starAvg);
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
