<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="member.model.vo.Member"  %>
    
    <%
    Member loginUser = (Member)session.getAttribute("loginUser");
    %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first</title>
</head>
<body>
<h1>firstWebProjcet</h1>
<% if(loginUser != null && loginUser.getUserId().equals("admin")){ %>
	<%@ include file="views/common/adminHeader.jsp"%>
<% }else{ %>
	<%@ include file="views/common/header.jsp"%>
<% } %>
<hr style="clear:left;">
<% if(loginUser == null){  //로그인 하지 않은 상태%>
<div>
<form action="/first/login" method="post">
<table>
<tr>
<th>아이디 : </th>
<th><input type="text" name="userid" required></th>
</tr>
<tr>
<th>암   호 : </th>
<td><input type="password" name="userpwd" required></td>
</tr>
<tr>
	<th colspan="2">
		<input type="submit" value="로그인">
		&nbsp; &nbsp;
		<a href="/first/views/member/enroll.html">회원가입</a>
</th>
</tr>
<tr>
		<th colspan="2">
			<a href="">아이디찾기</a>
			&nbsp;  &nbsp;
			<a href="">암호찾기</a>
		</th>
</table>
</form>
</div>
<% }else{  //로그인 상태 처리%>
<div>
<form action="/first/login" method="post">
<table>
<tr>
<th><%= loginUser.getUserName() %> 님 </th>
<td><a href="/first/logout">로그아웃</a> </td>
</tr>
<tr>

	<th colspan="2">
		<a href="">쪽지</a>
		&nbsp; &nbsp;
		<a href="/first/myinfo?userid=<%= loginUser.getUserId()%>">내 정보 보기</a>
		<!-- a태그에 의한 요청은 get방식 -->
</th>
</tr>
<tr>

</table>
</form>
</div>
<%   } %>
<hr>
<%@ include file="views/common/footer.jsp" %>
</body>
</html>