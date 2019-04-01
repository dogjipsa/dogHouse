package pet.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import pet.model.service.PetService;
import pet.model.vo.SubInfo;

/**
 * Servlet implementation class SelectPetSubInfoServlet
 */
@WebServlet("/gsinfo")
public class SelectPetSubInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SelectPetSubInfoServlet() {
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
		int pno = Integer.parseInt(request.getParameter("pno"));
		SubInfo sub = new PetService().selectOnePet(userid, pno);
		Date sbirth = sub.getPetDate();
		Calendar c = Calendar.getInstance();
		c.setTime(sbirth);
		int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH) + 1;
		int day = c.get(Calendar.DAY_OF_MONTH);
		int age = getAge(year, month, day);
		if (sub != null) {
			JSONObject j = new JSONObject();
			j.put("pname", URLEncoder.encode(sub.getPetName(), "utf-8"));
			j.put("age", age);
			j.put("phone", sub.getPhone());
			j.put("breeds", sub.getBreeds());
			j.put("img", sub.getRenameFileName());
			
			response.setContentType("application/json; charset=utf-8");
			PrintWriter out = response.getWriter(); 
			out.append(j.toJSONString());
			out.flush();
			out.close();
		} else {
			System.out.println("펫 정보 없음");
		}
	}

	public int getAge(int birthYear, int birthMonth, int birthDay) {
		Calendar current = Calendar.getInstance();
		int currentYear = current.get(Calendar.YEAR);
		int currentMonth = current.get(Calendar.MONTH) + 1;
		int currentDay = current.get(Calendar.DAY_OF_MONTH);

		int age = currentYear - birthYear;
		// 생일 안 지난 경우 -1
		if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay)
			age--;

		return age;
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
