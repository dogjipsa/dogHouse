package booking.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import booking.model.service.BookingService;
import booking.model.vo.BookingCheck;

/**
 * Servlet implementation class BookingLogListServlet
 */
@WebServlet("/bklist")
public class BookingLogListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BookingLogListServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userid = request.getParameter("userid");
		int currentPage = 1;
		int limit = 2;
		int countPage = 10;
		if (request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		BookingService bs = new BookingService();
		int totalCount = bs.getTotalListCount(userid);
		int totalPage = totalCount / limit;
		if (totalCount % limit > 0) {
			totalPage++;
		}
		if (currentPage > totalPage) {
			currentPage = totalPage;
		}

		int startPage = ((currentPage - 1) / 10) * countPage + 1;
		int endPage = startPage + countPage - 1;

		if (endPage > totalPage) {
			endPage = totalPage;
		}
		/*
		 * System.out.println("현재 페이지: "+currentPage);
		 * System.out.println("총 리스트 수: "+totalCount);
		 * System.out.println("페이지 출력 수: "+countPage);
		 * System.out.println("리스트 출력 수: "+limit);
		 * System.out.println("시작 페이지 : "+startPage);
		 * System.out.println("마지막 페이지: "+endPage);
		 * System.out.println("총 페이지 : "+totalPage);
		 */

		ArrayList<BookingCheck> list = bs.selectBkList(userid, (currentPage - 1) * limit + 1, currentPage * limit);

		if (list.size() > 0) {
			JSONObject sendJSON = new JSONObject();
			JSONArray ar = new JSONArray();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy'년 'MM'월 'dd'일'");
			for (BookingCheck bc : list) {
				JSONObject job = new JSONObject();
				job.put("bno", bc.getBookingNo());
				String indate = sdf.format(bc.getCheckInDate());
				String outdate = sdf.format(bc.getCheckOutDate());

				job.put("indate", indate);
				job.put("outdate", outdate);
				job.put("progress", bc.getBookingProgress());
				job.put("puserid", bc.getPuserId());
				int price = bc.getPrice();
				if (bc.getServiceKind().equals("0") || bc.getServiceKind().equals("2")) {
					price *= 0.8; // 당일 상품 20% 낮은 가격
					price = (int) Math.floor(price / 1000) * 1000; // 천단위 절사
				} else {
					price = (int) ((bc.getCheckOutDate().getTime() - bc.getCheckInDate().getTime())/ (1000 * 60 * 60 * 24)) * bc.getPrice();
				}
				job.put("price", price);
				job.put("addr", URLEncoder.encode(bc.getAddress(), "utf-8"));
				job.put("pname", URLEncoder.encode(bc.getPetName(), "utf-8"));
				job.put("kind", bc.getServiceKind());

				ar.add(job);
			}
			JSONObject pageJson = new JSONObject();
			pageJson.put("page", currentPage);
			pageJson.put("start", startPage);
			pageJson.put("end", endPage);
			pageJson.put("totalpage", totalPage);
			
			sendJSON.put("list", ar);
			sendJSON.put("plist", pageJson);
			response.setContentType("application/json; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.append(sendJSON.toJSONString());
			out.flush();
			out.close();
		} else {
		}
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
