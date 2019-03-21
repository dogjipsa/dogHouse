<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import='member.model.vo.Member' %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <script type="text/javascript" src='/doggybeta/resources/js/loginSource.js'></script> -->
<link rel="stylesheet" href="/doggybeta/resources/css/psForm.css">
<link href='/doggybeta/resources/css/login.css' rel='stylesheet' type='text/css'>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" />
<link href="/doggybeta/resources/css/mainV2.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>

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
		
		$('#btnLogin').click(function(){
			var userid = $('#userid').val();
			var passwd = $('#passwd').val();
			
			if(userid == "") {
				$('#userid').focus();
				return;
			}
			/* var exp = '/[a-z0-9]$/';
			if(!exp.test(userid)) {
				$('#userid').focus();
				return;
			} */
			
			if(passwd == "") {
				$('#passwd').focus();
				return;
			}
			
			var data = "userid="+userid+"&passwd="+passwd;
			alert(userid+passwd);
			
			$.ajax({
				type: 'post',
				data: {userid : $('#userid').val(), passwd : $('#passwd').val() },
				url: '/doggybeta/jipsalogin',
				success: function(value) {
					alert('사용할 수 있는 아이디입니다.');
				}//success
			});//ajax
		})//login btn
	});
	

</script>
<style>

</style>
</head>
<body>
	<% if(loginUser == null) { %>
	<input type='checkbox' id='menu_state' checked />
	<div id='mask'> </div>
	<nav>
		<ul class='doghouse'>
			<li><a><span>doghouse</span></a></li>
		</ul>
		<span class='btn btn-1 btn-sign'>회원가입/로그인</span>
		<!-- ---------------------------------------------------------------------------- -->
<!-- 		<a href="#" class="login-forgot-pass">forgot password?</a>
		<div class="underlay-photo"></div>
		<div class="underlay-black"></div>  -->
		<!-- -------------------------------------------------------------------------  -->
		<ul class='icon' id='icon'>
			<!-- <li><img id='logo' src='/doggybeta/resources/images/doglogo.png'
				width='80%' /><a><span>doghouse</span> </a></li> -->

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
			<li><a href='#' id='icon3'> <span>&nbsp;&nbsp;&nbsp;펫시터	찾기</span></a> </li>
			<li class="m1"><a href='#'  id='icon4'> <span>&nbsp;&nbsp;&nbsp;게시판</span>
			</a>
				<ul class="m2">
					<li><a href='/doggybeta/nlist'>공지사항</a></li>
					<li><a href='#'>자유게시판</a></li>
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
	<!-- ------------------------------------------------- -->
	<form class="login-form" method='post' action='/doggybeta/jipsalogin'>
  			<p class="login-text">
    			<span class="fa-stack fa-lg">
      				<i class="fa fa-circle fa-stack-2x"></i>
      				<i class="fa fa-lock fa-stack-1x"></i>
    			</span>
  			</p>
  			<input type="text" name='userid' id='userid' class="login-username" autofocus required placeholder="Email" />
  			<input type="password" name='userpwd' id='passwd' class="login-password" required required placeholder="Password" />
  			<a href='/doggybeta/jipsalogin'>
  			<input type="submit" name="Login" value="Login" class="login-submit" id='btnLogin'/></a>
			<a href='/doggybeta/views/member/enroll.html'>
			<input type="button" name='enroll' value='회원가입' class='login-submit' id='btnEnroll'/>
			</a>
  			
  			&nbsp;
  			<a href="/doggybeta/views/member/findPassword.jsp" class="login-forgot-pass" id='tempPwd'>forgot password?</a>
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
		<%-- <%= loginUser.getUserId() %> 님 환영합니다
		<a href='/doggybeta/jipsalogout'>로그아웃</a> --%>
		<input type='checkbox' id='menu_state' checked />
	<nav>
		<ul class='doghouse'>
			<li><a><span>doghouse</span></a></li>
		</ul>
		<a  href='/doggybeta/jipsalogout'><span class='btn btn-1 btn-sign'>로그아웃</span></a>
		<%= loginUser.getUserId() %>
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
			<li><a href='#' id='icon3'> <span>&nbsp;&nbsp;&nbsp;펫시터	찾기</span></a> </li>
			<li class="m1"><a href='#'  id='icon4'> <span>&nbsp;&nbsp;&nbsp;게시판</span>
			</a>
				<ul class="m2">
					<li><a href='/doggybeta/nlist'>공지사항</a></li>
					<li><a href='#'>자유게시판</a></li>
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
		<div class="ps_reg_form" >
			<span class="close">x</span>
				<div class="section1">
					<p>아이디</p>
					<input name="userid" value="<%=loginUser.getUserId() %>"  class="ps_input input_id" autocomplete="off" readonly>
					<p>이름</p>
					<input name="username" value="<%=loginUser.getUserName() %>"  class="ps_input input_name" autocomplete="off" >
					<p>회원 약관</p>
					<button class="normal_btn">내용보기</button>
					<p>개인 정보 수집</p>
					<button class="normal_btn">내용보기</button>
					<p>제 3자 개인 정보 제공</p>
					<button class="normal_btn">내용보기</button>
					<p>전체 동의 여부</p>
					<span><label>
					<input type="radio" name="agree" value="agree" checked> 동의
					</label><label>
					<input type="radio" name="agree" value="disagree"> 동의하지않음
					</label></span>
				</div>
				<div class="section2">
					<p>연락처</p>
					<input name="phone" value="<%=loginUser.getPhone() %>" class="ps_input input_phone" autocomplete="off" >
					<p>이메일</p>
					<input name="email" value="<%=loginUser.getEmail() %>" class="ps_input input_email" autocomplete="off" >
					<p>펫시팅 장소</p>
					<input name="addr" placeholder="장소/위치 입력" class="ps_input input_addr" autocomplete="off" >
					<p>희망 일급(원)</p>
					<input type="number" name="price" placeholder="가격 입력" class="ps_input input_price" min="100" step="100">
				</div>
				<div class="section3">
					<div class="image_box">
						<img class="image_box_pic" />				
						<input type="file" id="real-file" hidden="hidden" />
						<span>
							<button type="button" id="fake-file-btn" class="normal_btn">Choose a File</button>&nbsp;
							<span id="file-text"></span>
						</span>
					</div>
					<div class="map_box"></div>
					<span><button type="submit" id="submit-btn">펫시터 등록하기</button></span>
				</div>
		</div>
		<div class="ps_reg_form_popup_box">
			<p>펫시터 등록 신청이 완료되었습니다. </p>
			<button>확인</button>
		</div>

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
<!-- <script src="/doggybeta/resources/js/loginSource.js"></script> -->
</html>