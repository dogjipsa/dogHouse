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

import faq.model.vo.Faq;
import freeboard.model.vo.FreeBoard;
import manager.model.dao.ManagerDao;
import manager.model.service.ManagerService;
import manager.model.vo.Manager;
import notice.model.vo.Notice;
import tipboard.model.vo.TipBoard;

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
		ManagerService ms = new ManagerService();
		request.setCharacterEncoding("UTF-8");
		int currentPage = 1; //페이지 기본
		/*String pageNumber = request.getParameter("pageNumber");*/
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		// 한 페이지에 출력될 게시물 수 -> pageList
		// 한 화면에 출력될 페이지 수 -> countPage
		// 나머지가 있을 경우에만 +1
		int listCount = ms.boardListCount(); //총 게시글 수
				
		int pageList = 10; //원하는 출력 개수
		
		//현재 페이지에 출력할 목록 조회
		int totalPage = listCount / pageList;
		if(listCount % pageList > 0)
			totalPage ++;
		
		//현재 페이지번호가 토탈쪽수보다 크다면
		if(totalPage < currentPage)
			totalPage = currentPage;
		
		int startPage = ((currentPage - 1) / 10) * 10 + 1;//시작페이지
		int endPage = startPage + pageList - 1;//끝페이지
		
		//끝 페이지가 총 페이지보다 크다면
		if(endPage > totalPage)
			endPage = totalPage;
		
		ArrayList<FreeBoard> fList = ms.selectFreeBoardList(currentPage, pageList);
		ArrayList<TipBoard> tList = ms.selectTipBoardList(currentPage, pageList);
		System.out.println(tList);
		ArrayList<Faq> faqList = ms.selectFAQList(currentPage, pageList);
		
		
		response.setContentType("text/html; charset=utf-8");
		RequestDispatcher view = null;
		if(fList.size() >= 0) {
			view = request.getRequestDispatcher("views/manager/managerAllBoard.jsp");
			request.setAttribute("flist", fList);
			request.setAttribute("faqlist", faqList);
			
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("listCount", listCount);
			view.forward(request, response);
		} else if(tList.size() >= 0) {
			request.setAttribute("tlist", tList);
		} else if(faqList.size() >= 0) {
			
		}
		
		
		
		else {
			view = request.getRequestDispatcher("views/manager/managerError.jsp");
			request.setAttribute("message", currentPage + "쪽 목록 조회 실패");
			view.forward(request, response);
		}
		
		/*System.out.println("size : " + managerList.size());*/
		
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
		/*ArrayList<FreeBoard> managerList = new ManagerService().selectAllBoardList();
		System.out.println(managerList + "<- managerList");
		
		JSONObject sendJson = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		
		SimpleDateFormat sdf = new SimpleDateFormat();
		
		for(FreeBoard fr : managerList) {
			JSONObject frJson = new JSONObject();
			
			frJson.put("freeno", String.valueOf(fr.getFreeboardNo())); //int -> String
			frJson.put("freetitle", URLEncoder.encode(fr.getFreeboardTitle(), "UTF-8"));
			frJson.put("freecontent", URLEncoder.encode(fr.getFreeboardContent(), "UTF-8"));
			frJson.put("freedate", sdf.format(fr.getFreeboardDate())); //date -> String
			frJson.put("freeuserid", fr.getUserId());
			frJson.put("freedel", fr.getFreeboardDelete());
			jsonArr.add(frJson);
		} 
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		sendJson.put("managerList", jsonArr);
		
		System.out.println("sjon -> " + sendJson.toJSONString());;
		System.out.println("sjon size : " + sendJson.size());
		out.append(sendJson.toJSONString());*/
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
