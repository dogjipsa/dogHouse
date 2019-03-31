<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="question.model.vo.Question" %>
<%
	Question question = (Question)request.getAttribute("question");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>doggybeta</title>
</head>
<body>
<hr style="clear:both;">
<h2 align="center"><%= question.getQuestionNo() %>번 1:1문의글 수정페이지</h2>
<br>
<form action="/doggybeta/qoriginup" method="post" enctype="multipart/form-data">
<!-- enctype="multipart/form-data" -->
<%-- <input type="hidden" name="no" value="<%= question.getQuestionNo() %>"> --%>
<table align="center" width="650">
	<%-- <tr>
		<th>번호</th>
		<td><input type="text" name="no" value="<%= question.getQuestionNo() %>"></td>
	</tr> --%>
	<tr>
		<th>제목</th>
		<td><input type="text" name="title" value="<%= question.getQuestionTitle() %>"></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="5" cols="50" name="content"><%= question.getQuestionContent() %></textarea></td>
	</tr>
	<%-- <tr>
		<th>작성자</th>	
		<td><input type="text" name="userid" value="<%= question.getUserId() %>" readonly></td>
	</tr> --%>	
	<tr>
		<th colspan="2">
		<button onclick="history.go(-1); return false;">뒤로가기</button>&nbsp;
		<input type="submit" value="수정하기">
		</th>		
	</tr>
</table>
</form>
<br>
</body>
</html>