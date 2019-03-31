package pet.controller;

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

import pet.model.service.PetService;
import pet.model.vo.Pet;

/**
 * Servlet implementation class SelectPetListServlet
 */
@WebServlet("/gplist")
public class SelectPetListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectPetListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userid = request.getParameter("userid");
		int currentPage = 1;
		int limit = 12;
		int countPage = 3;
		if(request.getParameter("page") != null) 
			currentPage = Integer.parseInt(request.getParameter("page"));
		
		PetService ps = new PetService();
		int totalList = ps.getTotalPetListCount(userid);
		int totalPage = totalList / limit;
		if(totalList % limit > 0)
			totalPage++;
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int startpage = ((currentPage - 1) / 10) * countPage + 1;
		int endpage = startpage + countPage -1;
		
		if(endpage > totalPage)
			endpage = totalPage;
		
		ArrayList<Pet> list = ps.selectPetList(userid, (currentPage - 1) * limit+ 1, currentPage * limit);
		if(list.size() > 0) {
			JSONObject sendJSON = new JSONObject();
			JSONArray jlist = new JSONArray();
			/*PET_NO
			PET_NAME
			PET_BREADS
			PET_DATE
			PET_SIZE
			PET_GENDER
			PET_NEUTRALIZE
			PET_CHARATER
			USER_ID
			PET_ORIGINFILE
			PET_REFILE*/
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy'년 'MM'월 'dd'일'");
			for(Pet p : list) {
				JSONObject job = new JSONObject();
				job.put("pno", p.getPetNo());
				job.put("pname", URLEncoder.encode(p.getPetName(), "utf-8"));
				job.put("breeds", URLEncoder.encode(p.getBreeds(), "utf-8"));
				job.put("birth", sdf.format(p.getPetDate()));
				job.put("size", URLEncoder.encode(p.getPetSize(), "utf-8"));
				job.put("gender", p.getPetGender());
				job.put("neutral", p.getPetNeutralize());
				job.put("userid", p.getUserId());
				job.put("origin", URLEncoder.encode(p.getOriginFileName(), "utf-8"));
				job.put("rename", p.getRenameFileName());
				
				jlist.add(job);
			}
			JSONObject pageJSON = new JSONObject();
			pageJSON.put("page", currentPage);
			pageJSON.put("start", startpage);
			pageJSON.put("end", endpage);
			pageJSON.put("totalpage", totalPage);
			
			sendJSON.put("list", jlist);
			sendJSON.put("plist", pageJSON);
			
			response.setContentType("application/json; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.append(sendJSON.toJSONString());
			out.flush();
			out.close();
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
