<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<nav>
		<label for='menu_state'><i class="fa"></i></label>
		<ul class='icon' id='icon'>
			<li><img id='logo' src='/doggybeta/resources/images/doglogo.png'
				width='80%' /> </li>
			<li id='icon1'><a href='#'> <span>홈</span> </a>
			</li>
			<li id='icon2' class="m1"><a href="#"><span>About us</span></a>
				<ul class="m2">
					<li>회사소개</li>
					<li>연혁</li>
					<li>팀 도그집사</li>
					<li>오시는 길</li>
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