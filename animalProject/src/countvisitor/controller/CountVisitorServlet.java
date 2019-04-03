package countvisitor.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import countvisitor.model.dao.CountVisitorDao;
import countvisitor.model.service.CountService;
import countvisitor.model.vo.CountVisitor;

/**
 * Servlet implementation class CountVisitorService
 */
@WebServlet("/cntserve")
public class CountVisitorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CountVisitorServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/*CountVisitorDao cvDao = new CountVisitorDao();*/
		Date today = new Date();
		//오늘날짜
    	java.sql.Date sqlDate = new java.sql.Date(today.getTime());
    	//어제날짜
    	Calendar yDate = new GregorianCalendar();
    	yDate.add(Calendar.DATE, -1);
    	Date yd = yDate.getTime();
		java.sql.Date ysDate = new java.sql.Date(yd.getTime());
		//그냥 토탈
		
		

		CountService cntService = new CountService();
		CountVisitor cntToday = cntService.selectCntVisitor(sqlDate);
		CountVisitor cntYesterday = cntService.selectCntVisitor(ysDate);
		CountVisitor cntTotal = cntService.sumOfVisitor();
		
		if(cntToday != null || cntYesterday != null) {

			PrintWriter out = response.getWriter();
			response.setContentType("application/json; charset=utf-8");
			JSONObject job = new JSONObject();
			if(cntToday == null) {
				job.put("cntToday", 0);
			} else {
				job.put("cntToday", cntToday.getCountVisitor());
			}
			if(cntYesterday == null) {
				job.put("cntYesterday", "0");
			} else {
				job.put("cntYesterday", cntYesterday.getCountVisitor());
			}
			if(cntTotal == null) {
				job.put("cntTotal", "0");
			} else {
				job.put("cntTotal", cntTotal.getCountVisitor());
			}
			
			System.out.println(job.toJSONString() + " <- job");
			out.println(job.toJSONString());
			
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
