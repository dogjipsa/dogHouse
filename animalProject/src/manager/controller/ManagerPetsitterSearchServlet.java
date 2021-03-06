package manager.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.model.service.ManagerService;
import member.model.vo.Member;

/**
 * Servlet implementation class ManagerPetsitterSearchServlet
 */
@WebServlet("/mpsearch")
public class ManagerPetsitterSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerPetsitterSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int currentPage = 1;
		
		String opt = request.getParameter("opt");
		String inputdata = request.getParameter("inputdata");
	
		if(request.getParameter("page") != null) 
			currentPage = Integer.parseInt(request.getParameter("page"));
			
		HashMap<String, Object> listOpt = new HashMap<>();
		listOpt.put("opt", opt);
		listOpt.put("inputdata", inputdata);
		listOpt.put("startRow", currentPage*10-9);// 1, 11, 21, 31....
		/*System.out.println("listOpt : " + listOpt.get("opt"));*/
		
		ManagerService mservice = new ManagerService();
		
		ArrayList<Member> petsitterList = mservice.selectPetsitterList(listOpt);
		
		
		//한 페이지에 출력할 목록 갯수 지정
		int limit = 10;
		
		//현재 페이지에 출력할 목록 조회
		int listCount =  mservice.getPetsitterListCount(listOpt);
		/*System.out.println("listCount : " + listCount);*/
		//행의 갯수가 101개일 때 다음 페이지로 넘어감.
		
		//총 페이지수 계산 : 1페이지부터 현재페이지까지 페이지 갯수
		//예: 현재 행의갯수 23개면 페이지는 3페이지 = maxPage
		int maxPage = (int)((double)listCount / limit + 0.9); // 1, 2, 3....
		
		//현재 페이지의 시작페이지 번호 1, 11, 21, 31....
		//1페이지 때문에 + 0.9 했네..
		int startPage = (((int)((double)currentPage / limit + 0.9)) - 1) * limit + 1;
		
		//현재 페이지의 끝페이지 번호 10, 20, 30....
		int endPage = startPage + limit -1;		
		
		
		if(maxPage < endPage) {
		endPage = maxPage;
		}
		/*for(Member m : petsitterList) {
			System.out.println("list : " +  m);
		}*/
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(petsitterList.size() >= 0) {
			view = request.getRequestDispatcher("views/manager/managerPetsitterListView.jsp");
		
			request.setAttribute("petsitterList", petsitterList);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("listCount", listCount);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			
			view.forward(request, response);
		}else {
			view = request.getRequestDispatcher(
					"views/manager/managerError.jsp");
			request.setAttribute("message", currentPage + "에 대한 목록 조회 실패!");
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
