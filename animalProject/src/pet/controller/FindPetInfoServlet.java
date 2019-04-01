package pet.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import pet.model.service.PetService;
import pet.model.vo.Pet;

/**
 * Servlet implementation class FindPetInfoServlet
 */
@WebServlet("/fpinfo")
public class FindPetInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FindPetInfoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String petuserid = request.getParameter("petuserid");
		System.out.println("강아지 확인 : " + petuserid);
		JSONObject job = new JSONObject();
		
		Pet pet = new PetService().findPetInfo(petuserid);

		job.put("petimg", URLEncoder.encode(pet.getRenameFileName(), "UTF-8"));	
		job.put("petname", URLEncoder.encode(pet.getPetName(), "UTF-8"));
		job.put("petsize", URLEncoder.encode(pet.getPetSize(), "UTF-8"));
		job.put("breads", URLEncoder.encode(pet.getBreeds(), "UTF-8"));
		job.put("gender", pet.getPetGender());
		job.put("yesorno", pet.getPetNeutralize());
		job.put("petage", pet.getAge());
		job.put("etc", URLEncoder.encode(pet.getPetCharater(), "UTF-8"));


		System.out.println("job : " + job.toJSONString()); 
		//요청한 클라이언트쪽으로 json 객체 전송함
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(job.toJSONString());
		out.flush();
		out.close();
		

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
