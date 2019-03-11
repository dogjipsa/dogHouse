<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet" />
<link href="/doggybeta/resources/css/mainV2.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript"
	src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
</head>
<body>
<input type='checkbox' id='menu_state' checked />
<nav>
		<ul class='doghouse'>
			<li><a><span>doghouse</span></a></li>
		</ul>
		<button class='btn btn-1 btn-sign'>회원가입/로그인</button>
		<ul class='icon' id='icon'>
			<!-- <li><img id='logo' src='/doggybeta/resources/images/doglogo.png'
				width='80%' /><a><span>doghouse</span> </a></li> -->
			
			<li id='icon1'><a href='/doggybeta'> <span>홈</span> </a>
			</li>
			<li  class="m1"><a href="/doggybeta/views/aboutus/introduce.jsp" id='icon2'><span>&nbsp;&nbsp;&nbsp;About us</span></a>
				<ul class="m2">
					<li><a href="/doggybeta/views/aboutus/introduce.jsp">회사소개</a></li>
					<li><a>연혁</a></li>
					<li><a>팀 도그집사</a></li>
					<li><a>오시는 길</a></li>
				</ul>
			</li>
			<li id='icon3'><a href='#'> <span>펫시터 찾기</span></a>
			</a></li>
			<li id='icon4' class="m1"><a href='#'> <span>게시판</span>
			</a>
				<ul class="m2">
					<li>공지사항</li>
					<li>자유게시판</li>
					<li>팁</li>
				</ul></li>
			<li id='icon5' class="m1"><a href="#"> <span>고객센터</span></a>
				<ul class="m2">
					<li>FAQ</li>
					<li>이용방법</li>
					<li>1:1문의</li>
				</ul>
			</li>


			<li id='icon6' class="m1"><a href="#"><span>마이페이지</span></a>
				<ul class="m2">
					<li>정보수정</li>
					<li>이용내역/예약확인</li>
					<li>펫시터신청</li>
					<li>사전문의확인</li>
				</ul>
			</li>

		</ul>
		
		 <script type="text/javascript">
	$('.m1').hover(function() {
		if ($(this).children('.m2').is(':visible')) {
			$(this).children('.m2').slideUp(800);
		} else {
			
			$(this).children('.m2').slideDown(800);
			$('.fa').ready(function(){
				event.stopPropagation()
			});
		}

	});
	</script>
	</nav>
</body>
</html>