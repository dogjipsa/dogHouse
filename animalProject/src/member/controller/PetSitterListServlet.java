package member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import member.model.service.MemberService;
import member.model.vo.SearchingInfo;

/**
 * Servlet implementation class PetSitterListServlet
 */
@WebServlet("/fplist")
public class PetSitterListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PetSitterListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");

		//서비스, 지도, 날짜 넘기고
		String serviceKind = request.getParameter("service");
		String jido = request.getParameter("jido");
		System.out.println("주소 값 : " + jido);
		System.out.println("서비스 종류 : " + serviceKind); //넘어가는 거 확인
		
		ArrayList<SearchingInfo> list = new ArrayList<SearchingInfo>();

		list = new MemberService().findPetSitterList(jido);
		
		System.out.println("펫시터 리스트 서블릿 : " + list);
		

		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		
		if(list.size() > 0) {
			view = request.getRequestDispatcher("views/findSitter/petSitterListView.jsp");
			request.setAttribute("list", list);
			view.forward(request, response);
		}else {
			PrintWriter out = response.getWriter();
			out.println("<script>alert('조건에 맞는 펫시터가 없습니다. 다시 검색 해주세요.'); location.href='views/findSitter/petSitterListView.jsp';</script>");
			out.flush();
		}
		
		
		
		/*//최종적으로 값을 보낼 제이슨
		JSONObject sendJson = new JSONObject();

		//jason 배열을 만들어 준다. list 값을 받을 jason 배열
		JSONArray jsonArr = new JSONArray();
		for(SearchingInfo si : list) {
			JSONObject siJson = new JSONObject();
			
			siJson.put("sitterName", URLEncoder.encode(si.getPuserName(), "UTF-8"));//한글 값은 무조건 형변환
			siJson.put("price", String.valueOf(si.getPrice())); //int를 string으로
			siJson.put("petsitterImg", si.getPuserReFile());
			siJson.put("address", URLEncoder.encode(si.getPuserAddress(), "UTF-8"));
			siJson.put("houseImg", si.getPuserHouseReImage());
			jsonArr.add(siJson);
			
		}
		
		sendJson.put("list", jsonArr);
		
		System.out.println("제이슨 출력 : " + sendJson.toJSONString());
		System.out.println("제이슨 사이즈 : " +  sendJson.size());

		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.append(sendJson.toJSONString());
		out.flush();
		out.close();*/
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
