<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import='manager.model.vo.Manager, java.util.ArrayList, countvisitor.model.vo.CountVisitor'%>
<%
	Manager loginManager = (Manager)session.getAttribute("loginmanager");
	CountVisitor cntlist = (CountVisitor)request.getAttribute("cntList");
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
	$('.manage').click(function(e) {
		e.preventDefault();
		$(this).toggleClass('submenu').next().slideToggle()
	});//click
	
	$.ajax({
		url: '/doggybeta/cntserve',
		type: 'post',
		success: function(data){
			console.log("성공 : "+data);
			var content = '오늘 방문회원 ['+data.cntToday+']';
			var contenty = '어제 방문회원 ['+data.cntYesterday+']';
			var contentt = '전체 방문회원 ['+data.cntTotal+']';
			$('#cntvisit2').val(contenty)
			$('#cntvisit').val(content);
			$('#cntvisit3').val(contentt);
		}
	})//ajax
});//ready
</script>
</head>
<body>
<% if(loginManager != null) { %>
<nav>
	<ul class='mVertical-menu'>
		<p>현재 로그인 된 관리자</p>
		<p><%= loginManager.getManagerName() %> 님</p>
		<%-- <%= cntList.size() %> --%>
		<li>
			<a href='/doggybeta/mDHLogout'><span class="logout"><i class="icon-signout"></i>Logout</span></a>
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
			<span class="manage"><i class="icon-cog"></i>게시판관리</span>
			<ul class='submenu'>
				<li>게시판 공지사항</li>
				<li><a href='/doggybeta/manboard'>자유게시판 관리</a></li>
				<li><a href='/doggybeta/manboard'>팁 게시판 관리</a></li>
				<li>신고 게시물 관리</li>
			</ul>
		</li>
		<li>
			<span class="manage" ><i class="icon-user"></i>회원관리</span>
			<ul class='submenu'>
				<li><a href="/doggybeta/mmsearch">전체 회원 관리</a></li>
				<li><a href='/doggybeta/mpsearch'>펫시터 관리</a></li>
				<li><a href="#">1:1문의 답변</a>

			</ul>
		</li>
	</ul>
</nav>
<input type='text' id='cntvisit' class='btn btn-3 btn-3c' readonly/>
<input type='text' id='cntvisit2' class='btn btn-3 btn-3c' readonly/>
<input type='text' id='cntvisit3' class='btn btn-3 btn-3c' readonly/>
<%-- <%@ include file="../views/manager/managerBoardsTop5.jsp"%> --%>
<!-- <div style="float:left;border:1px solid navy;padding:5px;margin:5px">
	<h4>인기 게시글</h4>
	<table id="toplist" border="1" cellspacing="0">
	<tr><th>번호</th><th width="200">제목</th><th>조회수</th></tr>
	</table>
</div> -->
<% } else { %>
<%@ include file="../views/manager/managerLogin.jsp"%>
<% } %>
</body>
</html>