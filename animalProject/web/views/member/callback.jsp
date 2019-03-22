<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
</head>
<body>
<!-- 	<script type="text/javascript">
		var naver_id_login=new naver_id_login
		({
			clientId: "obXTFPuiHDCuNQb5kAmx",
			callbackUrl: "http://127.0.0.1:8888/doggybeta/index.jsp"
		 }
		);
		naver_id_login.get_naver_userprofile('naverSignInCallback()');
		
		function naverSignInCallback() {
			var id=naver_id_login.getProfileData('id')+'@n';
			var nickname=naver_id_login.getProfileData('name');
			
			$.ajax({
				url: '/doggybeta/memberidchk',
				method: 'post',
				success: function(idChk) {
					if(idChk == true) {//db에 아이디 없을 경우
						console.log('회원가입중');
						$.ajax({
							url: '/doggybeta/resistenroll',
							method: 'post',
							success: function(data) {
								alert('회원가입이 정상적으로 처리되었습니다.');
							}
						})////ajax
					}
					if(idChk == false) { //db에 아이디 있을 경우
						console.log('로그인중');
					}
				}//success 1번
			});//ajax
		}
	</script> -->
 <%
    String clientId = "obXTFPuiHDCuNQb5kAmx";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "gRoBiBR9aR";//애플리케이션 클라이언트 시크릿값";
    String code = request.getParameter("code");
    String state = request.getParameter("state");
    String redirectURI = URLEncoder.encode("http://127.0.0.1:8888/doggybeta/index.jsp", "UTF-8");
    String apiURL;
    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
    apiURL += "client_id=" + clientId;
    apiURL += "&client_secret=" + clientSecret;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&code=" + code;
    apiURL += "&state=" + state;
    String access_token = "";
    String refresh_token = "";
    System.out.println("apiURL="+apiURL);
    try {
      URL url = new URL(apiURL);
      HttpURLConnection con = (HttpURLConnection)url.openConnection();
      con.setRequestMethod("GET");
      int responseCode = con.getResponseCode();
      BufferedReader br;
      System.out.print("responseCode="+responseCode);
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
      if(responseCode==200) {
        out.println(res.toString());
      }
    } catch (Exception e) {
      System.out.println(e);
    }
  %>
</body>
</html>