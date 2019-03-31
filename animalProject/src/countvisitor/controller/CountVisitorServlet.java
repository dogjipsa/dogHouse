package countvisitor.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;

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
    	java.sql.Date sqlDate = new java.sql.Date(today.getTime());
		
		CountService cntService = new CountService();
		CountVisitor cntList = cntService.selectCntVisitor(sqlDate);
		System.out.println(cntList + " <- servlet size");
		if(cntList != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("application/json; charset=utf-8");
			JSONObject job = new JSONObject();
			job.put("cnt", cntList.getCountVisitor());
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
