<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="member.model.vo.Member"%>
    
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first</title>
<style type="text/css">

input[type=submit]{
  width: 100%;
  background-color: #ffb366;
  color: white;
  padding: 5px 10px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
</style>
</head>
<body>
<h1>firstWebProject</h1>
<% if(loginUser != null && loginUser.getUserId().equals("admin")){%>
	<%@ include file="views/common/adminHeader.jsp"%>
<% }else{%>
	<%@ include file="views/common/header.jsp"%>
<%} %>
<hr style="clear:left">
<!-- 로그인 하지 않았을 때 보이게 div~/div까지-->
<% if(loginUser == null){ %>
<div>
<form action="login" method="post"> <!-- 상대 경로 사용, 컨트롤러로 보낼 때 action 사용 -->
<!-- 
1. get 방식 : url에 로그인 정보가 다 뜬다
2. post 방식: url에 mapping한 서블릿 네임이 뜬다-->
<!-- <form action="/first/login"> 이거는 절대 경로 사용 -->
<table>
<tr>
	<th>아이디 : </th>
	<td>
		<input type="text" name="userid" required>
	</td>
</tr>
<tr>
	<th>암  호 : </th>
	<td>
		<input type="password" name="userpwd" required> 
	</td>
</tr>
<tr>
	<th colspan="2">
		<input type="submit" value="로그인">
		&nbsp;&nbsp;
		<a href="/first/views/member/enroll.html">회원가입</a>
	</th>
</tr>
<tr>
	<th colspan="2">
		<a href="">아이디 찾기</a>
		&nbsp;&nbsp;
		<a href="">암호찾기</a>
	</th>
</tr>
</table>
</form>
</div>
<!-- 로그인 상태라면 -->
<%}else{%>
<div>
<table>
<tr>
	<th><%= loginUser.getUserName() %> 님</th>
	<td>
		<a href="/first/logout">로그아웃</a>
	</td>
</tr>

<tr>
	<th colspan="2">
		<a href="">쪽지 보기</a>
		&nbsp;&nbsp;
		<a href="/first/myinfo?userid=<%= loginUser.getUserId() %>">내 정보 보기</a>
		<!-- expression tag 출력 -->
		<!-- ? : 물음표부터는 query string -->
	</th>
</tr>
</table>
</div>
<% }%>

<hr><a><%@ include file="views/common/footer.jsp" %></a>
</body>
</html>