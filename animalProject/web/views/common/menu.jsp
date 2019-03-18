<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member"%>

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
			<li><a href='#' id='icon3'> <span>&nbsp;&nbsp;&nbsp;펫시터
						찾기</span></a></li>
			<li class="m1"><a href='#' id='icon4'> <span>&nbsp;&nbsp;&nbsp;게시판</span>
			</a>
				<ul class="m2">
					<li><a href='#'>공지사항</a></li>
					<li><a href='#'>자유게시판</a></li>
					<li><a href='#'>팁</a></li>
				</ul></li>
			<li class="m1"><a href="#" id='icon5'> <span>&nbsp;&nbsp;&nbsp;고객센터</span></a>
				<ul class="m2">
					<li><a href='#'>FAQ</a></li>
					<li><a href='#'>이용방법</a></li>
					<li><a href='#'>1:1문의</a></li>
				</ul></li>

			<li class="m1"><a href="#" id='icon6'><span>&nbsp;&nbsp;&nbsp;마이페이지</span></a>
				<ul class="m2">
					<li><a href='#'>정보수정</a></li>
					<li><a href='#'>이용내역/예약확인</a></li>
					<li><a href="" id="pet_reg__btn">펫시터신청</a></li>
					<li><a href='#'>사전문의확인</a></li>
				</ul></li>
		</ul>
		
<%@ include file="../customerservice/psRegForm.jsp" %>

		<script type="text/javascript">
			$('.m1').hover(function() {
				if ($(this).children('.m2').is(':visible')) {
					$(this).children('.m2').slideUp(800);
				} else {
					$(this).children('.m2').slideDown(800);
				}
			});
		</script>
	</nav>
</body>
</html>