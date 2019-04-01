package manager.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import freeboard.model.vo.FreeBoard;
import manager.model.service.ManagerService;

/**
 * Servlet implementation class ManagerFreeBoardTop5
 */
@WebServlet("/mfreetop")
public class ManagerFreeBoardTop5 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ManagerFreeBoardTop5() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// 게시글 조회 많은 순으로 Top5 조회
		ArrayList<FreeBoard> list = new ManagerService().selectReadCountTop5();
		System.out.println("top5 : " + list);

		// 전송할 json 객체 한 개 준비
		JSONObject sendJson = new JSONObject();
		// list 옮겨 저장ㅎ알 json 배열 객체 준비
		JSONArray jsonArr = new JSONArray();

		for (FreeBoard f : list) {
			// b 객체값 저장할 json 객체 준비
			JSONObject job = new JSONObject();
			// 필드값 하나씩 옮겨 담기 : 맵 방식(키, 값)
			job.put("fnum", f.getFreeboardNo());
			job.put("ftitle", URLEncoder.encode(f.getFreeboardTitle(), "utf-8"));
			job.put("frcount", f.getFreeboardViews());

			jsonArr.add(job);
		} // for each
		sendJson.put("freeboardlist", jsonArr);
		System.out.println("sendJson : " + sendJson.toJSONString());

		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.write(sendJson.toJSONString());
		out.flush();
		out.close();
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
