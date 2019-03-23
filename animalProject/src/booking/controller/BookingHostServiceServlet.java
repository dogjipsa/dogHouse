package booking.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import booking.model.service.BookingService;
import booking.model.vo.BookingForHost;

/**
 * Servlet implementation class BookingHostServiceServlet
 */
@WebServlet("/hservice")
public class BookingHostServiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookingHostServiceServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userid = request.getParameter("userid");
		ArrayList<BookingForHost> list = new BookingService().selectBkForHostList(userid);
		if(list.size() > 0) {
			/*JSONObject sendJSON = new JSONObject();
			JSONArray jar = new JSONArray();*/
			System.out.println(list.get(0).getCheckOutDate().getTime() - list.get(0).getCheckInDate().getTime());
			System.out.println((list.get(0).getCheckOutDate().getTime() - list.get(0).getCheckInDate().getTime())/(1000*60*60*24));
		} else {
			System.out.println("접속실패");
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
