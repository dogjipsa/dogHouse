<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import='manager.model.vo.Manager' %>
<%
	Manager loginManager = (Manager)session.getAttribute("loginmanager");
%>
<!DOCTYPE html>
<html id='managerMainPageBg'>
<head>
<meta charset="UTF-8">
<title>도그하우스</title>
<link rel="stylesheet" href="/doggybeta/resources/css/manager/managerLoginMenu.css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(function() {
	$('.boardManage').click(function(e) {
		e.preventDefault();
		$(this).toggleClass('submenu').next().slideToggle()
	});//click
});//ready
</script>
</head>
<body>
<nav>
	<ul class='mVertical-menu'>
		<p>현재 로그인 된 관리자</p>
		<p><%= loginManager.getManagerName() %> 님</p>
		<li>
			<span class="logout"><i class="icon-signout"></i>Logout</span>
		</li>
		<li><a href='/doggybeta/managerMainPage.jsp'>
			<span class="logout">
				<i class="icon-signout"></i>홈으로
			</span>
			</a>
		</li>
		<li class="selected">
			<span class="messages"><i class="icon-envelope-alt"></i>쪽지<em>5</em></span>
		</li>
		<li>
			<span class="boardManage"><i class="icon-cog"></i>게시판관리</span>
			<ul class='submenu'>
				<li>게시판 공지사항</li>
				<li><a href='/doggybeta/views/manager/managerAllBoard.jsp'>전체 게시판 조회 및 관리</a></li>
				<li>신고 게시물 관리</li>
			</ul>
		</li>
		<li>
			<span class="profile" ><i class="icon-user"></i>회원관리</span>
		</li>
	</ul>
</nav>
</body>
</html>