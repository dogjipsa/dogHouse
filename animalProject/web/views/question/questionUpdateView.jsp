<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage='questionError.jsp'%>
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
<body background="/doggybeta/resources/images/puppies_1.2.jpg">
<%@ include file="../common/menu.jsp" %>
<div id="wrap">
<div id="cotent">
<br><br>
<h1 align="center" style="color:ivory;">1:1 문의글 수정 </h1>
<hr align="center" style="width:600px">
<br>
<form action="/doggybeta/qoriginup" method="post" enctype="multipart/form-data">
<table align="center" width="650">
	<input type="hidden" name="question_no" value="<%= question.getQuestionNo() %>">
	<tr>
		<th style=color:white;>제목</th>
		<td><input type="text" name="question_title" value="<%= question.getQuestionTitle() %>"></td>
	</tr>
	<tr>
		<th style=color:white;>내용</th>
		<td><textarea rows="5" cols="50" name="question_content"><%= question.getQuestionContent() %></textarea></td>
	</tr>	
	<tr>
		<th colspan="2">
		<button onclick="history.go(-1); return false;">뒤로가기</button>&nbsp;
		<input type="submit" value="수정하기">
		</th>		
	</tr>
</table>
</form>
<br>
</div></div>
</body>
</html>