package manager.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
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

import freeboard.model.vo.FreeBoard;
import manager.model.dao.ManagerDao;
import manager.model.service.ManagerService;
import manager.model.vo.Manager;

/**
 * Servlet implementation class ManagerBoardListServlet
 */
@WebServlet("/manboard")
public class ManagerBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerBoardListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//관리자 페이지. 게시판 목록 조회용
		request.setCharacterEncoding("UTF-8");
		int pageNumber = 1; //페이지 기본
		/*String pageNumber = request.getParameter("pageNumber");*/
		if(request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		
		int targetPage = new ManagerDao().targetPage(pageNumber);
		
		ArrayList<FreeBoard> managerList = new ManagerService().selectAllBoardList(pageNumber);
		System.out.println(managerList + "<- managerList");
		
		System.out.println("size : " + managerList.size());
		
		/*response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(managerList.size() > 0) {
			view = request.getRequestDispatcher("views/manager/managerAllBoard.jsp");
			request.setAttribute("managerList", managerList);
			view.forward(request, response);
		} else {
			view = request.getRequestDispatcher("views/manager/managerError.jsp");
			request.setAttribute("message", "조회 실패");
			view.forward(request, response);
		}*/
		/*HashMap<String, Object> bmap = new HashMap<> ();
		bmap.put("managerList", managerList);
		System.out.println("bmap : " + bmap);*/
		/*job.putAll(bmap);*/
		JSONObject sendJson = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		SimpleDateFormat sdf = new SimpleDateFormat();
		
		for(FreeBoard fr : managerList) {
			JSONObject frJson = new JSONObject();
			
			frJson.put("freeno", String.valueOf(fr.getFreeboardNo()));
			frJson.put("freetitle", URLEncoder.encode(fr.getFreeboardTitle(), "UTF-8"));
			frJson.put("freecontent", URLEncoder.encode(fr.getFreeboardContent(), "UTF-8"));
			frJson.put("freedate", sdf.format(fr.getFreeboardDate()));
			frJson.put("freeuserid", fr.getUserId());
			frJson.put("freedel", fr.getFreeboardDelete());
			jsonArr.add(frJson);
		} 
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		sendJson.put("managerList", jsonArr);
		sendJson.put("pageNumber", String.valueOf(pageNumber));
		sendJson.put("targetPage", String.valueOf(targetPage));
		
		System.out.println("sjon -> " + sendJson.toJSONString());;
		System.out.println("sjon size : " + sendJson.size());
		out.append(sendJson.toJSONString());
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
