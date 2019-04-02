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
import member.model.vo.Member;

import member.model.vo.SitterImage;

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
		String userId = request.getParameter("userid");
		String serviceKind = request.getParameter("service");
		String jido = request.getParameter("jido");
		String detail = request.getParameter("detail");
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("userid", userId);
		map.put("jido", jido);
		map.put("detail", detail);
		
	
		
		ArrayList<Member> list = new MemberService().findPetSitterList(map);//주소에 맞는 펫시터를 찾기
		//System.out.println("서블릿에서 list에 담긴 값 : " + list);
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		String petSitterId = null;
		
		int count = new MemberService().countPetSitter(map);
		//System.out.println("건 수 조회 : " + count);
		HashMap<String, String> img = null;
		ArrayList<SitterImage> imglist = null; 
		ArrayList<String> address = null;
		
		for(Member m : list) {
			petSitterId = m.getUserId();
			//System.out.println("for문 : " + petSitterId);
			imglist = new MemberService().selectSitterFacilityImg(petSitterId);
			
			
			/*img.put(petSitterId, imglist.get(0).getRenameFile());*/
			}
		address = new ArrayList<String>();
		for(int i = 0; i < list.size(); i++) {
		address.add(list.get(i).getAddress());
			//System.out.println("주소 : " + address);
		if(imglist != null) {
		//list.get(i).setTitleImg(imglist.get(i).getRenameFile());
		//System.out.println("컬럼 추가한 이미지 이름 : " + list.get(i).getTitleImg());
		}
		}
		
		//System.out.println("주소 제대로 : " + address);

		
		if(list.size() > 0) {
			view = request.getRequestDispatcher("views/findSitter/petSitterListView.jsp");
			
			//request.setAttribute("map", img);
			request.setAttribute("list", list);		
			request.setAttribute("imglist", imglist);
			request.setAttribute("count", count);
			request.setAttribute("address", address);
			request.setAttribute("service", serviceKind);
			request.setAttribute("petSitterId", petSitterId);//petsitterdetail.jsp로 넘긴 후 
			view.forward(request, response);
		}else {
			PrintWriter out = response.getWriter();
			out.println("<script>alert('검색된 내용이 없습니다.'); location.href='views/findSitter/petSitterListView.jsp';</script>");
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
