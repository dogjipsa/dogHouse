<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import='member.model.vo.Member' %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	String access_token = (String)session.getAttribute("access_token");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/doggybeta/resources/css/psForm.css">
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" />
<link href='/doggybeta/resources/css/login.css' rel='stylesheet' type='text/css'>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Sunflower:300,500,700&amp;subset=korean" rel="stylesheet">
<link href="/doggybeta/resources/css/mainV2.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script type="text/javascript">
	 $(function() {
 		$('.login-form').hide();
		 
		$('.btn').click(function() {
			$('body').append('<div id="mask"></div>');
		    $('#mask').fadeIn(300);
		    $('.login-form').fadeIn(300);
			$('.login-form').show();
			
		    $('#mask').click(function() {
		    	$('#mask, .login-form').fadeOut(300);
		    });
		    
		});
	});

</script>
<style>
</style>
</head>
<body>

	<% if(loginUser == null ) { %>
	<input type='checkbox' id='menu_state' checked />
	<div id='mask'> </div>
	<nav>
		<ul class='doghouse'>
			<li><a><span>doghouse</span></a></li>
		</ul>
		<span class='btn btn-1 btn-sign'>회원가입/로그인</span>
		<!-- ---------------------------------------------------------------------------- -->
		<!-- MENU -->
		<ul class='icon' id='icon'>
			<li><a href='/doggybeta' id='icon1'> <span>&nbsp;&nbsp;&nbsp;홈</span>
			</a></li>
			<li class="m1"><a
				href="#" id='icon2'><span>&nbsp;&nbsp;&nbsp;About
						us</span></a>
				<ul class="m2">
					<li><a href="/doggybeta/views/aboutus/companyIntroduce.jsp">회사소개</a></li>
					<li><a>연혁</a></li>
					<li><a href="/doggybeta/views/aboutus/teamIntroduce.jsp">팀
							도그집사</a></li>
					<li><a href="/doggybeta/views/aboutus/location.jsp">오시는 길</a></li>
				</ul></li>
			<li><a href='/doggybeta/views/findSitter/petSitterListView.jsp' id='icon3'> <span>&nbsp;&nbsp;&nbsp;펫시터	찾기</span></a> </li>
			<li class="m1"><a href='#'  id='icon4'> <span>&nbsp;&nbsp;&nbsp;게시판</span>
			</a>
				<ul class="m2">
					<li><a href='/doggybeta/nlist'>공지사항</a></li>
					<li><a href='/doggybeta/flist'>자유게시판</a></li>
					<li><a href='/doggybeta/tlist'>팁</a></li>
				</ul></li>
			<li class="m1"><a href="#" id='icon5'> <span>&nbsp;&nbsp;&nbsp;고객센터</span></a>
				<ul class="m2">
					<li><a href='/doggybeta/faqlist'>FAQ</a></li>
					<li><a href='#'>이용방법</a></li>
					<li><a href='#'>1:1문의</a></li>
				</ul></li>

			<li class="m1"><a href="#" id='icon6'><span>&nbsp;&nbsp;&nbsp;마이페이지</span></a>
				<ul class="m2">
					<li><a href='#'>정보수정</a></li>
					<li><a href='#'>이용내역/예약확인</a></li>
					<li><a href='#' id="pet_reg__btn">펫시터신청</a></li>
					<li><a href='#'>사전문의확인</a></li>
				</ul></li>

		</ul>
	</nav>
	<!-- Login Form ---------------------------------------------------------------------------- -->
	<form class="login-form" method='post' action='/doggybeta/jipsalogin'>
    <!-- <img id='cancelBtn' src='/doggybeta/resources/images/cancel-button.jpg'> -->
  			<p class="login-text">
  				DOGHOUSE
  			</p> 
  			<input type="text" name='userid' id='userid' class="login-username" autofocus required placeholder="Email" />
  			<input type="password" name='userpwd' id='passwd' class="login-password" required required placeholder="Password" />
  			<a href='/doggybeta/jipsalogin'>
  			<input type="submit" name="Login" value="Login" class="login-submit" id='btnLogin'/></a><br>
			<a href='/doggybeta/views/member/termsOfService.jsp'>
			<input type="button" name='enroll' value='회원가입' class='login-submit' id='btnEnroll'/></a>
			<p align='center' id='orid'>------- 또는 -------</p>
			<!-- http://127.0.0.1:8888/doggybeta/views/member/callback.jsp -->
			<%
   				 String clientId = "obXTFPuiHDCuNQb5kAmx";//애플리케이션 클라이언트 아이디값";
   				 String redirectURI = URLEncoder.encode("http://127.0.0.1:8888/doggybeta/naverlogin", "UTF-8");
   				 SecureRandom random = new SecureRandom();
   				 String state = new BigInteger(130, random).toString();
   				 String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
   				 apiURL += "&client_id=" + clientId;
   				 apiURL += "&redirect_uri=" + redirectURI;
   				 apiURL += "&state=" + state;
   				 session.setAttribute("state", state);
    		 %>
			<a href="<%=apiURL%>"><img style='position:relative;' height="47" width='240' src="/doggybeta/resources/images/naverButton/네이버 아이디로 로그인_완성형_White.PNG"/></a> 
			<br>
			<br>
  			<a href="/doggybeta/views/member/findPassword.jsp" class="login-forgot-pass" id='tempPwd'>비밀번호를 잊으셨나요?</a>
	</form>
	<script type="text/javascript">
	$('.m1').click(function() {
		if ($(this).children('.m2').is(':visible')) {
			$(this).children('.m2').slideUp(200);
		} else {
			$(this).children('.m2').slideDown(200);
		}
	});
	</script>
	<% } else { %>
	
	
	
	
		<%= loginUser.getUserId() %> 님 환영합니다
		<a href='/doggybeta/jipsalogout'>로그아웃</a>
		<input type='checkbox' id='menu_state' checked />
	<nav>
		<ul class='doghouse'>
			<li><a><span><img src="/doggybeta/resources/images/로고test2.png" style="margin-left: 50px; padding: 10px 10px;" width="80px"></span></a></li>
		</ul>
		<a  href='/doggybeta/jipsalogout'><span class='btn btn-1 btn-sign'>로그아웃</span></a>
		<%= loginUser.getUserId() %>
		<%= access_token %>님 환영해요!
		<!-- ---------------------------------------------------------------------------- -->
<!-- 		<a href="#" class="login-forgot-pass">forgot password?</a>
		<div class="underlay-photo"></div>
		<div class="underlay-black"></div>  -->
		<!-- -------------------------------------------------------------------------  -->
		<ul class='icon' id='icon'>
			<li><a href='/doggybeta' id='icon1'> <span>&nbsp;&nbsp;&nbsp;홈</span>
			</a></li>
			<li class="m1"><a
				href="/doggybeta/views/aboutus/companyintroduce.jsp" id='icon2'><span>&nbsp;&nbsp;&nbsp;About
						us</span></a>
				<ul class="m2">
					<li><a href="/doggybeta/views/aboutus/companyIntroduce.jsp">회사소개</a></li>
					<li><a>연혁</a></li>
					<li><a href="/doggybeta/views/aboutus/teamIntroduce.jsp">팀
							도그집사</a></li>
					<li><a href="/doggybeta/views/aboutus/location.jsp">오시는 길</a></li>
				</ul></li>
			<li><a href='/doggybeta/views/findSitter/petSitterListView.jsp' id='icon3'> <span>&nbsp;&nbsp;&nbsp;펫시터	찾기</span></a> </li>
			<li class="m1"><a href='#'  id='icon4'> <span>&nbsp;&nbsp;&nbsp;게시판</span>
			</a>
				<ul class="m2">
					<li><a href='/doggybeta/nlist'>공지사항</a></li>
					<li><a href='/doggybeta/flist'>자유게시판</a></li>
					<li><a href='/doggybeta/tlist'>팁</a></li>
				</ul></li>
			<li class="m1"><a href="#" id='icon5'> <span>&nbsp;&nbsp;&nbsp;고객센터</span></a>
				<ul class="m2">
					<li><a href='/doggybeta/faqlist'>FAQ</a></li>
					<li><a href='#'>이용방법</a></li>
					<li><a href='#'>1:1문의</a></li>
				</ul></li>

			<li class="m1"><a href="#" id='icon6'><span>&nbsp;&nbsp;&nbsp;마이페이지</span></a>
				<ul class="m2">
					<li><a href='#'>정보수정</a></li>
					<li><a href='/doggybeta/views/customerservice/checkMyLog.jsp'>이용내역/예약확인</a></li>
					<li><a href='#' id="pet_reg__btn">펫시터신청</a></li>
					<li><a href='#'>사전문의확인</a></li>
				</ul></li>
		</ul>
	</nav>
	
	<!-- 펫시터 신청 버튼 클릭시 생성 보여지는 HTML 부분. 로그인 부분 구현시 인풋에 세션으로 값 넣어놓고 readonly 처리할 것  -->
		
			<form class="ps_reg_form" action="/doggybeta/hostup" method="POST" enctype="multipart/form-data">
			<span class="close">x</span>
				<div class="section1">
					<p>아이디</p>
					<input name="userid" value="<%=loginUser.getUserId() %>"  class="ps_input input_id" autocomplete="off" readonly>
					<p>이름</p>
					<input name="username" value="<%=loginUser.getUserName() %>"  class="ps_input input_name" autocomplete="off" >
					<p>연락처</p>
					<input name="phone" value="<%=loginUser.getPhone() %>" class="ps_input input_phone" autocomplete="off" >
					<p>이메일</p>
					<input name="email" value="<%=loginUser.getEmail() %>" class="ps_input input_email" autocomplete="off" >
				</div>
				<div class="section2">
					<p>펫시팅 장소</p>
					<input name="addr" placeholder="장소/위치 입력" class="ps_input input_addr" autocomplete="off" >
					<p>희망 일급(원)</p>
					<input type="number" name="price" placeholder="가격 입력" class="ps_input input_price" min="100">
				</div>
				<div class="section3">
					<div class="image_box">
						<img class="image_box_pic" />				
						<input type="file" id="real-file" name="pic" hidden="hidden" />
						<span>
							<button type="button" id="fake-file-btn" class="normal_btn">Choose a File</button>&nbsp;
							<span id="file-text"></span>
						</span>
					</div>
					<div class="map_box"></div>
					<span><button id="submit-btn">펫시터 등록하기</button></span>
				</div>
				
				<div class="ps_reg_form_popup_box">
					<p>펫시터 등록 신청이 완료되었습니다. </p>
					<button type="submit">확인</button>
				</div>
			</form>

		<script type="text/javascript"src="/doggybeta/resources/js/petSitting.js"></script>
	
	<script type="text/javascript">

	$('.m1').click(function() {
		if ($(this).children('.m2').is(':visible')) {
			$(this).children('.m2').slideUp(200);
		} else {
			$(this).children('.m2').slideDown(200);
		}
	});
	</script>
		<% } %>
</body>
</html>