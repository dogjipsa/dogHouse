package member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import member.model.dao.MemberDao;
import member.model.service.MemberService;
import member.model.vo.MakeNaverId;
import member.model.vo.Member;

/**
 * Servlet implementation class NaverLoginServlet
 */
@WebServlet("/naverlogin")
public class NaverLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NaverLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		

		/*String token = "AAAAN1mgvQBBB9WsOFcGL0oppz4e-6w0WxzhOaM6RCXi7JIIs57tLhSUcPQabJIlP9pQ0CIb6Suos2JpnL9qxYtJOys";// 네이버 로그인 접근 토큰;
        String header = "Bearer " + token; // Bearer 다음에 공백 추가
        System.out.println("TOKEN : " + token);
        try {
            String apiURL = "https://openapi.naver.com/v1/nid/me";
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("Authorization", header);
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer rEsponse = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                rEsponse.append(inputLine);
            }
            br.close();
            System.out.println(rEsponse.toString());
            
            
            
        } catch (Exception e) {
            System.out.println(e);
        }*/
		/*response.getWriter().append("Served at: ").append(request.getContextPath());*/
		String clientId = "obXTFPuiHDCuNQb5kAmx";
		String clientSecret = "gRoBiBR9aR"; 
				/*URLEncoder.encode("gRoBiBR9aR", "UTF-8");*/
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		String redirectURI = URLEncoder.encode("http://127.0.0.1:8888/doggybeta/","UTF-8");
		StringBuffer apiURL = new StringBuffer();
		apiURL.append("https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&");
		apiURL.append("client_id=" + clientId);
		apiURL.append("&client_secret=" + clientSecret);
		apiURL.append("&redirect_uri=" + redirectURI);
		apiURL.append("&code=" + code);
		apiURL.append("&state=" + state);
		String access_token = "";
		String refresh_token = ""; //나중에 이용합시다
		System.out.println("1. apiRL : " + apiURL.toString());
		
		try {
			URL url = new URL(apiURL.toString());
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode == 200) // 정상적으로 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			else //에러
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			
			 String inputLine;
		      StringBuffer res = new StringBuffer();
		      while ((inputLine = br.readLine()) != null) {
		        res.append(inputLine);
		      }
		      br.close();
		      if(responseCode==200) {
		        System.out.println(res.toString());
		        JSONParser parsing = new JSONParser();
		        Object obj = parsing.parse(res.toString()); //업캐스팅
		        JSONObject jsonObj = (JSONObject)obj; //다운캐스팅
		        
		       /* JSONObject jsonObj = (JSONObject)parsing.parse(res.toString());*/
		        access_token = (String)jsonObj.get("access_token");
		        refresh_token = (String)jsonObj.get("refresh_token");
		        
		        /*System.out.println("AT : " + access_token);
		        System.out.println("FT : " + refresh_token);*/ //토큰값 잘 나옴
		        
		        /*HttpSession session = request.getSession();
				session.setAttribute("access_token", access_token);
				session.setAttribute("refresh_token", refresh_token);
				
		        response.sendRedirect("/doggybeta/resistenroll");*/
		      }
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 여기까지해도 response 리다이렉트하는 페이지에서 토큰값 꺼내서 볼 수 있음
		
		if(access_token != null) { //접근 토큰이 제대로 생성되었다면 아래 절차 진행
		String token = access_token;// 네이버 로그인 접근 토큰;
		String header = "Bearer " + token; // Bearer 다음에 공백 추가
		try {
		    String apiurl = "https://openapi.naver.com/v1/nid/me";
		    URL url = new URL(apiurl);
		    HttpURLConnection con = (HttpURLConnection)url.openConnection();
		    con.setRequestMethod("GET");
		    con.setRequestProperty("Authorization", header);
		    int responseCode = con.getResponseCode();
		    BufferedReader br;
		    if(responseCode==200) { // 정상 호출
		        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
		    } else {  // 에러 발생
		        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
		    }
		    String inputLine;
		    StringBuffer res = new StringBuffer();
		    while ((inputLine = br.readLine()) != null) {
		        res.append(inputLine);
		    }
		    br.close();
		    
		    JSONParser parsing = new JSONParser();
		    Object obj = parsing.parse(res.toString());
		    JSONObject jsonObj = (JSONObject)obj;
		    
		    JSONObject resObj = (JSONObject)jsonObj.get("response");
		    
		    String naverCode = (String)resObj.get("id");
		    String email = (String)resObj.get("email");
		    String name = (String)resObj.get("name");
		    String nickName = (String)resObj.get("nickname");
		    
		    System.out.println("*** email : " + email);
		    
		    String naverRanId = new MakeNaverId().toString(); //랜덤아이디 생성
		    
		    MemberService mService = new MemberService();
		    Member member = new Member();
		    /*member.setUserId(id); 고유식별자*/
		    int re = mService.selectCheckNaverCode(naverCode);
		    if(re >= 0) {
		    	member.setEmail(email);
		    	member.setNaverCode(naverCode);
		    	member.setUserId(naverRanId);
		    	System.out.println("member : " + member.toString());
		    	int result = mService.insertMember(member);
		    	System.out.println("인서트 완료");
		    	
		    	if(result > 0) {
		    		HttpSession session = request.getSession();
		    		RequestDispatcher views = request.getRequestDispatcher("/jipsalogin");
		    		if(name == null) {
		    			/*session.setAttribute("nickname", nickName);*/
		    			request.setAttribute("nickname", nickName);
		    		} else {
		    			/*session.setAttribute("name", name);*/
		    			request.setAttribute("name", name);
		    		}
		    		request.setAttribute("access_token", access_token);
		    		request.setAttribute("naverId", naverRanId);
		    		request.setAttribute("email", email);
		    		views.forward(request, response);
		    		/*session.setAttribute("access_token", access_token);
			    	session.setAttribute("naverId", naverRanId);
			    	session.setAttribute("email", email);*/
			    	
			    	
			    	/*response.sendRedirect("/doggybeta/views/common/menu.jsp");*/
		    	}
		    
		    } else {
		    	RequestDispatcher view = request.getRequestDispatcher("/jipsalogin");
		    	request.setAttribute("access_token", access_token);
		    	request.setAttribute("naverId", naverRanId);
				/*request.setAttribute("message", "이미 가입한 계정입니다.");*/
				view.forward(request, response);
		    }
			/*session.setAttribute("access_token", access_token);
			session.setAttribute("refresh_token", refresh_token);*/
		    
		    
		    System.out.println(res.toString());
		} catch (Exception e) {
		    System.out.println(e);
		}
		}
		
		
		/*System.out.println("2. access_token : " + access_token);
		
		String str = access_token.replace("access_token", "");
		access_token = str.replace(":", "");
		str = access_token.replace("\"", "");
		access_token = str.replace(",", "");
		
		String token = access_token; //네이버 로그인 접근 토큰
		String header = "Bearer " + token; //Bearer 다음 공백 있어야 함
		String apiUrl = apiURL.toString();*/
		
		/*try {
			apiUrl = "https://openapi.naver.com/v1/nid/me";
			URL url = new URL(apiUrl);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", header);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode == 200)
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			else
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			
			String inputLine;
			String resStr = "[";
			while((inputLine = br.readLine()) != null) {
				resStr += inputLine;
			}
			resStr += "]";
			
			String temp = resStr.replace("responseCode=200", "");
			br.close();*/
			
			/*System.out.println("*** token : " + token);
			System.out.println("*** apiURL : " + apiUrl);
			System.out.println("*** header : " + header);
			response.setContentType("text/html; charset=utf-8");*/
			
			/*JSONObject sendJson = new JSONObject();
			
			JSONArray json = new JSONArray();
			json.add(temp);
			
			JSONObject job = (JSONObject) json.get(0);
			String respon = "[" + job.get("response") + "]";
			JSONArray responJson = new JSONArray();
			responJson.add(respon);
			JSONObject responJob = (JSONObject) responJson.get(0);
			String email = (String) responJob.get("email");
			
			System.out.println(email);
			
			PrintWriter out = response.getWriter();
			out.println(json);*/
			
		/*} catch (Exception e) {
			e.printStackTrace();
		}*/
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
